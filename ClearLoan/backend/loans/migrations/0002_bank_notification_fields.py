from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('loans', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='bank',
            name='email_domain',
            field=models.CharField(blank=True, default='', max_length=120),
        ),
        migrations.AddField(
            model_name='bank',
            name='notification_email',
            field=models.EmailField(blank=True, default='', max_length=254),
        ),
    ]
