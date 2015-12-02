from django.shortcuts import render
import json
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.decorators import login_required

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from allauth.socialaccount.providers.facebook.views import FacebookOAuth2Adapter
# from rest_auth.registration.views import SocialLogin


# Create your views here.
# class FacebookLogin(SocialLogin):
class FacebookLogin(object):
    adapter_class = FacebookOAuth2Adapter


# @login_required
def index(request):
    context = {}
    return render(request, 'projects/list.tpl', context)

