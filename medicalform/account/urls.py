from django.urls import path , include
from . import views
from business import views as businessviews
from clinic import views as clinicviews
from doctor import views as doctorviews
from patient import views as patientviews
from assistant import views as assistantviews
from receptionist import views as receptionistviews
from django.conf.urls import url
from django.conf.urls import url
from django.contrib.auth import views as auth_views
urlpatterns = [
	path('',views.home_view, name='Home'),
	path('login/',views.login_view, name='Login'),
	path('google_auth_login/',views.google_auth_login,name = 'google_auth'),
	path('logout/',views.logout_view, name='Logout'),
	url('', include('social_django.urls', namespace='social')),
	#url('^', include('django.contrib.auth.urls')),
	url(r'^reset/$',
    auth_views.PasswordResetView.as_view(
        template_name='password_reset_form.html',
        email_template_name='password_reset_email.html',
        subject_template_name='password_reset_subject.txt'
    ),
    name='password_reset'),

	path('reset/<uidb64>/<token>/',
        auth_views.PasswordResetConfirmView.as_view(template_name = 'password_reset_confirm.html'), name='password_reset_confirm'),

	url(r'^reset/done/$',
    auth_views.PasswordResetDoneView.as_view(template_name='password_reset_done.html'),
    name='password_reset_done'),

	url(r'^reset/complete/$',
    auth_views.PasswordResetCompleteView.as_view(template_name='password_reset_complete.html'),
    name='password_reset_complete'),
	#path('forgot-password/',views.forgot_password, name='Forgot_Password'),
	#path('recover-password/',views.recover_password, name='Recover_Password'),
	#path('ajax/change-password/',views.change_password, name = 'changePassword'),
	#path('reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/', views.password_change, name = "password_change"),
	path('availability/<uname>/',views.check_username_availability, name='user_name_availability_url'),
	path('email-availability/<email>/',views.check_email_availability, name='email_name_availability_url'),
	# path('logout/',views.logout_view, name='Logout'),
	url(r'^ajax/validate_username/$',patientviews.validate_username, name = "validate_username"),
	url(r'^ajax/login_validate_username/$', views.login_validate_username, name = "login_validate_username"),
	url(r'^ajax/validate_password/$', clinicviews.validate_password, name = "validate_password"),
	path('register/',patientviews.register, name='Register'),
	path('activate-profile/<uidb64>/<token>/',patientviews.activate_view, name='activate_url'),
	path('create-profile/<uidb64>/<token>/',patientviews.first_time_login_view, name='first_time_login_url'),
	path('dashboard/',patientviews.dashboard, name='activate_url'),
	path('medical-form-list/',patientviews.medical_form_list, name='patient_medical_form_list'),
	path('<clinicname>/',clinicviews.dashboard_view,name='clinic_home_url'),
	# path('<clinicname>/clinic-admin/',clinicviews.clinic_admin_view,name='clinic_admin_url'),
	# path('<clinicname>/clinic-profile/',clinicviews.clinic_profile_view,name='clinic_profile_url'),
	path('<clinicname>/doctor/',clinicviews.doctor_list_view,name='clinic_doctor_url'),
	path('<clinicname>/doctor/<doctoruname>/',clinicviews.doctor_details_view,name='clinic_doctor_details_url'),
	path('<clinicname>/add-doctor/',clinicviews.add_doctor_view,name='clinic_add_doctor_url'),
	path('<clinicname>/patient/',clinicviews.patients_list_view,name='clinic_patient_url'),
	path('<clinicname>/patient/<patientuname>/',clinicviews.patient_details_view,name='clinic_patient_details_url'),
	path('<clinicname>/add-patient/',clinicviews.add_patient_view,name='clinic_add_patient_url'),
	path('<clinicname>/medical-form/',clinicviews.medical_form_list_view,name='clinic_medical_form_url'),
	path('<clinicname>/medical-form/<form_id>/',clinicviews.medical_form_view,name='clinic_medical_form_details_url'),
	path('<clinicname>/patient-form/<form_id>/',clinicviews.patient_form,name='clinic_patient_form_details_url'),
	path('<clinicname>/assistants/',clinicviews.assistant_list_view,name='clinic_assistant_url'),
	path('<clinicname>/assistant/<assistantuname>/',clinicviews.assistant_details_view,name='clinic_assistant_details_url'),
	path('<clinicname>/receptionists/',clinicviews.receptionist_list_view,name='clinic_receptionist_url'),
	path('<clinicname>/receptionist/<receptionistuname>/',clinicviews.receptionist_details_view,name='clinic_receptionist_details_url'),
	# assistantviews
	path('<clinicname>/clinic-assistant/',assistantviews.dashboard_view,name='assistant_dashboard_url'),
	# receptionistviews
	path('<clinicname>/clinic-receptionist/',receptionistviews.dashboard_view,name='receptionist_dashboard_url'),

]
