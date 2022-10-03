from django.shortcuts import render,redirect
from django.contrib.auth import authenticate,logout
from django.contrib.sites.shortcuts import get_current_site

from django.contrib.auth.decorators import login_required
from account.decorators import allowed_users

from .models import ClinicProfile,ClinicAdmin,MedicalForm,MedicalFormAndAttributeRelation
from patient.models import PatientProfile
from django.contrib.auth.models import User
from doctor.models import DoctorProfile,DoctorClinicRelation
from patient.models import PatientProfile,MedicalFormAttributeFilled
from assistant.models import AssistantProfile
from receptionist.models import ReceptionistProfile

from django.core.mail import send_mail,EmailMessage,EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.urls import reverse
from patient.tokens import account_activation_token
from django.conf import settings
from django.http import HttpResponse
from django.contrib.auth.hashers import check_password

import time
import datetime
from django.http import JsonResponse
# Create your views here.
@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def dashboard_view(request,*args,**kargs):
	clinicadmin = ClinicAdmin.objects.get(user = request.user)
	if request.POST:
		clinicadmin = ClinicAdmin.objects.get(user = request.user)
		clinic_name = request.POST.get("clinic_name")
		clinic_address = request.POST.get("clinic_address")
		clinic_description = request.POST.get("clinic_description")
		# ClinicAdmin.objects.get(user=request.user).
		clinicadmin.clinic.name=clinic_name
		clinicadmin.clinic.addresses=clinic_address
		clinicadmin.clinic.clinic_description=clinic_description
		clinicadmin.save()
	clinic = clinicadmin.clinic
	context={
		'user_profile_pic':'user_default_pic.png',
		'clinic_name':clinic.name,
		'clinic_specilities':'Dentist',
		'clinic_description':clinic.clinic_description,
		'clinic_address':clinic.addresses,
		'clinic_rating':'',
		'total_reviewer':'',
		# 'reviews':
		# 	[
		# 		{
		# 			'name':'Jonathan Burke Jr.',
		# 			'profile_pic':'user_default_pic.png',
		# 			'star_rating':'4',
		# 			'review_desc':'Lorem ipsum represents a long-held tradition for designers, typographers and the like. Some people hate it and argue for its demise, but others ignore the hate as they create awesome tools to help create filler text for everyone from bacon lovers to Charlie Sheen fans.',
		# 		},
		# 		{
		# 			'name':'Robert Downey, Jr.',
		# 			'profile_pic':'user_default_pic.png',
		# 			'star_rating':'5',
		# 			'review_desc':'Lorem ipsum represents a long-held tradition for designers, typographers and the like. Some people hate it and argue for its demise, but others ignore the hate as they create awesome tools to help create filler text for everyone from bacon lovers to Charlie Sheen fans.',
		# 		},
		# 	]
	}
	return render(request,'clinic/dashboard.html',context)

def profile_view(request,*args,**kargs):
	return HttpResponse('profile of admin')

@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def add_doctor_view(request,*args,**kargs):
	context = {}
	clinic_name = ClinicAdmin.objects.get(user = request.user).clinic
	if request.POST:
		full_name = request.POST.get("full_name").split()
		i = 0
		last_name = ''
		for name_user in full_name:
			if(name_user==full_name[0]):
				first_name = name_user
			else:
				if i==1:
					last_name=name_user
				else:
					last_name = last_name+" "+name_user
			i = i + 1
		phone_no = request.POST.get("phone_no")
		email = request.POST.get("email")
		try:
			user = User.objects.get(email=email)
			context = {'error':'email already exist'}
			return render(request,'clinic/add_doctor.html',context)
		except User.DoesNotExist:
			user = User.objects.create(username=email,first_name=first_name,last_name=last_name,email=email,is_active=False)
			user.set_password(time.time().__str__())
			user.save()
			doctor_1 = DoctorProfile.objects.create(user = user)
			doctor_1.clinic_profile.add(clinic_name)
		context={'success':'doctor created successfully'}
	return render(request,'clinic/add_doctor.html',context)

