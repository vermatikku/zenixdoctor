from django.contrib import admin
from . import models
# Register your models here.
admin.site.register(models.PatientProfile)
admin.site.register(models.PatientClinicRelation)
admin.site.register(models.PatientDoctorRelation)
admin.site.register(models.MedicalFormAttributeFilled)
admin.site.register(models.MedicalFormAuth)