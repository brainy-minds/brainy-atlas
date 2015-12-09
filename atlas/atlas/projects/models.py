import os
from django.db import models
from brainy.config import load_brainy_config
from brainy.project.base import BrainyProject
from brainy.project.manager import ProjectManager
from brainy.project.session import load_or_create_session

BRAINY_USER_PATH = os.path.expanduser('~/.brainy')


class RegisteredProjects(object):

    def __init__(self):
        project_list_path = os.path.join(BRAINY_USER_PATH, 'project_list.yaml')
        self.project_manager = ProjectManager(project_list_path)
        self.brainy_config = load_brainy_config()

    def get_list(self):
        '''
        A proxy to get a list of dictionaries describing projects
        (no caching).
        '''
        self.project_manager.load_projects()
        return [project for project in self.project_manager.projects]

    def load_session_tasks(self, project_path):
        project_name = os.path.basename(project_path)
        project = BrainyProject(project_name, project_path, self.brainy_config)
        # Load session without creating it (read-only).
        session = load_or_create_session(
            project.session_folder_path,
            project.session_db_url,
            create=False,
        )
        return [task for task in session.iter_workflow()]
