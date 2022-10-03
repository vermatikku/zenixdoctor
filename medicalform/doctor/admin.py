from django.contrib import admin
from . import models
# Register your models here.
admin.site.register(models.DoctorOccupation)
admin.site.register(models.DoctorQualification)
admin.site.register(models.DoctorProfile)
admin.site.register(models.DoctorQualificationRelation)
admin.site.register(models.DoctorOccupationRelation)
admin.site.register(models.DoctorClinicRelation)