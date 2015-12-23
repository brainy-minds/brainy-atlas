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


# Create your views here.
# class FacebookLogin(SocialLogin):
class FacebookLogin(object):
    adapter_class = FacebookOAuth2Adapter


def map_color_cls(task_status):
    if task_status == 'FAILED':
        return 'red'
    elif task_status == 'TERMINATED':
        return 'green'
    return ''  # Default is blue.


def map_text_cls(task_status):
    color = map_color_cls(task_status)
    if len(color) > 0:
        return '%s-text' % color
    return ''  # Default is blue.


# @login_required
def list_projects(request):
    reg_projects = RegisteredProjects()
    project_list = list()
    errors = list()
    for project in reg_projects.get_list():
        try:
            project['id'] = int(project['id'])
            project['status_cls'] = map_text_cls(project['status'])
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
            task_tree = reg_projects.get_task_tree(project['path'])
            project = {
                'name': project['name'],
                'path': project['path'],
                'task_tree': task_tree,
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
