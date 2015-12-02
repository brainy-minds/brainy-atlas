from django.conf.urls import patterns, include, url
from django.contrib import admin
# from business.views import FacebookLogin


urlpatterns = patterns(
    '',
    url(r'^$', 'atlas.projects.views.index', name='index'),
    url(r'^accounts/login/$', 'django.contrib.auth.views.login'),
    url(r'^admin/', include(admin.site.urls)),
    # (r'^accounts/', include('registration.backends.simple.urls')),
    (r'^rest-auth/', include('rest_auth.urls')),
    # url(r'^rest-auth/facebook/$', FacebookLogin.as_view(), name='fb_login')
)