def send_email_view(request,*args,**kargs):
	context={}
	return render(request,'clinic/send_email.html',context)

def doctor_list_view(request,*args,**kargs):
	doctors = DoctorProfile.objects.all()
	context = {
			'user_profile_pic':'user_default_pic.png',
			'doctors':doctors,
		}
	return render(request,'clinic/doctor_list.html',context)

def doctor_details_view(request,*args,**kargs):
	doctor = DoctorProfile.objects.get(user__username=kargs['doctoruname'])
	if request.POST:
		doc_name = request.POST.get("doc_name").split()
		doc_password = request.POST.get("doc_password")
		doc_description = request.POST.get("doc_description")
		i = 0
		last_name = ''
		for name_user in doc_name:
			if(name_user==doc_name[0]):
				first_name = name_user
			else:
				if i==1:
					last_name=name_user
				else:
					last_name = last_name+" "+name_user
			i = i + 1
		doctor.user.first_name = first_name
		doctor.user.last_name = last_name
		doctor.description = doc_description
		if doc_password != '':
			# DoctorProfile.objects.filter(user__username=kargs['doctoruname']).update(description = doc_description,
			# 							user.first_name = first_name,
			# 							user.last_name = last_name
			# 							)
			doctor.user.set_password(doc_password)
			doctor.save()
		else:
			doctor.save()
			pass
		# doctor.save()
	context = {
		'doctor_profile_pic':doctor.profile_pic,
		'doctor_description':doctor.description,
		'doctor_name':doctor.user.first_name+' '+doctor.user.last_name,
		'clinic_description':'Expression Dental'
	}
	# context={}
	return render(request,'clinic/doctor_profile.html',context)

def patients_list_view(request,*args,**kargs):
	#apply real filter
	patients = PatientProfile.objects.all()
	clinic_name = ClinicAdmin.objects.get(user = request.user).clinic
	if request.POST:
		if request.POST.get("create_patient"):
			full_name = request.POST.get("full_name").split()
			last_name = ''
			i = 0
			for name_user in full_name:
				if(name_user==full_name[0]):
					first_name = name_user
				else:
					if i==1:
						last_name=name_user
					else:
						last_name = last_name+" "+name_user
				i = i + 1
			phone_no = request.POST.get("phone_no")
			email = request.POST.get("email")
			dob = request.POST.get("dob")
			try:
				user = User.objects.get(email=email)
				context = {'error':'email already exist','patients':patients}
				return render(request,'clinic/patient_list.html',context)
			except User.DoesNotExist:
				user = User.objects.create(username=email,first_name=first_name,last_name=last_name,email=email,is_active=False)
				user.set_password(time.time().__str__())
				user.save()
				patient_1 = PatientProfile.objects.create(user=user,dob=dob,phone=phone_no)
				patient_1.clinic_profile.add(clinic_name)
				mail_subject = 'Activate Patient History Account'
				current_site = get_current_site(request)
				uidb64 = urlsafe_base64_encode(force_bytes(user.pk))
				token = account_activation_token.make_token(user)
				domain = current_site.domain
				link = reverse('first_time_login_url',kwargs = {'uidb64':uidb64,'token':token})
				activate_link = 'http://'+ domain+link
				paramaters_for_mail =  {
					'name': first_name + ' ' + last_name,
					'domain':current_site.domain,
					'uid':urlsafe_base64_encode(force_bytes(user.pk)),
					'token':account_activation_token.make_token(user),
					'activate_link':activate_link,
				}
				message = render_to_string('patient/welcome_email.html',paramaters_for_mail)
				to_email = email
				msg = EmailMultiAlternatives(mail_subject,message, settings.EMAIL_HOST_USER, [to_email])
				msg.attach_alternative(message, "text/html")
				msg.send()
				context={'success':'Patient created successfully','patients':patients}
		if request.POST.get("send_form"):
			user_names = request.POST.getlist("username[]")
			medical_forms = request.POST.getlist("medical_forms[]")
			current_site = get_current_site(request)

			if user_names and medical_forms:
				list_form = []
				for medical_form in medical_forms:
					#if list_form == ''
					list_form.append(MedicalForm.objects.get(id=medical_form))
					#else:
						#list_form = list_form +' '+ str(MedicalForm.objects.get(id=medical_form))
				for user_name in user_names:
					user = User.objects.get(username = user_name)
					#current_site = get_current_site(request)

					uidb64 = urlsafe_base64_encode(force_bytes(user.pk))
					token = account_activation_token.make_token(user)
					print(uidb64)

					print(token)
					print(user.pk)
					#domain = current_site.domain
					#link = reverse('clinic_medical_form_details_url', kwargs = {'clinicname':kargs['clinicname']})
					#activate_link = 'http://' + domain + link
					paramaters_for_mail =  {
						'name': user_name,
						'all_forms':list_form,
						'clinicname':kargs['clinicname'],
						'domain': current_site.domain,
						#'uidb': uidb64,
						#'tokenize':token,
						#'activate_link':activate_link,


					}
					message = render_to_string('clinic/form.html',paramaters_for_mail)
					print(message)
					to_email = user_name
					mail_subject = 'Forms Received From Expression Dental'
					msg = EmailMultiAlternatives(mail_subject,message, settings.EMAIL_HOST_USER, [to_email])
					msg.attach_alternative(message, "text/html")
					print(msg)
					msg.send()
					continue

	user_full_details = ClinicAdmin.objects.get(user = request.user)
	all_medical_form = MedicalForm.objects.filter(clinic=user_full_details.clinic)
	context = {'all_medical_form':all_medical_form,'patients':patients}
	return render(request,'clinic/patient_list.html',context)

