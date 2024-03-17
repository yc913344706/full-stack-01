from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("demo_txt", views.demo_txt, name="demo_txt"),

]
