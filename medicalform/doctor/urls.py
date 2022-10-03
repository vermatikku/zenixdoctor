from django.urls import path , include
from . import views
from django.conf.urls import url
from account.views import logout_view

urlpatterns = [
    path('',views.dashboard, name='Home'),
    path('patient-list/',views.patient_list_view, name='Home'),
    path('logout/',logout_view, name='Logout'),
]