from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import StoreSerializer
from .models import Store
# Create your views here.
@api_view(['GET'])
def say_hello(request):
    return Response("hello")

@api_view(['GET'])
def getStores(request):
    stores = Store.objects.all()
    serializer = StoreSerializer(stores,many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getStore(request,pk):
    store = Store.objects.get(id=pk)
    serializer = StoreSerializer(store,many=False)
    return Response(serializer.data)

@api_view(['POST'])
def createStore(request):
    data = request.data
    store = Store.objects.create(
        body = data['body']
    )
    serializer = StoreSerializer(store,many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updateStore(request,pk):
    data = request.data
    store=Store.objects.get(id=pk)
    serializer = StoreSerializer(store,data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteStore(request,pk):
    store=Store.objects.get(id=pk)
    store.delete()
    return Response('Note was deleted')


