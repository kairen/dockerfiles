from django.conf.urls import patterns, include, url
from view import quotas_usage

urlpatterns = patterns('',
    (r'^quotas/(?P<project_id>\S+)/(?P<resource>\S+)/$', quotas_usage)
    # Examples:
    # url(r'^$', 'log.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),
)
