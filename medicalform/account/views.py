from django.shortcuts import render,redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.models import Group
from django.http import HttpResponse
from django.contrib.auth.models import User
from clinic.models import ClinicAdmin
from django.contrib.sites.shortcuts import get_current_site

#custom import
from django.core.mail import send_mail,EmailMessage,EmailMultiAlternatives
from django.template.loader import render_to_string
from django.utils.encoding import force_bytes, force_text
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from patient.tokens import account_activation_token
from .decorators import unauthenticated_user,allowed_users
from django.urls import reverse
from django.http import JsonResponse
from django.conf import settings
# Create your views here.
@login_required(login_url='login/')
def home_view(request,*args,**kargs):
	data_to_show = {}
	print(type(request))
	print(request.user.username)
	'''
	if('@gmail.com' not in request.user.username):
		request.user.username = str(request.user.username) + '@gmail.com'

		user = User.objects.get(username = request.user.username)
		print(user.username)

		return redirect('/')


		try:
			user_group = User.objects.get(username = request.user.username).groups.all()[0]
			user_group = user_group.__str__()
			request.role = user_group
		except:
			messages.info(request,'Username OR password is incorrect')
			return render(request,'login.html')
		'''
	#print(request.user.username)
	#print(type(request))
	#print(request.role)
	if request.role:
		if request.role == 'business_admin':
			return redirect('/business/')
		elif request.role == 'clinic_admin':
			return redirect('/'+request.clinic_name_url+'/')
		elif request.role == 'doctors':
			return redirect('/doctor/')
		elif request.role == 'patients':
			return redirect('/dashboard/')
		elif request.role == 'receptionist':
			return redirect('/'+request.clinic_name_url+'/clinic-receptionist/')
		elif request.role == 'assistant':
			return redirect('/'+request.clinic_name_url+'/clinic-assistant/')
	return HttpResponse('You are not authorized to view this page. Please <a href = "login">Login</a>')


def logout_view(request,*args,**kargs):
	logout(request)
	return redirect('/login/')

@unauthenticated_user
def login_view(request):

	if request.method == 'POST':
		username = request.POST.get('username')
		password =request.POST.get('password')
		#check group type of user
		try:
			user_group = User.objects.get(username=username).groups.all()[0]
			user_group = user_group.__str__()
		except:
			messages.info(request, 'Username OR password is incorrect')
			return render(request, 'login.html')
		if user_group == 'assistant':
			from assistant.models import AssistantProfile as ap
			assistant = ap.objects.get(user__username=username)
			white_listed_ip = assistant.white_list_ip
			if white_listed_ip.__contains__('*'):
				pass
			elif white_listed_ip.__contains__(request.META['REMOTE_ADDR'].__str__()):
				pass
			else:
				messages.info(request, 'Ip is not listed for login')
				return render(request, 'login.html')
		elif user_group == 'receptionist':
			from receptionist.models import ReceptionistProfile as rp
			assistant = rp.objects.get(user__username=username)
			white_listed_ip = assistant.white_list_ip
			if white_listed_ip.__contains__('*'):
				pass
			elif white_listed_ip.__contains__(request.META['REMOTE_ADDR'].__str__()):
				pass
			else:
				messages.info(request, 'Ip is not listed for login')
				return render(request, 'login.html')

		user = authenticate(request, username=username, password=password)
		if user is not None:

			login(request, user)
			return redirect('/')
		else:
			messages.info(request, 'Username OR password is incorrect')



	return render(request, 'login.html')
def google_auth_login(request,*args,**kwargs):
	print(request.user.email)
	if('@gmail.com' not in request.user.email):
		username = str(request.user.email) + '@gmail.com'
	else:
		username = request.user.email
	print(username)
	user = User.objects.filter(username = username).all()
	print(len(user))
	if(len(user) > 0):
		user = user[0]
		print(user.username)
		login(request,user,backend = 'django.contrib.auth.backends.ModelBackend')
		return redirect('/')
	else:
		messages.info(request,"Email is not linked with given account")
		return redirect('/logout/')
def login_validate_username(request):
	username = request.GET.get('username',None)
	data = {
		'is_exist' : User.objects.filter(username = username).exists()
	}

	if(data['is_exist'] == False):

		data["error"] = "Username does not exist"
	return JsonResponse(data)
@unauthenticated_user
def forgot_password(request):
	return render(request, 'forgot-password.html')

def change_password(request):
	email = request.GET.get('email')
	print(email)
	user = User.objects.get(email = email)
	mail_subject = 'Reset Your password'
	current_site = get_current_site(request)
	uidb64 = urlsafe_base64_encode(force_bytes(user.pk))
	token = account_activation_token.make_token(user)
	domain = current_site.domain
	link = reverse('password_change',kwargs = {'uidb64':uidb64,'token':token})
	activate_link = 'http://'+ domain+link
	paramaters_for_mail =  {
		'email' : email,
		'domain':current_site.domain,
		'uid':urlsafe_base64_encode(force_bytes(user.pk)),
		'token':account_activation_token.make_token(user),
		'activate_link':activate_link,
	}
	message = render_to_string('password_reset_form.html',paramaters_for_mail)
	to_email = email
	msg = EmailMultiAlternatives(mail_subject,message, settings.EMAIL_HOST_USER, [to_email])
	msg.attach_alternative(message, "text/html")
	msg.send()
	data = {
	'send' : "An email has been sent to the provided mail"
	}
	print(data['send'])
	return JsonResponse(data)
def password_change(request,*args,**kargs):
	return HttpResponse('''Hey''')
@unauthenticated_user
def recover_password(request):
	return render(request, 'recover-password.html')

def check_username_availability(request,*args,**kargs):
	try:
		user = User.objects.get(username=kargs['uname'])
		return HttpResponse('{ "avaliability" : 0 }')
	except User.DoesNotExist:
		return HttpResponse('{ "avaliability" : 1 }')

def check_email_availability(request,*args,**kargs):
	try:
		user = User.objects.get(email=kargs['email'])
		return HttpResponse('{ "avaliability" : 0 }')
	except User.DoesNotExist:
		return HttpResponse('{ "avaliability" : 1 }')
