from django.shortcuts import render
from django.http import HttpResponse
import re



class LoginMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        # One-time configuration and initialization.

    def __call__(self, request):

        a=['edit/[0-9]+','/update/','/myorder/','/member/','/addressedit/','/addressupdate/','/cart/list/','/cart/clear/','/cart/edit/','/cart/del/','/order/confirm/','/order/create/','/order/buy/']

        # m=re.match("^list/(?[0-9]+)",path)
        for i in a:
            if re.match(i,request.path):
             # 判断是否登录
                if not request.session.get('VipUser',None):
                # 如果没有登录,则跳转到登录页面
                    return HttpResponse('<script>alert("请先登录");location.href="/login/"</script>')
        response = self.get_response(request)
        return response



        # 定义允许的请求路径
        # urllist = ['/','/login/','/getverifycode/','/list/','/info/','/register/','/loginout/']
        # print("aaa")
        # # 判断是否要进入后台
        # if re.match('/',request.path) and request.path not in urllist:
        #     print("bbb")
        #     # 判断是否登录
        #     if not request.session.get('VipUser',None):
        #         # 如果没有登录,则跳转到登录页面
        #         return HttpResponse('<script>alert("请先登录");location.href="/login/"</script>')
        # print("ccc")
        

        # response = self.get_response(request)
        # return response