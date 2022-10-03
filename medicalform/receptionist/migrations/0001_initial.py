# Generated by Django 3.1 on 2020-09-24 23:37

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('clinic', '0009_clinicprofile_clinic_description'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='ReceptionistProfile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('profile_pic', models.CharField(default='user_default_pic.png', max_length=100)),
                ('joining_date', models.DateField(null=True)),
                ('phone', models.CharField(max_length=10, null=True)),
                ('active', models.CharField(default='Y', max_length=1)),
                ('date_created', models.DateTimeField(auto_now_add=True, null=True)),
                ('clinic_profile', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='clinic.clinicprofile')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
