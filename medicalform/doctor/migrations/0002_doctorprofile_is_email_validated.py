# Generated by Django 3.1 on 2020-08-12 21:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('doctor', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='doctorprofile',
            name='is_email_validated',
            field=models.CharField(default='N', max_length=1),
        ),
    ]
