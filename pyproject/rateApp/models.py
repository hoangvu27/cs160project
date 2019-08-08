from django.db import models

# Create your models here.
class Vote(models.Model):
    username = models.CharField(max_length=30)
    password = models.CharField(max_length=30)
    rating = models.IntegerField()
    
class review(models.Model):
    people = models.IntegerField()
    average = models.FloatField()
