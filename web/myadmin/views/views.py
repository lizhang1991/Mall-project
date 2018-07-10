from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from .. models import Users
from django.contrib.auth.hashers import make_password, check_password
# Create your views here.
# 用户视图函数
def ajaxupload(request):
    import time,random

    myfile = request.FILES.get('pic',None)
  
    # 判断是否有文件上传
    if not myfile:
        return JsonResponse({'code':1,'msg':'没有文件上传'})

    # 执行文件上传
    # 自定义文件名 时间戳+随机数+.jpg
    filename = str(time.time())+str(random.randrange(10000,99999))

    # 获取当前上传文件的后缀名
    hzm = myfile.name.split('.').pop()
 
    # 允许上传的文件类型
    arr = ['png','jpg','gif','jpeg','bmp','icon']
    # 如果上传的文件类型不正确
    if hzm not in arr:
        return JsonResponse({'code':2,'msg':'上传的文件类型错误'})

    # 打开文件
    file = open('./static/pics/'+filename+'.'+hzm,'wb+')
    # 分块写入文件  
    for chunk in myfile.chunks():  
        
           file.write(chunk)  
    # 关闭文件
    file.close()

    # 返回文件的url路径
    return JsonResponse({'code':0,'msg':'上传成功','url':'/static/pics/'+filename+'.'+hzm})
    


    # return HttpResponse('ajaxupload')



def index(request):

    return render(request,'admin/index.html')

def login(request):
    if request.method == 'GET':
        return render(request,'admin/login.html')
    elif request.method=='POST':
        if request.POST['vcode'].lower() != request.session['verifycode'].lower():
            return HttpResponse('<script>alert("验证码错误");location.href="/admin/login"</script>')
        ob=Users.objects.filter(username=request.POST['username'])
        if ob:
            ob=ob[0]
            if check_password(request.POST['password'],ob.password):
                if ob.status == 2:
                    request.session['AdminUser'] ={'name':ob.username,'pic':ob.picurl}
                    return HttpResponse('<script>alert("登录成功");location.href="/admin/"</script>')
                else:

                    return HttpResponse('<script>alert("没有权限登录");location.href="/admin/login/"</script>')

            else:
                return HttpResponse('<script>alert("密码不正确");location.href="/admin/login/"</script>')

        else:
            return HttpResponse('<script>alert("用户不存在");location.href="/admin/login/"</script>')


    return HttpResponse('<script>alert("用户名或密码不存在");location.href="/admin/login/"</script>')
    return render(request,'admin/login.html')

def loginout(request):
    del request.session['AdminUser']
    return HttpResponse('<script>alert("退出登录成功");location.href="/admin/login/"</script>')

def add(request):
    return render(request,'admin/user/add.html')

def insert(request):
    pic=uploads(request)
    if pic==False:
        return HttpResponse('<script>alert("上传文件类型不正确")')
    try:
        ob=Users()
        ob.username=request.POST.get('username')
        ob.password=make_password(request.POST['password'], None, 'pbkdf2_sha256')
        ob.email=request.POST.get('email')
        ob.phone=request.POST.get('phone')
        ob.sex=request.POST.get('sex')
        ob.age=request.POST.get('age')
        ob.picurl=request.POST.get('picurl')
        ob.save()
   

        return HttpResponse('<script>alert("添加成功");location.href="/admin/user/list/"</script>')
    except:
        return HttpResponse('<script>alert("添加失败");location.href="/admin/user/add/"</script>')


def list(request):
    types = request.GET.get('type',None)
    keywords = request.GET.get('keywords','')
    statuslist = {'正常':0,'禁用':1}
    print(types,keywords)
    if types == 'all':
        from django.db.models import Q
        data = Users.objects.filter(Q(username__contains=keywords)|Q(email__contains=keywords)|Q(phone__contains=keywords)|Q(age__contains=keywords)|Q(sex__contains=keywords)|Q(status__contains=statuslist.get(keywords,'aa'))).exclude(status=3)
    elif types =='username':
        data = Users.objects.filter(username__contains=keywords).exclude(status=3)
    elif types =='email':
        data = Users.objects.filter(email__contains=keywords).exclude(status=3)
    elif types =='phone':
        data = Users.objects.filter(phone__contains=keywords).exclude(status=3)
    elif types =='age':
        data = Users.objects.filter(age__contains=keywords).exclude(status=3)
    elif types == 'sex':
        data = Users.objects.filter(sex__contains=keywords).exclude(status=3)
    # elif types == 'status':
        # data = Users.objects.filter(status__contains=statuslist.get(keywords,'aaa')).exclude(status=3)
    else:
        data = Users.objects.exclude(status=3)
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

    return render(request,'admin/user/list.html',context)

    # ob=Users.objects.exclude(status=3)
    # print(ob)
    # context={'ulist':ob}
    # return render(request,'admin/user/list.html',context)

