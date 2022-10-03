from django.db import models
from django.contrib.auth.models import User
from django.db.models import signals
from django.dispatch import receiver

from clinic.models import ClinicProfile
# Create your models here.
class DoctorOccupation(models.Model):
	occupation = models.CharField( max_length=100 )
	def __str__(self):
		return self.occupation
class DoctorQualification(models.Model):
	qualification = models.CharField(max_length=100)
	def __str__(self):
		return self.qualification
class DoctorProfile(models.Model):
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	clinic_profile = models.ManyToManyField(ClinicProfile, through='DoctorClinicRelation')
	occupation = models.ManyToManyField(DoctorOccupation, through='DoctorOccupationRelation')
	qualification = models.ManyToManyField(DoctorQualification, through='DoctorQualificationRelation')
	profile_pic = models.CharField(max_length=100,default='user_default_pic.png')
	practice_start_date = models.DateField(null=True)
	description = models.TextField(max_length=2000,null=True)
	phone = models.CharField(max_length=10,null=True)
	is_email_validated = models.CharField(max_length=1,default='N')
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=True)
	def __str__(self):
		return self.user.username

class DoctorQualificationRelation(models.Model):
	qualification = models.ForeignKey(DoctorQualification, on_delete=models.CASCADE)
	doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE)
	date_created = models.DateTimeField( auto_now_add=True, null=True )

class DoctorOccupationRelation(models.Model):
	occupation = models.ForeignKey(DoctorOccupation, on_delete=models.CASCADE)
	doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE)
	date_created = models.DateTimeField(auto_now_add=True, null=True)

class DoctorClinicRelation(models.Model):
	clinic_profile = models.ForeignKey(ClinicProfile, on_delete=models.CASCADE)
	doctor = models.ForeignKey(DoctorProfile, on_delete=models.CASCADE)
	date_created = models.DateTimeField(auto_now_add=True, null=True)
	join_date = models.DateTimeField( null=True )
	leave_date = models.DateTimeField( null=True )

@receiver(signals.post_save,sender=DoctorProfile)
def update_user_group(sender, instance, created, **kwargs):
	if created:
		from django.contrib.auth.models import Group
		user_group = Group.objects.get(name='doctors')
		user_group.user_set.add(instance.user)