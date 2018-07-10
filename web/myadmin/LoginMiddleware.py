from django.shortcuts import render
from django.http import HttpResponse
import re



class LoginMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        # One-time configuration and initialization.

    def __call__(self, request):

        # 定义允许的请求路径
        urllist = ['/admin/login/','/admin/getverifycode/']

        # 判断是否要进入后台
        if re.match('/admin/',request.path) and request.path not in urllist:

            # 判断是否登录
            if not request.session.get('AdminUser',None):
                # 如果没有登录,则跳转到登录页面
                return HttpResponse('<script>alert("请先登录");location.href="/admin/login/"</script>')

        

        response = self.get_response(request)
        return response