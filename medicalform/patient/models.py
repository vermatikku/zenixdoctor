from django.db import models
from django.contrib.auth.models import Permission
from django.contrib.auth.models import User
from django.db.models import signals
from django.dispatch import receiver
from clinic.models import ClinicProfile,MedicalFormAndAttributeRelation,MedicalForm
from doctor.models import DoctorProfile
# Create your models here.

class PatientProfile(models.Model):
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	clinic_profile = models.ManyToManyField(ClinicProfile, through='PatientClinicRelation')
	doctor_profile = models.ManyToManyField(DoctorProfile, through='PatientDoctorRelation')
	profile_pic = models.CharField(max_length=100,default='user_default_pic.png')
	dob = models.DateField(null=True)
	address = models.TextField(max_length=500,null=True)
	postalcode = models.CharField(max_length=50,null=True)
	phone = models.CharField(max_length=10,null=True)
	home_contact = models.CharField(max_length=10,null=True)
	work_contact = models.CharField(max_length=10,null=True)
	is_email_validated = models.CharField(max_length=1,default='N')
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=True)
	def __str__(self):
		return self.user.username

class PatientClinicRelation(models.Model):
	patient_profile = models.ForeignKey(PatientProfile,on_delete=models.CASCADE)
	clinic_profile = models.ForeignKey(ClinicProfile,on_delete=models.CASCADE)
	visit_date = models.DateTimeField(null=True)

class PatientDoctorRelation(models.Model):
	patient_profile = models.ForeignKey(PatientProfile,on_delete=models.CASCADE)
	doctor_profile = models.ForeignKey(DoctorProfile,on_delete=models.CASCADE)
	visit_date = models.DateTimeField(null=True)

class MedicalFormAuth(models.Model):
	medical_form = models.ForeignKey(MedicalForm,on_delete=models.CASCADE)
	sent_by = models.ForeignKey(User,on_delete=models.CASCADE)
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)

class MedicalFormAttributeFilled(models.Model):
	filled_value = models.CharField(max_length=200,default=None)
	form_attribute_rel = models.ForeignKey(MedicalFormAndAttributeRelation,on_delete=models.CASCADE)
	patient = models.ForeignKey(PatientProfile,on_delete=models.CASCADE)
	required = models.CharField(max_length=1,default='Y')
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)
	def __str__(self):
		return self.filled_value

@receiver(signals.post_save,sender=PatientProfile)
def update_user_group(sender, instance, created, **kwargs):
	if created:
		from django.contrib.auth.models import Group
		user_group = Group.objects.get(name='patients')
		user_group.user_set.add(instance.user)