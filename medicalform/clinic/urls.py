from django.urls import path , include
from clinic import views
from django.conf.urls import url
from account.views import logout_view

urlpatterns = [
    path('',views.dashboard_view, name='home'),
    path('send-email/',views.send_email_view,name='send_email_url'),
    path('add-doctor/',views.add_doctor_view,name='add_doctor_url'),
    path('doctor-list/',views.doctor_list_view,name='doctor_list_url'),
    # path('doctor-profile/<id>/',views.doctor_profile_view,name='doctor_profile_url'),
    path('patient-list/',views.patients_list_view,name='patients_list_url'),
    path('patient-details/<id>/',views.patient_details_view,name='patients_details_url'),
    path('medical-form/',views.medical_form_list_view,name='medical_form_list_url'),
    path('medical-form/<form_id>/',views.medical_form_view,name='medical_form_url'),
    path('logout/',logout_view, name='Logout'),
]





