# Generated by Django 4.0.6 on 2023-08-01 08:10

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Library_App', '0002_rename_publication_date_book_details_published_date'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='login',
            name='status',
        ),
    ]
