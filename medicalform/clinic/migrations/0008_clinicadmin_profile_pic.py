# Generated by Django 3.1 on 2020-08-26 14:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('clinic', '0007_delete_medicalformattributefilld'),
    ]

    operations = [
        migrations.AddField(
            model_name='clinicadmin',
            name='profile_pic',
            field=models.CharField(default='user_default_pic.png', max_length=200),
        ),
    ]