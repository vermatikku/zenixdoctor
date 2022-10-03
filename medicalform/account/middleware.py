class RoleMiddleware:
	def __init__(self, get_response):
		self.get_response = get_response
		
	def __call__(self,request):
		"""
		Code to be executed for each request before
		the view (and later middleware) are called.
		"""
		
		response = self.get_response(request)
		
		"""
		Code to be executed for each request/response after
		the view is called.
		"""
		
		return response
	
	def process_view(self, request, view_func, *view_args, **view_kargs):
		"""
		called just before Django calls the view.
		Return either none or HttpResponse
		"""
		request.role = None
		if request.user.is_authenticated:
			groups = request.user.groups.all()
			if groups:
				request.role = groups[0].name
				if request.role == 'clinic_admin':
					from clinic.models import ClinicAdmin
					clinic_admin = ClinicAdmin.objects.get(user=request.user)
					clinic_name = clinic_admin.clinic.__str__()
					request.clinic_name_url = clinic_name.replace(' ','-').lower()
				elif request.role == 'assistant':
					from assistant.models import AssistantProfile
					assistant_profile = AssistantProfile.objects.get(user=request.user)
					clinic_name = assistant_profile.clinic_profile.__str__()
					request.clinic_name_url = clinic_name.replace(' ','-').lower()
				elif request.role == 'receptionist':
					from receptionist.models import ReceptionistProfile
					receptionistprofile = ReceptionistProfile.objects.get(user=request.user)
					clinic_name = receptionistprofile.clinic_profile.__str__()
					request.clinic_name_url = clinic_name.replace(' ','-').lower()
		#setting request.role
		
	# def process_exception(self, request, exception):
	#     """
	#     called for the response if exception is raised by view
	#     Return either none or HttpResponse
	#     """
	#     pass
	
	# def process_template_response(self, request, response):
	#     """
	#     request - HttpRequest object.
	#     response - TemplateResponse object
		
	#     return templateresponse
	#     use this for changing template or context if it is needed.
	#     """
	#     pass