# Generated by Django 3.1 on 2020-08-19 08:09

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('clinic', '0007_delete_medicalformattributefilld'),
        ('patient', '0003_auto_20200813_1233'),
    ]

    operations = [
        migrations.CreateModel(
            name='MedicalFormAttributeFilled',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('required', models.CharField(default='Y', max_length=1)),
                ('active', models.CharField(default='Y', max_length=1)),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('form_attribute_rel', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='clinic.medicalformandattributerelation')),
                ('patient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='patient.patientprofile')),
            ],
        ),
    ]