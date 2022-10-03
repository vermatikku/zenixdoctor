from django.db import models
# from django.contrib.auth.models import User


# class UserType(models.Model):
#     user = models.OneToOneField(User,on_delete=models.CASCADE,related_name="user_type")
#     USER_TYPE_CHOICES = (
#         (1, 'business_admin'),
#         (2, 'clinic_admin'),
#         (3, 'doctor'),
#         (4, 'patient'),
#     )
#     user_type = models.PositiveSmallIntegerField(choices=USER_TYPE_CHOICES,default=4)