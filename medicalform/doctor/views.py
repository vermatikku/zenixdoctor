from django.shortcuts import render,redirect
from django.contrib.auth import authenticate,logout

from django.contrib.auth.decorators import login_required
from account.decorators import allowed_users

# Create your views here.
@allowed_users(allowed_roles=['doctors'])
@login_required(login_url='/login/')
def dashboard(request,*args,**kargs):
    context={}
    return render(request, 'doctor/dashboard.html',context)

@allowed_users(allowed_roles=['doctors'])
@login_required(login_url='/login/')
def patient_list_view(request,*args,**kargs):
    context={}
    return render(request, 'doctor/patient_list.html',context)