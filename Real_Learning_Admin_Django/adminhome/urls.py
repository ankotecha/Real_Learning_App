
from django.contrib import admin
from django.urls import path, include
from django.views.generic.base import TemplateView
from django.conf.urls import url
from adminhome.views import logout,deletetopic,coursetopicupdate,viewselectedtopic,viewtopic,deletecourse,viewselectedcourse,viewcourse,home,managecourse,course,courseupload,addquestionDB,login,uploadcoursecontent,courseupdate,addQuestion,coursecontentupdate



urlpatterns = [

	# path('login/',TemplateView.as_view(template_name='login.html'),name='login_page'),
    # path('admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')),
    path('header/',TemplateView.as_view(template_name='header.html'),name='header'),
    url('base/',TemplateView.as_view(template_name='base.html'), name='base'),
    path('', TemplateView.as_view(template_name='home.html'), name='home'), # new
    url(r'^home/$',home,name='home_page'),
    url(r'^viewselectedtopic/$',viewselectedtopic,name='viewselectedtopic'),
    url(r'^managecourse/$',managecourse,name='managecourse'),
    url(r'^course/$',course,name='course'),
	url(r'^courseupload/$',courseupload,name='courseupload'),
	url(r'^login/$',login,name='login'),
    url(r'^courseupdate/$',courseupdate,name='courseupdate'),
    url(r'^uploadcoursecontent/$',uploadcoursecontent,name='uploadcoursecontent'),
    url(r'^addQuestion/$',addQuestion,name='addQuestion'),
    url(r'^addquestionDB/$',addquestionDB,name='addquestionDB'),
    url(r'^coursecontentupdate/$',coursecontentupdate,name='coursecontentupdate'),
    url(r'^coursetopicupdate/$',coursetopicupdate,name='coursetopicupdate'),
    url(r'^viewcourse/$',viewcourse,name='viewcourse'),
    url(r'^viewtopic/$',viewtopic,name='viewtopic'),
    url(r'^deletecourse/$',deletecourse,name='deletecourse'),
    url(r'^viewselectedcourse/$',viewselectedcourse,name='viewselectedcourse'),
    url(r'^deletetopic/$',deletetopic,name='deletetopic'),
    url(r'^logout/$',logout,name='logout'),





]