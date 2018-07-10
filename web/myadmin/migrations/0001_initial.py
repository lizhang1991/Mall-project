# -*- coding: utf-8 -*-
# Generated by Django 1.11.13 on 2018-05-17 20:50
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Users',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=50)),
                ('password', models.CharField(max_length=77)),
                ('email', models.CharField(max_length=100)),
                ('phone', models.CharField(max_length=11)),
                ('sex', models.CharField(max_length=1)),
                ('age', models.IntegerField()),
                ('picurl', models.CharField(default='/static/pics/default/default.jpg', max_length=100)),
                ('status', models.IntegerField(default=0)),
                ('addtime', models.DateTimeField(auto_now_add=True)),
            ],
        ),
    ]