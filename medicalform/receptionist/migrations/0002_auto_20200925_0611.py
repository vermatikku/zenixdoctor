# Generated by Django 3.1 on 2020-09-25 00:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('clinic', '0009_clinicprofile_clinic_description'),
        ('receptionist', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='receptionistprofile',
            name='clinic_profile',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='clinic.clinicprofile'),
        ),
    ]
