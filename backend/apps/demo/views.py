from django.shortcuts import render
from django.http import HttpResponse

from lib.log import color_logger
from lib.request_tool import pub_get_request_body, pub_success_response


# Create your views here.


def index(request):
    return HttpResponse("Hello, world. You're at the data index.")


def demo_txt(request):
    body = pub_get_request_body(request)
    if request.method == 'GET':
        color_logger.debug("enter asset_list: get")

        return pub_success_response(data="后端：YcLey")