def status(request):
    ob=Users.objects.get(id=request.GET['uid'])
    print(request.GET['uid'])
    ob.status=int(request.GET['status'])
    ob.save()
    return HttpResponse('ok')

def edit(request,uid):
    ob=Users.objects.get(id=uid)
    context={'uinfo':ob}
    return render(request,'admin/user/edit.html',context)


def update(request):
    try:


        ob=Users.objects.get(id=request.POST['id'])
        ob.username=request.POST.get('username')
        ob.email=request.POST.get('email')
        ob.phone=request.POST.get('phone')
        ob.age=request.POST.get('age')
        ob.sex=request.POST.get('sex')
        # ob.picurl=request.POST.get('picurl')
        if request.FILES.get('pic'):
            print(request.FILES.get('pic'))
            if ob.picurl != '/static/pics/default/default.jpg':
                import os
                os.remove('.'+ob.picurl)
        ob.picurl=uploads(request)

        ob.save()
        
        return HttpResponse('<script>alert("修改成功");location.href="/admin/user/list/"</script>')
    except:
        return HttpResponse('<script>alert("修改失败");location.href="/admin/user/edit/'+str(ob.id)+'"</script>')
def delete(request,uid):
    try:
        ob=Users.objects.get(id=uid)
        ob.status=3
        ob.save()

        return HttpResponse('<script>alert("删除成功");location.href="/admin/user/list/"</script>')
    except:
        return HttpResponse('<script>alert("删除失败");location.href="/admin/user/list/"</script>')



def uploads(request):
    import time,random
    myfile=request.FILES.get('pic',None)
    
    if not myfile:
        return '/static/pics/default/default.jpg'
    
    filename=str(time.time())+str(random.randrange(10000,99999))
    hzm=myfile.name.split('.').pop()
    arr=['png','jpg','gif','jpeg','bmp','icon']
    if hzm not in arr:  
        return False
    file=open('./static/pics/'+filename+'.'+hzm,'wb+')
    for chunk in myfile.chunks():
        file.write(chunk)
    file.close()
    return '/static/pics/'+filename+'.'+hzm


def getverifycode(request):
    #引入绘图模块
    from PIL import Image, ImageDraw, ImageFont
    #引入随机函数模块
    import random
    #定义变量，用于画面的背景色、宽、高
    bgcolor = (random.randrange(20, 100), random.randrange(
        20, 100), 255)
    width = 100
    height = 25
    #创建画面对象
    im = Image.new('RGB', (width, height), bgcolor)
    #创建画笔对象
    draw = ImageDraw.Draw(im)
    #调用画笔的point()函数绘制噪点
    for i in range(0, 100):
        xy = (random.randrange(0, width), random.randrange(0, height))
        fill = (random.randrange(0, 255), 255, random.randrange(0, 255))
        draw.point(xy, fill=fill)
    #定义验证码的备选值
    # str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
    str1 = '123456789'
    #随机选取4个值作为验证码
    rand_str = ''
    for i in range(0, 4):
        rand_str += str1[random.randrange(0, len(str1))]
    #构造字体对象
    font = ImageFont.truetype('FreeMono.ttf', 23)
    #构造字体颜色
    fontcolor = (255, random.randrange(0, 255), random.randrange(0, 255))
    #绘制4个字
    draw.text((5, 2), rand_str[0], font=font, fill=fontcolor)
    draw.text((25, 2), rand_str[1], font=font, fill=fontcolor)
    draw.text((50, 2), rand_str[2], font=font, fill=fontcolor)
    draw.text((75, 2), rand_str[3], font=font, fill=fontcolor)
    #释放画笔
    del draw
    #存入session，用于做进一步验证
    request.session['verifycode'] = rand_str
    #内存文件操作
    import io
    buf = io.BytesIO()
    #将图片保存在内存中，文件类型为png
    im.save(buf, 'png')
    #将内存中的图片数据返回给客户端，MIME类型为图片png
    return HttpResponse(buf.getvalue(), 'image/png')


