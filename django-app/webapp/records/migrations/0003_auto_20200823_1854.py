# Generated by Django 3.1 on 2020-08-23 18:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('records', '0002_record_token'),
    ]

    operations = [
        migrations.AddField(
            model_name='record',
            name='duration',
            field=models.CharField(default='', max_length=200),
        ),
        migrations.AlterField(
            model_name='record',
            name='end_time',
            field=models.CharField(max_length=100),
        ),
        migrations.AlterField(
            model_name='record',
            name='start_time',
            field=models.CharField(max_length=100),
        ),
    ]
