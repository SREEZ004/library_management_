# Generated by Django 3.2.7 on 2023-08-02 05:34

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Library_App', '0005_member_register_membership_type'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='member_register',
            name='membership_status',
        ),
        migrations.RemoveField(
            model_name='member_register',
            name='membership_type',
        ),
        migrations.RemoveField(
            model_name='member_register',
            name='membership_validity',
        ),
    ]
