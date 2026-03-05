from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('loans', '0002_bank_notification_fields'),
        ('accounts', '0002_user_company_address_user_company_director_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='email',
            field=models.EmailField(blank=True, default='', max_length=254),
        ),
        migrations.AddField(
            model_name='user',
            name='role',
            field=models.CharField(choices=[('client', 'Client'), ('bank_admin', 'Bank admin'), ('bank_staff', 'Bank staff')], default='client', max_length=20),
        ),
        migrations.AddField(
            model_name='user',
            name='bank',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='bank_users', to='loans.bank'),
        ),
    ]
