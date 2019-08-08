from django.shortcuts import render
from . import automate as helper
# Create your views here.

def automateTest(request):
    message = "Please enter type correctly"
    if request.method == 'POST':
        type = request.POST.get('type')
    
        if type == '1':
            helper.test1()
        elif type == '2':
            helper.test2()
        elif type == '3':
            helper.test3()
        elif type == '4':
            helper.test4()
        
        elif type == '5':
            helper.test5()
        elif type == '6':
            helper.test6()
        elif type == '7':
            helper.test7()
        elif type == '8':
            helper.test8()

        elif type == '9':
            helper.test9()
        elif type == '10':
            helper.test10()
        elif type == '11':
            helper.test11()
        elif type == '12':
            helper.test12()

        elif type == '13':
            helper.test13()
        elif type == '14':
            helper.test14()

    return render(request, 'webAutomation.html', {'message': message})