def add_patient_view(request,*args,**kargs):
	context={}
	return render(request,'clinic/patient_details.html',context)

def patient_details_view(request,*args,**kargs):
	username = kargs['patientuname']
	patient = PatientProfile.objects.get(user__username=username)
	name = patient.user.first_name.__str__() + ' ' + patient.user.last_name.__str__()
	dob = patient.dob
	phone = patient.phone
	gender = 'Male'#patient.user
	address = patient.address
	home_contact = patient.home_contact
	email = patient.user.email
	postalcode = patient.postalcode
	work_contact = patient.work_contact
	context={
			'user_profile_pic':'user_default_pic.png',
			'name':name,
			'dob':dob,
			'phone':phone,
			'gender':gender,
			'address':address,
			'home_contact':home_contact,
			'email':email,
			'postalcode':postalcode,
			'work_contact':work_contact,
		}
	return render(request,'clinic/patient_details.html',context)

@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def medical_form_list_view(request,*args,**kargs):
	if request.POST:
		clinic_name = ClinicAdmin.objects.get(user = request.user).clinic
		full_name = request.POST.get("full_name")
		email = request.POST.get("email")
		form = request.POST.get("form_id")

		print(form)
		list_form = MedicalForm.objects.filter(id = form).all()
		if full_name:
			full_name = full_name .split()
			i = 0
			last_name = ''
			for name_user in full_name:
				if(name_user==full_name[0]):
					first_name = name_user
				else:
					if i==1:
						last_name=name_user
					else:
						last_name = last_name+" "+name_user
				i = i + 1
			dob = request.POST.get("dob")
			try:
				user = User.objects.get(email=email)
				context = {'error':'email already exist','patients':patients}
				return render(request,'clinic/patient_list.html',context)
			except User.DoesNotExist:
				user = User.objects.create(username=email,first_name=first_name,last_name=last_name,email=email,is_active=False)
				user.set_password(time.time().__str__())
				user.save()
				patient_1 = PatientProfile.objects.create(user=user,dob=dob)
				patient_1.clinic_profile.add(clinic_name)
				mail_subject = 'Activate Patient History Account'
				current_site = get_current_site(request)
				uidb64 = urlsafe_base64_encode(force_bytes(user.pk))
				token = account_activation_token.make_token(user)
				domain = current_site.domain
				link = reverse('first_time_login_url',kwargs = {'uidb64':uidb64,'token':token})
				activate_link = 'http://'+ domain+link
				paramaters_for_mail =  {
					'name': first_name + ' ' + last_name,
					'domain':current_site.domain,
					'uid':urlsafe_base64_encode(force_bytes(user.pk)),
					'token':account_activation_token.make_token(user),
					'activate_link':activate_link,
				}
				message = render_to_string('patient/welcome_email.html',paramaters_for_mail)
				to_email = email
				msg = EmailMultiAlternatives(mail_subject,message, settings.EMAIL_HOST_USER, [to_email])
				msg.attach_alternative(message, "text/html")
				msg.send()
		else:
			paramaters_for_mail =  {
						'name': 'Patient',
						'all_forms':list_form,
						'domain':get_current_site(request).domain,
						'clinicname':kargs['clinicname']
					}
			message = render_to_string('clinic/form.html',paramaters_for_mail)
			to_email = email
			mail_subject = 'Forms Received From Expression Dental'
			msg = EmailMultiAlternatives(mail_subject,message, settings.EMAIL_HOST_USER, [to_email])
			msg.attach_alternative(message, "text/html")
			msg.send()
			# mail_subject = 'Medical form from zenixspace'
			# message = 'doctor have refered a medical form please login and submit for further'
			# # message = email
			# to_email = email
			# msg = EmailMultiAlternatives(mail_subject,message, settings.EMAIL_HOST_USER, [to_email])
			# msg.attach_alternative(message, "text/html")
			# msg.send()
		#assign form to user
		patient = PatientProfile.objects.get(user__email=email)
		form_id = request.POST.get("form_id")
		attributes = MedicalFormAndAttributeRelation.objects.filter(form__id = form_id)
		for attribute in attributes:
			medical_form = MedicalFormAttributeFilled.objects.create(filled_value=' ',form_attribute_rel=attribute,patient=patient)
			medical_form.save()
	user_full_details = ClinicAdmin.objects.get(user = request.user)
	all_medical_form = MedicalForm.objects.filter(clinic=user_full_details.clinic)
	context= {'all_medical_form':all_medical_form,'clinicname':kargs['clinicname']}
	# context={}
	return render(request,'clinic/all_medical_form.html',context)

