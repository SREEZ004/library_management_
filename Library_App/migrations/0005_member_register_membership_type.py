# Generated by Django 4.0.6 on 2023-08-01 17:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Library_App', '0004_member_register_membership_taken_date_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='member_register',
            name='membership_type',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]
