# Generated by Django 3.1 on 2020-08-13 07:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('patient', '0002_auto_20200813_0311'),
    ]

    operations = [
        migrations.AlterField(
            model_name='patientprofile',
            name='home_contact',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='patientprofile',
            name='postalcode',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='patientprofile',
            name='work_contact',
            field=models.CharField(max_length=10, null=True),
        ),
    ]