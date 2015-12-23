import os
from django.db import models
from gc3libs.workflow import TaskCollection
from brainy.config import load_brainy_config
from brainy.project.base import BrainyProject
from brainy.project.gc3pie import YamlTaskCollection, job_has_failed
from brainy.project.manager import ProjectManager
from brainy.project.session import load_or_create_session
from atlas.projects.errors import ProjectViewError

BRAINY_USER_PATH = os.path.expanduser('~/.brainy')


class RegisteredProjects(object):

    def __init__(self):
        project_list_path = os.path.join(BRAINY_USER_PATH, 'project_list.yaml')
        self.project_manager = ProjectManager(project_list_path)
        self.brainy_config = load_brainy_config()

    def get_list(self):
        '''
        A proxy to get a list of dictionaries describing projects
        (no caching). Add unique ids on the way.
        '''
        self.project_manager.load_projects()
        next_id = 1
        result = list()
        for project in self.project_manager.projects:
            project['id'] = next_id
            next_id += 1
            result.append(project)
        return result

    def load_session(self, project_path):
        '''Load and return a gc3pie session object'''
        project_name = os.path.basename(project_path)
        project = BrainyProject(project_name, project_path, self.brainy_config)
        # Load session without creating it (read-only).
        session = load_or_create_session(
            project.session_folder_path,
            project.session_db_url,
            create=False,
        )
        return session

    def load_session_tasks(self, project_path):
        '''Return all tasks in gc3pie session'''
        session = self.load_session(project_path)
        return [task for task in session.iter_workflow()]

    def get_task_tree(self, project_path, max_level=1, level_depth=0,
                      task_collection=None):
        '''
        Recursively walk and return tasks not deeper than the level defined
        by depth. The result is a tree in form of list of lists. Each sub list
        corresponds to a sub tasks.
        '''
        # Break out of recursion.
        if level_depth > max_level:
            return
        if task_collection is None:
            # Load session for the first time.
            session = self.load_session(project_path)
            # The very first entry in brainy session is always a single
            # task of type YamlTaskCollection - subclass of TaskCollection.
            task_collection = session.tasks.values()[0]
            assert isinstance(task_collection, YamlTaskCollection)
        # Split collection tasks from non-collection.
        tree = list()
        for task in task_collection.tasks:
            node = {
                'task': task,
                'level': level_depth,
                'state': task.execution.state
            }
            if task.execution.state == 'TERMINATED' \
                    and job_has_failed(task):
                node['state'] = 'FAILED'
            if isinstance(task, TaskCollection):
                sub_tree = self.get_task_tree(project_path,
                                              max_level=max_level,
                                              level_depth=level_depth+1,
                                              task_collection=task)
                if sub_tree is not None and len(sub_tree) > 0:
                    node['tree'] = sub_tree
            tree.append(node)
        return tree

    def find_project(self, project_id):
        ''' Find project by id. '''
        found_project = None
        for project in self.get_list():
            if project['id'] == project_id:
                found_project = project

        if found_project is None:
            ProjectViewError('Failed to find project with id: %s' % project_id)

        return found_project
