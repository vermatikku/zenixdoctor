from django.shortcuts import render,redirect
from django.contrib.auth import authenticate,logout

from django.contrib.auth.decorators import login_required
from account.decorators import allowed_users
# Create your views here.
#business_admin

@allowed_users(allowed_roles=['business_admin'])
@login_required(login_url='/login/')
def dashboard(request,*args,**kargs):
	context={}
	return render(request, 'business/dashboard.html',context)

