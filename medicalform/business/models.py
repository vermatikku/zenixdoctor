from django.db import models
from django.contrib.auth.models import User
from django.db.models import signals
from django.dispatch import receiver

# Create your models here.
class BusinessAdmin(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=10)
    active = models.CharField(max_length=1,default='Y')
    date_created = models.DateTimeField(auto_now_add=True, null=True)
    def __str__(self):
        return self.user.first_name + ' '+self.user.last_name

class BusinessProfile(models.Model):
    busness_admin = models.OneToOneField(BusinessAdmin,on_delete=models.CASCADE)
    name = models.CharField(max_length=250)
    description = models.CharField(max_length=250,null=True)
    active = models.CharField(max_length=1,default='Y')
    date_created = models.DateTimeField(auto_now_add=True, null=True)
    def __str__(self):
        return self.name

@receiver(signals.post_save,sender=BusinessAdmin)
def update_user_group(sender, instance, created, **kwargs):
    if created:
        from django.contrib.auth.models import Group
        user_group = Group.objects.get(name='business_admin')
        user_group.user_set.add(instance.user)