@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def medical_form_view(request,*args,**kargs):
	form_id = kargs['form_id']
	user_full_details = ClinicAdmin.objects.get(user = request.user)
	medical_form = MedicalForm.objects.get(clinic=user_full_details.clinic,id=form_id)
	form_path = medical_form.form_path
	template_path = 'clinic/from/'+form_path

	context = {}
	return render(request,template_path ,context)

@allowed_users(allowed_roles = ['patients'])
@login_required(login_url = '/login/')
def patient_form(request,*args,**kargs):
	form_id = kargs['form_id']
	user_full_details = PatientProfile.objects.get(user = request.user)
	if(user_full_details.is_email_validated == 'Y'):
		medical_form = MedicalForm.objects.get(id = form_id)
		form_path = medical_form.form_path
		template_path = 'clinic/patient_form/' + form_path

		return render(request, template_path)

@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def assistant_list_view(request,*args,**kargs):
	assistants = AssistantProfile.objects.all()
	if request.POST:
		full_name = request.POST.get("full_name").split()
		last_name = ''
		i = 0
		for name_user in full_name:
			if(name_user==full_name[0]):
				first_name = name_user
			else:
				if i==1:
					last_name=name_user
				else:
					last_name = last_name+" "+name_user
			i = i + 1
		phone_no = request.POST.get("phone_no")
		email = request.POST.get("email")
		password = request.POST.get("password")
		try:
			user = User.objects.get(email=email)
			context = {'error':'email already exist','assistants':assistants}
			return render(request,'clinic/assistant_list.html',context)
		except User.DoesNotExist:
			clinic_profile = ClinicAdmin.objects.get(user=request.user).clinic
			user = User.objects.create(username=email,first_name=first_name,last_name=last_name,email=email,is_active=True)
			user.set_password(password)
			user.save()
			assistent_1 = AssistantProfile.objects.create(user=user,clinic_profile=clinic_profile,joining_date=datetime.date.today(),phone=phone_no)
			context={'success':'Patient created successfully','assistants':assistants}
			return render(request,'clinic/assistant_list.html',context)
	context = {'assistants':assistants}
	return render(request,'clinic/assistant_list.html',context)

