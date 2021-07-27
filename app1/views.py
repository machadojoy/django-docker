from django.shortcuts import render
from app1.tasks import add

# Create your views here.
def index(request):
    add.delay(5, 3)
    return render(request, 'home.html')
