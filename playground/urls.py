from django.urls import path
from . import views

#URLConf
urlpatterns = [
    path('hello/',views.say_hello),
    path('stores/',views.getStores),
    path('stores/create/',views.createStore),
    path('stores/<str:pk>/update/',views.updateStore),
    path('stores/<str:pk>/delete/',views.deleteStore),
    path('stores/<str:pk>/',views.getStore),
]