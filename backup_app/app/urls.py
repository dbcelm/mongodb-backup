# backup/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('trigger_backup/', views.trigger_backup, name='trigger_backup'),
]
