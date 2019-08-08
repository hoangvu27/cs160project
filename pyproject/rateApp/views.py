from django.shortcuts import render
import re
import base64
import random
import os.path
from .result import Result
from django.shortcuts import redirect
from .models import Vote , review
from . import predict
from django.db.models import Avg, Sum


def canvas(request):
    directory = '/Users/Student/pyproject/rateApp/img/'
    rate = 'You have not voted the app yet'
    done = 2
    people = 0
    votingScore = 0
    if review.objects.all().count() > 0:
        people = review.objects.all()[0].people
        votingScore = review.objects.all()[0].average
#   done will always be 2 everytime request is sent here

    if request.method == 'POST':
        if request.POST.get('username') != None and request.POST.get('password') != None:
            
            Result[1]  = u = request.POST.get('username')
            Result[2] = p = request.POST.get('password')
            
            check = Vote.objects.filter(username = u)
            if check.count() > 0 and check[0].password == p:
                done = 1
                rate = 'You have voted, and you can vote again if you do not remember the rating'
                return render(request, 'canvas.html', { 'rate' : rate , 'done' : done , 'average' : votingScore, 'people' : people}  )

            done = 0
            return render(request, 'canvas.html', { 'rate' : rate , 'done' : done }  )

        elif request.POST.get('verify') == 'GoBack':
            done = 0
            return render(request, 'canvas.html', { 'rate' : rate , 'done' : done }  )
        elif request.POST.get('verify') == 'Confirm':
            rate = 'You have voted'
            done = 1
            vote = Vote()
            check = Vote.objects.filter(username = Result[1] )
            if check.count() > 0:
                vote = check[0]
            vote.username = Result[1]
            vote.password = Result[2]
            vote.rating = Result[3]
            vote.save()
            
            r = review()
            if review.objects.all().count() > 0:
                r = review.objects.all()[0]
            r.people = people = Vote.objects.all().count()
            print( Vote.objects.all()  )
            sum = 0
            for temp in Vote.objects.all():
                sum += temp.rating
            print(sum )
            votingScore = r.average = round( sum / people , 2)
            r.save()
            
            ctx = { 'rate' : rate , 'done' : done , 'average' : votingScore, 'people' : people }
            return render(request, 'canvas.html',  ctx )

        elif request.POST.get('edit') != None:
            done = 5
#            here, since history has been erased to prevent back browser button, cannot use redirect
            return render(request, 'success.html', { 'rate' : rate , 'done' : done } )

        elif request.POST.get('proceed') != None:
            done = 0
            return render(request, 'canvas.html', { 'rate' : rate , 'done' : done } )

        elif request.POST.get('canvasImg') != None:
            a = request.POST.get('canvasImg')
            count = request.POST.get('count')
            pattern = r'^data:(?P<mime_type>[^;]+);base64,(?P<image>.+)$'
            image = None
            result = re.match(pattern, a)
            imgdata = None
            if result:
#                code from line 42 to 44 is taken from stackoverflow
                mime_type = result.group('mime_type')
                image = result.group('image')
                imgdata = base64.b64decode(image)
                filename = str(Result[0]) + '.png'
                with open( os.path.join(directory , filename), 'wb') as f:
                    f.write(imgdata)
                Result[3] = score = predict.run()
                rate = 'Your vote is ' + str(score)
                Result[0] += 1
                done = 4

                return render(request, 'success.html', { 'rate' : rate , 'done' : done } )
#            In line 54, if submit does not take drawing, then still, done == 0
            return render(request, 'success.html', { 'rate' : rate , 'done' : done } )
    context = { 'rate' : rate , 'done' : done , 'average' : votingScore, 'people' : people }
    return render(request, 'canvas.html', context )



