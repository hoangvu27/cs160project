from django.shortcuts import render, redirect
from django.core.mail import send_mail, BadHeaderError
from django.http import HttpResponse
import requests
from . import antiSpam as helper

# Create your views here.
def contact(request):
    textResponse = ""
    url = 'https://chessgiants.weebly.com/contact.html'
    if request.method == 'POST':
        e = email = request.POST.get('email')
        topic = request.POST.get('topic')
        message = request.POST.get('message')
        name = request.POST.get('fullname')

        type = helper.go(message)
        if type == 1:
            textResponse = "Your message is spam. We cannot help you."
            return render(request, 'contact.html', {'textResponse' : textResponse})
#    need to enable this https://myaccount.google.com/lesssecureapps
        contactTopic = 'new request from clients'
        contactMessage = 'email : '  + email + 'name : ' + name + 'message : ' + message
        
        autoResponseTopic = 'auto reply'
        autoMessage = 'You received this email because you have contacted us. We will get back to you soon.'
        try:
            send_mail(autoResponseTopic, autoMessage, email, [str(e)] )
            send_mail(contactTopic, contactMessage, email, ['hoangvu27194@gmail.com'])
        except BadHeaderError:
            textResponse ='Invalid header found.'
        

        
        return redirect('success')
    return render(request, 'contact.html', {'textResponse' : textResponse})

def success(request):

    return HttpResponse('We will review your feedbacks and contact you soon')

