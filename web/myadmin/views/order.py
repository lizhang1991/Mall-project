from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from .. models import Order,Users,OrderInfo,Address,Goods
# from django.contrib.auth.hashers import make_password, check_password
# Create your views here.



def list(request):
    data=Order.objects.filter()
    # print(data)
    for i in data:
        # print(i.uid.id)
        data.user=Users.objects.get(id=i.uid.id)
        print(data.user)
    # for i in data:
    #     print(data)
        print(data.user.username)
    # return HttpResponse('aa')


    types = request.GET.get('type',None)
    keywords = request.GET.get('keywords','')
    statuslist = {'待付款':1,'待发货':2,'待收货':3,'待评价':4,'已取消':5}
    print(types,keywords)
    if types == 'id':
        from django.db.models import Q
        data = data.filter(id__contains=keywords).exclude(status=0)
    # elif types =='status':
    #     data = data.filter(status__contains=keywords).exclude(status=0)
    # elif types =='username':
        # data = data.user.filter(username__contains=keywords).exclude(status=0)

    
    else:
        data = data
        
    # 数据分页类
    from django.core.paginator import Paginator
    paginator = Paginator(data,5)
    # 当前页码
    p = int(request.GET.get('p',1))

    # 根据当前页码获取当前页应该显示的数据
    userlist = paginator.page(p)
    # 获取当前页的页码数 
    num = paginator.page_range



    context = {'ulist':userlist,'pagenum':num}

    return render(request,'admin/order/list.html',context)
    

def edit(request,tid):
    # ['user':'','goods':'','order':'','user':'',OrderInfo一些键]
    data=Order.objects.get(id=tid)
    print(data)

    data.orderinfo=OrderInfo.objects.filter(orderid=data.id)
    for i in data.orderinfo: 
        data.goods=Goods.objects.filter(id=i.gid.id)

    print(data.goods)
    data.user=Users.objects.get(id=data.uid.id)
    data.address=Address.objects.get(id=data.address.id)


    # return HttpResponse('aa')

   
    return render(request,'admin/order/edit.html',{'uinfo':data})




def status(request):
    ob=Order.objects.get(id=request.GET['uid'])
    print(request.GET['uid'])
    ob.status=int(request.GET['status'])
    ob.save()
    return HttpResponse('ok')
