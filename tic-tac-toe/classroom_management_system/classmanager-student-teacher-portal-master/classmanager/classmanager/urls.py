"""studentmanager URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from . import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('attendance/generated/', views.qr_code_generated, name='qr_code_generated'),
    path('attendance/view', views.scan_qr_code, name='scan_qr_code'),
    path('attendance/view/',views.view_attendance, name='view_attendance'),
    path('admin/', admin.site.urls),
    path('',views.HomePage.as_view(),name="home"),
    path('accounts/', include('django.contrib.auth.urls')),
    path('classroom/',include('classroom.urls')),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
