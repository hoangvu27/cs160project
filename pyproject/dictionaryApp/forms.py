from django import forms

class wordInput(forms.Form):
    word = forms.CharField( max_length=50)
