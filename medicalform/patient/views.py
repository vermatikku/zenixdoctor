from django.shortcuts import render,redirect
from django.contrib.sites.shortcuts import get_current_site
from django.contrib.auth import authenticate,logout,login
from django.conf import settings
from django.http import HttpResponse
from django.core.mail import send_mail,EmailMessage,EmailMultiAlternatives
from django.template.loader import render_to_string
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_protect
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.urls import reverse

from django.contrib.auth.decorators import login_required
from account.decorators import allowed_users

from .models import PatientProfile
from .tokens import account_activation_token
from account.decorators import unauthenticated_user
import datetime
from django.contrib.auth.models import User
from django.http import JsonResponse

# Create your views here.
def validate_username(request):
	username = request.GET.get('username',None)
	data = {
		'is_taken' : User.objects.filter(username = username).exists()
	}
	if(data["is_taken"]):
		data["error"] = "Username already exists"

	return JsonResponse(data)


@allowed_users(allowed_roles=['patients'])
@login_required(login_url='/login/')
def dashboard(request,*args,**kargs):
	user = request.user
	patient = PatientProfile.objects.get(user = user)
	user_full_name = user.first_name + ' ' + user.last_name
	name_c = user.last_name.split()
	if len(name_c) > 1:
		middle_name = name_c[0]
		last_name = name_c[1]
	else:
		middle_name = ''
		last_name = name_c[0]
	email  = user.email
	dob = patient.dob
	# gender = patient.gender
	address = patient.address
	# city = patient.city
	postal = patient.postalcode
	context={
		'user_full_name':user_full_name,
		'first_name':user.first_name,
		'middle_name':middle_name,
		'last_name':last_name,
		'email':email,
		'dob':dob,
		'gender':'',
		'address':address,
		'city':'',
		'postal':postal,
	}
	return render(request, 'patient/dashboard.html',context)

def medical_form_list(request,*args,**kargs):
	context={}
	return render(request, 'patient/medical-form-list.html',context)

def activate_view(request,*args,**kargs):
	try:
		uid = force_text(urlsafe_base64_decode(kargs['uidb64']))
		user = User.objects.get(pk=uid)
	except(TypeError, ValueError, OverflowError, User.DoesNotExist):
		user = None
	if user is not None and account_activation_token.check_token(user, kargs['token']):
		user.is_active = True
		user.save()
		patient = PatientProfile.objects.get( user = user )
		patient.is_email_validated = 'Y'
		patient.save()
		login(request, user)
		# return render()
		# return redirect('/login/')
		return HttpResponse('Thank you for your email confirmation. Now you can login your account.')
	else:
		return HttpResponse('Activation link is invalid!')

@unauthenticated_user
def first_time_login_view(request,*args,**kargs):
	try:
		uid = force_text(urlsafe_base64_decode(kargs['uidb64']))
		user = User.objects.get(pk=uid)
	except(TypeError, ValueError, OverflowError, User.DoesNotExist):
		user = None
	if user is not None:
		patient = PatientProfile.objects.get(user=user)
		if patient.is_email_validated=='N':
			if request.POST:
				email = request.POST.get('email')
				dob = request.POST.get('dob')
				password = request.POST.get('password')
				if not password:
					if email==user.email and patient.dob.strftime("%Y-%m-%d") == dob :
						name_c = user.last_name.split()
						if len(name_c) > 1:
							middle_name = name_c[0]
							last_name = name_c[1]
						else:
							middle_name = ''
							last_name = name_c[0]
						context={
									'first_name':user.first_name,
									'middle_name':middle_name,
									'last_name':last_name,
									'email':user.email,
									'phone':patient.phone,
									'dob':dob,
								}
						return render(request,'patient/first_register.html',context)
					else:
						context = {'error':'invalid credentials'}
						return render(request,'patient/first-login.html',context)
				else:
					print('update data for user')
					patient.is_email_validated = 'Y'
					user.is_active = True
					user.username = request.POST.get('username')
					user.set_password = request.POST.get('password')
					user.save()
					patient.address = request.POST.get('address')
					patient.postalcode = request.POST.get('post_code')
					patient.phone = request.POST.get('phone')
					patient.home_contact = request.POST.get('home_contact')
					patient.work_contact = request.POST.get('work_contact')
					patient.save()
					login(request,user)
					return redirect('/')
			return render(request,'patient/first-login.html')
		return redirect('/login/')
	else:
		return HttpResponse('Activation link is invalid!')

@unauthenticated_user
def register(request):
	if request.method == 'POST':
		# form = AuthorForm(request.POST)
		# if form.is_valid():
		first_name = request.POST.get('first_name')
		middle_name = request.POST.get('middle_name')
		if middle_name =='':
			last_name = request.POST.get('last_name')
		else:
			last_name = middle_name + ' ' + request.POST.get('last_name')
		username = request.POST.get('username')
		email = request.POST.get('email')
		dob = request.POST.get('dob')
		password = request.POST.get('password')
		# password = make_password(password, salt=None, hasher='default')
		address = request.POST.get('address')
		post_code = request.POST.get('post_code')
		phone = request.POST.get('phone')
		home_contact = request.POST.get('home_contact')
		work_contact = request.POST.get('work_contact')
		#confirm email not exist and username not exist
		try:
			user = User.objects.get(username=username)
			context = {
				'error':'username already exist'
			}
			return render(request, 'patient/register.html',context)
		except User.DoesNotExist:
			pass
		try:
			user = User.objects.get(email=email)
			context = {
				'error':'email already exist'
			}
			return render(request, 'patient/register.html',context)
		except User.DoesNotExist:
			pass
		user = User.objects.create(username=username,first_name=first_name,last_name=last_name,email=email,is_active=False)
		user.set_password(password)
		user.save()
		patient = PatientProfile.objects.create(user=user,dob=dob,address=address,postalcode=post_code,phone=phone,home_contact=home_contact,work_contact=work_contact)
		patient.save()
		mail_subject = 'Activate Patient History Account'
		current_site = get_current_site(request)
		uidb64 = urlsafe_base64_encode(force_bytes(user.pk))
		token = account_activation_token.make_token(user)
		domain = current_site.domain
		link = reverse('activate_url',kwargs = {'uidb64':uidb64,'token':token})
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
		context = {
			'success':'Registration successfully completed'
		}
		return render(request, 'patient/register.html',context)
	context = {}
	return render(request, 'patient/register.html')

def user_filled_form_view(request,*args,**kargs):
	# user_data = Patient.objects.filter()
	context = {}
	return render(request,'',context)
