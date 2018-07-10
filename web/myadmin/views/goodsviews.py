from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from .. models import Goods,types
from django.contrib.auth.hashers import make_password, check_password
from . views import ajaxupload
# Create your views here.
def ajaxupload(request):
    import time,random

    myfile = request.FILES.get('pic',None)
    print('11111111')
    # 判断是否有文件上传
    if not myfile:
        return JsonResponse({'code':1,'msg':'没有文件上传'})

    # 执行文件上传
    # 自定义文件名 时间戳+随机数+.jpg
    filename = str(time.time())+str(random.randrange(10000,99999))

    # 获取当前上传文件的后缀名
    hzm = myfile.name.split('.').pop()
    print('2222')
    # 允许上传的文件类型
    arr = ['png','jpg','gif','jpeg','bmp','icon']
    # 如果上传的文件类型不正确
    if hzm not in arr:
        print('43333')
        return JsonResponse({'code':2,'msg':'上传的文件类型错误'})

    # 打开文件
    file = open('./static/goodspics/'+filename+'.'+hzm,'wb+')
    # 分块写入文件  
    for chunk in myfile.chunks():  
           print('444444')    
           file.write(chunk)  
    # 关闭文件
    file.close()

    # 返回文件的url路径
    return JsonResponse({'code':0,'msg':'上传成功','url':'/static/goodspics/'+filename+'.'+hzm})
    


    return HttpResponse('ajaxupload')
def add(request):
    from . typeviews import GetTypesAll
    context={'tlist':GetTypesAll()}
    return render(request,'admin/goods/add.html',context)

def insert(request):
    # pic=uploads(request)
    # if not request.FILES.get('pic',None):
    #     return HttpResponse('<script>alert("请选择上传的商品图片");location.href="/admin/goods/add"</script>')
    try:
        ob=Goods()
        print(ob)
        ob.typeid = types.objects.get(id=request.POST.get('typeid'))
        print(ob.typeid)
        ob.title = request.POST.get('title')
        print(ob.title)
        ob.info=request.POST.get('info')
        print(ob.info)
        ob.storage=request.POST.get('storage')
        print(ob.storage)
        ob.price=request.POST.get('price')
        print(ob.price)
        ob.pic=request.POST.get('picurl')
        ob.save()
    
        return HttpResponse('<script>alert("添加成功");location.href="/admin/goods/list/"</script>')
    except:
        return HttpResponse('<script>alert("添加失败");location.href="/admin/goods/add/"</script>')


def list(request):
    types = request.GET.get('type',None)
    keywords = request.GET.get('keywords','')
    statuslist = {'新品':1,'热卖':2,'下架':3}
    print(types,keywords)
    if types == 'typeid':
        from django.db.models import Q
        data = Goods.objects.filter(typeid__contains=keywords).exclude(status=3)
    elif types =='title':
        data = Goods.objects.filter(title__contains=keywords).exclude(status=3)
    elif types =='price':
        data = Goods.objects.filter(price__contains=keywords).exclude(status=3)
    elif types =='storage':
        data = Goods.objects.filter(storage__contains=keywords).exclude(status=3)
    elif types =='clicknum':
        data = Goods.objects.filter(clicknum__contains=keywords).exclude(status=3)
    elif types == 'num':
        data = Goods.objects.filter(num__contains=keywords).exclude(status=3)
    elif types == 'status':
        data = Goods.objects.filter(status__contains=statuslist.get(keywords,'aaa')).exclude(status=3)
    else:
        data = Goods.objects.exclude(status=3)
    # 数据分页类
    from django.core.paginator import Paginator
    paginator = Paginator(data,5)
    # 当前页码
    p = int(request.GET.get('p',1))

    # 根据当前页码获取当前页应该显示的数据
    goodslist = paginator.page(p)
    # 获取当前页的页码数 
    num = paginator.page_range


    context = {'glist':goodslist,'pagenum':num}

    return render(request,'admin/goods/list.html',context)

    # ob=Users.objects.exclude(status=3)
    # print(ob)
    # context={'ulist':ob}
    # return render(request,'admin/user/list.html',context)

def status(request):
    ob=Goods.objects.get(id=request.GET['gid'])
    print(request.GET['gid'])
    ob.status=int(request.GET['status'])
    ob.save()
    return HttpResponse('ok')

def edit(request,gid):
    from . typeviews import GetTypesAll
    ob=Goods.objects.get(id=gid)
    print(ob)
    context={'uinfo':ob,'tlist':GetTypesAll()}
    return render(request,'admin/goods/edit.html',context)


def update(request):
    pic=uploads(request)
    if pic==False:
        return HttpResponse('<script>alert("上传文件类型不正确")')
    try:
        ob=Goods.objects.get(id=request.POST['gid'])
        ob.title=request.POST.get('title')
        ob.price=request.POST.get('price')
        ob.storage=request.POST.get('storage')
        ob.pic=pic
        ob.info=request.POST.get('info')
        if request.FILES.get('pic'):
            if ob.pic != '/static/goodspics/default/default.jpg':
                import os
                os.remove('.'+ob.pic)
            ob.pic=uploads(request)

        ob.save()
        
        return HttpResponse('<script>alert("修改成功");location.href="/admin/goods/list/"</script>')
    except:
        return HttpResponse('<script>alert("修改失败");location.href="/admin/goods/edit/'+str(ob.id)+'"</script>')
def delete(request,gid):
    try:
        ob=Goods.objects.get(id=gid)
        ob.status=3
        ob.save()

        return HttpResponse('<script>alert("删除成功");location.href="/admin/goods/list/"</script>')
    except:
        return HttpResponse('<script>alert("删除失败");location.href="/admin/goods/list/"</script>')



def uploads(request):
    print(request.POST)
    myfile=request.FILES.get('pic',None)
    print(myfile)
    print('1111')
    if not myfile:
        print('222')
        return '/static/goodspics/default/default.jpg'
    import time,random
    filename=str(time.time())+str(random.randrange(10000,99999))
    print('333')
    hzm=myfile.name.split('.').pop()
    arr=['png','jpg','gif','jpeg','bmp','icon']
    if hzm not in arr:
        print('4444')
        return False
    file=open('./static/goodspics/'+filename+'.'+hzm,'wb+')
    print('555')
    for chunk in myfile.chunks():
        print('6666')
        file.write(chunk)
    file.close()
    return '/static/goodspics/'+filename+'.'+hzm