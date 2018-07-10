from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from myadmin.models import Users,types,Goods,Address,Order,OrderInfo
from django.contrib.auth.hashers import make_password, check_password
# Create your views here.




def gettype():
    # 获取所有的二级分类
    data=types.objects.exclude(pid=0)
    return data

def index(request):
    data=types.objects.filter(pid=0)
    for x in data:
        x.sub=types.objects.filter(pid=x.id)
        for v in x.sub:
            v.sub=Goods.objects.filter(typeid=v.id)[:6]

    context={'typelist':gettype(),'navlist':data}
    return render(request,'home/index.html',context)



def login(request):
    if request.method=='GET':

        return render(request,'home/login.html')
    elif request.method=='POST':
        if request.POST['code'].lower() != request.session['verifycode'].lower():
            return HttpResponse('<script>alert("验证码错误");location.href="/login/"</script>')
        ob=Users.objects.filter(username=request.POST['username'])
        if ob:
            ob=ob[0]
            if check_password(request.POST['password'],ob.password):

                request.session['VipUser']={'name':ob.username,'pic':ob.picurl,'uid':ob.id}
                return HttpResponse('<script>alert("登录成功");location.href="/"</script>')
        return HttpResponse('<script>alert("用户名或密码错误");location.href="/login/"</script>')





def loginout(request):
    del request.session['VipUser']

    return HttpResponse('<script>location.href="/"</script>')


def register(request):

    # 判断当前请求的方式
    if request.method=='GET':
        return render(request,'home/register.html')
    elif request.method=='POST':
    # 执行注册
    # 判断用户是否存在
        res = Users.objects.filter(username=request.POST['username']).exists()
        if res:
            return HttpResponse('<script>alert("用户名已存在");location.href="/register"</script>')
    # 把用户信息存储到session
        else:
            ob=Users()
            print(ob)
            ob.username=request.POST['username']
            ob.password=make_password(request.POST['password'],None,'pbkdf2_sha256')
            ob.save()
            return HttpResponse('<script>alert("注册成功");location.href="/login/"</script>')

    # return render(request,'home/register.html')



def list(request,tid):
    # {'name':'服装','sub':[{'name':'男装'},{'name':'女装'}],'goods':[{},{},{},{}]}
    # 根据id获取当前分类的信息
    tod=types.objects.get(id=tid)
    if tod.pid==0:
        # 顶级分类
        data=tod
        # 获取子类
        data.sub=types.objects.filter(pid=tod.id)
        ids=[]
        for x in data.sub:
            ids.append(x.id)
        data.goods=Goods.objects.filter(typeid__in=ids)
    else:
        # 先获取父级对象
        data=types.objects.get(id=tod.pid)
        # 获取当前子类的商品信息
        data.goods=Goods.objects.filter(typeid=tod.id)
        # 获取所有的同级信息,包括当前类
        data.sub=types.objects.filter(pid=tod.pid)
        # 给data数据追加了一个obj对象
        data.obj=tod
    context={'typelist':gettype(),'data':data}
    return render(request,'home/list.html',context)



def info(request,gid):
    ginfo=Goods.objects.get(id=gid)
    context={'typelist':gettype(),'ginfo':ginfo}
    return render(request,'home/info.html',context)
    

# 加入购物车
def cartadd(request):
    try:
        # 接收商品id
        gid = request.GET['gid']
        # 加入购物车的数量
        num = int(request.GET['num'])

        # 获取购物车数据
        data = request.session.get('cart',{})
        
        # 判断商品是否已经存在与购物车中
        # {1:{},2:{}}
        if gid in data:
            # 如果已经存在,找到商品,修改数量
            data[gid]['num'] += num
        else:
            # 获取商品信息
            goods = Goods.objects.get(id=gid)
            # 把新的商品信息,追加到data数据中
            data[gid] = {'id':goods.id,'title':goods.title,'price':str(goods.price),'pic':goods.pic,'num':num}

        # 加入到session {1:{},2:{}}
        request.session['cart'] = data
        print(request.session['cart'])


        return JsonResponse({'code':0,'msg':'加入购物车成功'})
    # return HttpResponse('<script>alert("加入购物车成功");location.href="home/cartlist.html"</script>')
    except:
        return JsonResponse({'code':1,'msg':'加入购物车失败'})