@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def assistant_details_view(request,*args,**kargs):
	assistant = AssistantProfile.objects.get(user__username=kargs['assistantuname'])
	assistants = AssistantProfile.objects.all()
	if assistant.user.is_active:
		act_btn = 'Deactivate'
	else:
		act_btn = 'Activate'
	context = {
		'act_btn':act_btn,
		'user_profile_pic':assistant.profile_pic ,
		'name':assistant.user.first_name+ ' ' + assistant.user.last_name,
		'email':assistant.user.email,
		'phone':assistant.phone,
		'joining_date':assistant.joining_date
	}
	if request.POST:
		clinic_name = ClinicAdmin.objects.get(user = request.user).clinic
		if(request.POST.get("create_doctor")):
			full_name = request.POST.get("full_name").split()
			i = 0
			last_name = ""
			for name_user in full_name:
				if(name_user == full_name[0]):
					first_name = name_user
				else:
					if(i == 1):
						last_name = name_user
					else:
						last_name = last_name + " " + name_user
				i += 1
			phone_no = request.POST.get("phone_no")
			assistantEmail = request.POST.get("assistantEmail")
			email = request.POST.get('email')
			assistantName = request.POST.get("assistantName")
			password = request.POST.get("password")


			user = User.objects.get(username = assistantEmail)
			if(not check_password(password, user.password) and user):
				context['error'] = 'Sorry'
				context['assistants'] = assistants
				return render(request, 'clinic/assistant_details.html',context)
			else:
				d_user = User.objects.create(username = email, first_name = first_name, last_name = last_name,email = email, is_active = False)
				d_user.set_password(time.time().__str__())
				d_user.save()
				doctor_1 = DoctorProfile.objects.create(user = d_user)
				doctor_1.clinic_profile.add(clinic_name)
				context['success'] = 'Doctor profile created successfully'
				context['assistants'] = assistants
				return render(request,'clinic/assistant_details.html',context)


		if request.POST.get("Deactivate"):
			if assistant.user.is_active:
				User.objects.filter(username = kargs['assistantuname']).update(is_active=False)
			else:
				User.objects.filter(username = kargs['assistantuname']).update(is_active=True)
		else:
			if request.POST.get("full_name"):
				full_name = request.POST.get("full_name").split()
				last_name = ''
				i = 0
				for name_user in full_name:
					if(name_user==full_name[0]):
						first_name = name_user
					else:
						if i==1:
							last_name=name_user
						else:
							last_name = last_name+" "+name_user
					i = i + 1
				User.objects.filter(username = kargs['assistantuname']).update(first_name=first_name,last_name=last_name)
			if request.POST.get('password'):
				user = User.objects.get(username = kargs['assistantuname'])
				user.set_password(request.POST.get('password'))
				user.save()
			if request.POST.get('phone'):
				AssistantProfile.objects.filter(user__username=kargs['assistantuname']).update(phone=request.POST.get('phone'))

	return render(request,'clinic/assistant_details.html',context)
	pass

@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def receptionist_list_view(request,*args,**kargs):
	receptionists = ReceptionistProfile.objects.all()
	if request.POST:
		full_name = request.POST.get("full_name").split()
		last_name = ''
		i = 0
		for name_user in full_name:
			if(name_user==full_name[0]):
				first_name = name_user
			else:
				if i==1:
					last_name=name_user
				else:
					last_name = last_name+" "+name_user
			i = i + 1
		phone_no = request.POST.get("phone_no")
		email = request.POST.get("email")
		password = request.POST.get("password")
		try:
			user = User.objects.get(email=email)
			context = {'error':'email already exist','receptionists':receptionists}
			return render(request,'clinic/receptionist_list.html',context)
		except User.DoesNotExist:
			clinic_profile = ClinicAdmin.objects.get(user=request.user).clinic
			user = User.objects.create(username=email,first_name=first_name,last_name=last_name,password = make_password(password),email=email,is_active=True)
			#user.set_password(password)
			user.save()
			assistent_1 = ReceptionistProfile.objects.create(user=user,clinic_profile=clinic_profile,joining_date=datetime.date.today(),phone=phone_no)
			context={'success':'Receptionist created successfully','receptionists':receptionists}
			return render(request,'clinic/receptionist_list.html',context)
	receptionists = ReceptionistProfile.objects.all()
	context = {'receptionists':receptionists}
	return render(request,'clinic/receptionist_list.html',context)

