from django.shortcuts import render
import json
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.decorators import login_required
from atlas.projects.models import RegisteredProjects
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from allauth.socialaccount.providers.facebook.views import FacebookOAuth2Adapter
# from rest_auth.registration.views import SocialLogin

from brainy.errors import BrainyProjectError
from atlas.projects.errors import ProjectViewError

# Create your views here.
# class FacebookLogin(SocialLogin):
class FacebookLogin(object):
    adapter_class = FacebookOAuth2Adapter


# @login_required
def list_projects(request):
    reg_projects = RegisteredProjects()
    project_list = list()
    errors = list()
    for project in reg_projects.get_list():
        try:
            project = {
                'id': int(project['id']),
                'name': project['name'],
                'path': project['path'],
                'tasks': reg_projects.load_session_tasks(project['path']),
            }
        except BrainyProjectError as project_error:
            # Report error endowed with the project.
            errors.append({
                'msg': str(project_error),
                'project': project,
            })
            continue
        project_list.append(project)
    context = {
        'error_list': errors,
        'project_list': project_list,
    }
    return render(request, 'projects/list.tpl', context)


def details(request, project_id):
    project_id = int(project_id)
    errors = list()
    project = None
    reg_projects = RegisteredProjects()

    # Get project
    try:
        project = reg_projects.find_project(project_id)
    except BrainyProjectError as project_error:
        errors.append({
                'msg': str(),
                'project': project,
            })

    # Get project's tasks
    if project is not None:
        try:
            project = {
                'name': project['name'],
                'path': project['path'],
                'tasks': reg_projects.load_session_tasks(project['path']),
            }
        except BrainyProjectError as project_error:
            # Report error endowed with the project.
            errors.append({
                'msg': str(project_error),
                'project': project,
            })

    context = {
        'error_list': errors,
        'project': project,
    }
    return render(request, 'projects/details.tpl', context)