# 购物车列表
def cartlist(request):


    context = {'typelist':gettype()}
    return render(request,'home/cartlist.html',context)


# 清空购物车
def cartclear(request):

    request.session['cart'] = {}

    return HttpResponse('<script>location.href="/cart/list/"</script>')


def cartedit(request):
    gid=request.GET.get('gid')
    num=int(request.GET.get('num'))
    data=request.session['cart']
    data[gid]['num']=num
    request.session['cart']=data
    return HttpResponse('<script>location.href="/cart/list/"</script>')

def cartdel(request):
    gid=request.GET['gid']
    data=request.session['cart']
    del data[gid]
    request.session['cart']=data
    return HttpResponse('aa')

# 确认订单
def orderconfirm(request):
    # print(request.GET['ids'])
    # print(request.session['cart'])
    # for i in request.session:
    #     print(request.session[i])
    # return HttpResponse('aa')

    if request.method == 'GET':

        # 获取用户选择的商品
        ids = request.GET['ids'].split(',')

        
        # 从session中读取购物车信息
        cartdata = request.session['cart']
        orderdata = {}

        for x in cartdata:
            if x in ids:
                orderdata[x] = cartdata[x]

        # 把用户选择购买的商品存入session
        request.session['order'] = orderdata

        # 需要让用户确认收货地址 获取当前用户的所有地址信息
        address = Address.objects.filter(uid=request.session['VipUser']['uid'])

        context = {'typelist':gettype(),'address':address}
        return render(request,'home/orderconfirm.html',context)

    elif request.method == 'POST':

        # 执行地址的添加
        ob = Address()
        ob.uid = Users.objects.get(id=request.session['VipUser']['uid'])
        ob.aname = request.POST['aname']
        ob.aphone = request.POST['aphone']
        ob.aads = request.POST['aads']

        # 状态修改
        s = request.POST.get('status',0)
        # 判断当前如果设置为默认值,
        if s == '1':
            # 把其它的地址修改状态 0 
            obs = Address.objects.filter(status=1)
            for x in obs:
                x.status = 0
                x.save()

        ob.status = s
        ob.save()
        return HttpResponse('<script>alert("地址添加成功");location.href="/order/confirm/?ids='+request.GET['ids']+'"</script>')


# 生成订单
def ordercreate(request):

    # 在session获取订单数据
    data = request.session['order']
    totalprice = 0
    totalnum = 0

    for x in data:
        n = float(data[x]['price']) * data[x]['num']
        totalprice += n
        totalnum += data[x]['num']


    # 创建订单
    order = Order()
    order.uid = Users.objects.get(id=request.session['VipUser']['uid'])
    order.address = Address.objects.get(id=request.POST['addressid'])
    order.totalprice = totalprice
    order.totalnum = totalnum
    order.status = 1
    order.save()
    
    # 读取购物车数据
    cart = request.session['cart']

    # 创建订单详情
    for x in data:
        orderinfo  = OrderInfo()
        # 订单号
        orderinfo.orderid = order
        # 获取当前购买的商品对象
        goods = Goods.objects.get(id=x)

        orderinfo.gid = goods
        orderinfo.num = data[x]['num']
        orderinfo.price = data[x]['price']
        orderinfo.save()
        # 清楚购物车的商品数据
        del cart[x]

        # 修改商品的购买数量
        goods.num +=  data[x]['num']
        goods.storage -= data[x]['num']
        goods.save()

        
    # 清空session中的订单数据
    request.session['order'] = {}
    # 更新购物车
    request.session['cart']= cart

    # 跳转到付款页面
    return HttpResponse('<script>alert("订单创建成功,请立即支付");location.href="/order/buy/?orderid='+str(order.id)+'"</script>')



# 付款页面
def orderbuy(request):
    orderid = request.GET.get('orderid',None)
    if orderid:
        # 通过订单id获取订单信息,并展示
        order = Order.objects.get(id=orderid)
        context = {'order':order}
        return render(request,'home/buy.html',context)


# 我的订单
def myorder(request):

    # 获取当前登录用户的所有订单信息
    orders = Order.objects.filter(uid=request.session['VipUser']['uid'])

    context = {'orders':orders}
    return render(request,'home/myorder.html',context)

