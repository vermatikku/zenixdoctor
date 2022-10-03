from django.db import models
from django.contrib.auth.models import User
from django.db.models import signals
from django.dispatch import receiver

from clinic.models import ClinicProfile
# Create your models here.
class ReceptionistProfile(models.Model):
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	clinic_profile = models.ForeignKey(ClinicProfile, on_delete=models.CASCADE)
	profile_pic = models.CharField(max_length=100,default='user_default_pic.png')
	joining_date = models.DateField(null=True)
	phone = models.CharField(max_length=10,null=True)
	white_list_ip = models.CharField(max_length=200,default='*')
	active = models.CharField(max_length=1,default='Y')
	date_created = models.DateTimeField(auto_now_add=True, null=True)
	def __str__(self):
		return self.user.username


@receiver(signals.post_save,sender=ReceptionistProfile)
def update_user_group(sender, instance, created, **kwargs):
	if created:
		from django.contrib.auth.models import Group
		user_group = Group.objects.get(name='receptionist')
		user_group.user_set.add(instance.user)