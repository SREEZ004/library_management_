# Generated by Django 4.0.6 on 2023-08-03 17:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Library_App', '0010_book_donation_feedback'),
    ]

    operations = [
        migrations.AddField(
            model_name='book_reservation',
            name='status',
            field=models.CharField(default=1, max_length=20),
            preserve_default=False,
        ),
    ]