# 我的个人中心
def member(request):
    
    if request.method == 'GET':  
        ob=Users.objects.get(id=request.session['VipUser']['uid'])
        orders = Order.objects.filter(uid=request.session['VipUser']['uid'])
        address = Address.objects.filter(uid=request.session['VipUser']['uid'])
        context={'myuser':ob,'orders':orders,'address':address}
        return render(request,'home/member.html',context)
    elif request.method == "POST":

        address= Address()
        address.uid = Users.objects.get(id=request.session['VipUser']['uid'])
        address.aname = request.POST['aname']
        address.aphone = request.POST['aphone']
        address.aads = request.POST['aads']
        address.save()
        return HttpResponse('<script>alert("添加地址成功");location.href="/member/"</script>')


 #个人信息修改   
def edit(request,tid):
    ob=Users.objects.get(id=tid)
    # print(ob)
    context={'uinfo':ob}
    # return HttpResponse('aa')
    return render(request,'home/edit.html',context)
# 个人信息修改
def update(request):
    # print(request.session['VipUser']['name'])
    try:
        
      
        ob=Users.objects.get(id=request.POST['id'])
        ob.username=request.POST.get('username')
        ob.email=request.POST.get('email')
        ob.phone=request.POST.get('phone')
        ob.age=request.POST.get('age')
        ob.sex=request.POST.get('sex')
        if request.FILES.get('pic'):
            if ob.picurl != '/static/pics/default/default.jpg':
                import os
                os.remove('.'+ob.picurl)
                ob.picurl=uploads(request)

        ob.save()
        print(request.session['VipUser']['name'])
        usersesion=request.session['VipUser']
        
        usersesion['name']=ob.username
        request.session['VipUser']=usersesion


        return HttpResponse('<script>alert("修改成功");location.href="/member/"</script>')
    except:
        return HttpResponse('<script>alert("修改失败");location.href="/edit/'+str(ob.id)+'"</script>')





def uploads(request):
    print(request.POST)
    myfile=request.FILES.get('pic',None)
    print(myfile)

    if not myfile:
        print('222')
        return '/static/pics/default/default.jpg'
    import time,random
    filename=str(time.time())+str(random.randrange(10000,99999))

    hzm=myfile.name.split('.').pop()
    arr=['png','jpg','gif','jpeg','bmp','icon']
    if hzm not in arr:
        print('4444')
        return False
    file=open('./static/pics/'+filename+'.'+hzm,'wb+')

    for chunk in myfile.chunks():

        file.write(chunk)
    file.close()
    return '/static/pics/'+filename+'.'+hzm


def addressedit(request):
    print(request.GET['aid'])
    ob=Address.objects.get(id=request.GET['aid'])
    print(ob)
    # return HttpResponse('aa')


    # return JsonResponse({'uinfo':ob})
    
    return render(request,'home/addressedit.html',{'uinfo':ob})




def addressupdate(request):
    try:
        ob=Address.objects.get(id=request.POST['id'])
        ob.aname=request.POST.get('aname')
        ob.aads=request.POST.get('aads')
        ob.aphone=request.POST.get('aphone')
        ob.save()
    # return HttpResponse('ok')
        return HttpResponse('<script>alert("修改成功");location.href="/member/"</script>')
    except:
        return HttpResponse('<script>alert("修改失败");location.href="/edit/'+str(ob.id)+'"</script>')









# session的使用
def test(request):


    # 设置session
    request.session['a'] = 'abc'
        # request.session['b'] = ['b1','b2','b3']
        # request.session['c'] = {'name':'ccc','age':20}
        # request.session['d'] = [{'name':'ccc1','age':20},{'name':'ccc2','age':20},{'name':'ccc3','age':20}]

    # 获取session
        # res1 = request.session['b']
        # res2 = request.session.get('c','123')

        # print(res1)
        # print(res2)

    # 修改
        # res = request.session['b']
        # res[2] = 'c3'
        # request.session['b'] = res
        # print(request.session['b'])

    # 删除单个key
        # del request.session['b']
   

    # 清除当前会话中的所有key
        # request.session.clear() 

        # print(request.session.get('a'))
        # print(request.session.get('b'))
        # print(request.session.get('c'))
        # print(request.session.get('d'))

    # 删除当前的会话数据
    # request.session.flush()


    # 应用场景   登录,注册   购物车  


    return HttpResponse('session的使用')