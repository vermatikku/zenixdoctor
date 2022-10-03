from django.contrib import admin
from . import models

# Register your models here.
admin.site.register(models.ClinicProfile)
admin.site.register(models.ClinicAdmin)
admin.site.register(models.MedicalForm)
admin.site.register(models.MedicalFormAttribute)
admin.site.register(models.MedicalFormAndAttributeRelation)