from django.db import models
from django.contrib.auth.models import User
from django.db.models import signals
from django.dispatch import receiver
from business.models import BusinessProfile

# Create your models here.
class ClinicProfile(models.Model):
	name = models.CharField(max_length=250,null=False)
	addresses = models.TextField(max_length=500,null=True)
	clinic_description = models.TextField(max_length=500,null=True)
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)
	business = models.ForeignKey(BusinessProfile,on_delete=models.CASCADE)
	def __str__(self):
		return self.name

class ClinicAdmin(models.Model):
	clinic = models.OneToOneField(ClinicProfile, on_delete=models.CASCADE)
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	profile_pic = models.CharField(max_length=200,default='user_default_pic.png')
	phone = models.CharField(max_length=10)
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)
	def __str__(self):
		return self.user.first_name+' '+self.user.last_name

class MedicalForm(models.Model):
	form_name = models.CharField(max_length=50)
	form_path = models.CharField(max_length=100)
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)
	clinic = models.ForeignKey(ClinicProfile,on_delete=models.CASCADE)
	def __str__(self):
		return self.form_name

class MedicalFormAttribute(models.Model):
	attribute_name = models.CharField(max_length=50)
	attribute_type = models.CharField(max_length=10)
	attribute_option = models.CharField(max_length=500,null=True,default=None)
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)
	clinic = models.ForeignKey(ClinicProfile,on_delete=models.CASCADE)
	def __str__(self):
		return self.attribute_name

class MedicalFormAndAttributeRelation(models.Model):
	form = models.ForeignKey(MedicalForm,on_delete=models.CASCADE)
	attribute = models.ForeignKey(MedicalFormAttribute,on_delete=models.CASCADE)
	required = models.CharField(max_length=1,default='Y')
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=False)
	def __str__(self):
		return self.form.form_name+' - '+self.attribute.attribute_name


@receiver(signals.post_save,sender=ClinicAdmin)
def update_user_group(sender, instance, created, **kwargs):
	if created:
		from django.contrib.auth.models import Group
		user_group = Group.objects.get(name='clinic_admin')
		user_group.user_set.add(instance.user)