def validate_password(request):


	email = request.GET.get('receptionistEmail')
	password = request.GET.get('password')
	print(email)
	print(password)
	user = User.objects.get(username = email)

	print(check_password(password,user.password))
	if(not check_password(password,user.password)):
		data = {
			'not_valid' : "Password is not correct"
		}
	else:
		data = {}


	return JsonResponse(data)


@allowed_users(allowed_roles=['clinic_admin'])
@login_required(login_url='/login/')
def receptionist_details_view(request,*args,**kargs):
	receptionist = ReceptionistProfile.objects.get(user__username=kargs['receptionistuname'])
	receptionists = ReceptionistProfile.objects.all()
	if(receptionist.user.is_active):
		act_btn = 'Deactivate'
	else:
		act_btn = 'Activate'
	context = {


	'act_btn' : act_btn,
	'user_profile_pic': receptionist.profile_pic,
	'name' : receptionist.user.first_name + ' ' + receptionist.user.last_name,
	'email' : receptionist.user.email,
	'phone' : receptionist.phone,
	'joining_date' : receptionist.joining_date
	}
	if request.POST:
		clinic_name = ClinicAdmin.objects.get(user = request.user).clinic
		if(request.POST.get("create_doctor")):
			full_name = request.POST.get("full_name").split()
			i = 0
			last_name = ""
			for name_user in full_name:
				if(name_user == full_name[0]):
					first_name = name_user
				else:
					if(i == 1):
						last_name = name_user
					else:
						last_name = last_name + " " + name_user
				i += 1
			phone_no = request.	POST.get("phone_no")
			receptionistEmail = request.POST.get("receptionistEmail")
			email = request.POST.get("email")
			receptionistName = request.POST.get("receptionistName")
			password = request.POST.get("password")


			user = User.objects.get(username = receptionistEmail)

			if(not check_password(password, user.password)):

				context['error'] = 'Sorry'
				context['receptionists'] = receptionists

				return render(request, 'clinic/receptionist_details.html',context)
			else:


				d_user = User.objects.create(username = email, first_name = first_name, last_name = last_name,email = email, is_active = False)
				d_user.set_password(time.time().__str__())
				d_user.save()
				doctor_1 = DoctorProfile.objects.create(user = d_user)
				doctor_1.clinic_profile.add(clinic_name)

				context['success'] = 'Doctor profile created successfully'
				context['receptionists'] = receptionists

				return render(request,'clinic/receptionist_details.html',context)

		if request.POST.get("Deactivate"):
			if receptionist.user.is_active:
				User.objects.filter(username = kargs['receptionistuname']).update(is_active=False)
			else:
				User.objects.filter(username = kargs['receptionistuname']).update(is_active=True)

		if(request.POST.get("Update")):
			if request.POST.get("full_name"):
				full_name = request.POST.get("full_name").split()
				last_name = ''
				i = 0
				for name_user in full_name:
					if(name_user==full_name[0]):
						first_name = name_user
					else:
						if i==1:
							last_name=name_user
						else:
							last_name = last_name+" "+name_user
					i = i + 1
				User.objects.filter(username = kargs['receptionistuname']).update(first_name=first_name,last_name=last_name)
			if request.POST.get('password'):
				user = User.objects.get(username = kargs['receptionistuname'])
				user.set_password(request.POST.get('password'))
				user.save()
			if request.POST.get('phone'):
				ReceptionistProfile.objects.filter(user__username=kargs['receptionistuname']).update(phone=request.POST.get('phone'))

	return render(request,'clinic/receptionist_details.html',context)
	pass
