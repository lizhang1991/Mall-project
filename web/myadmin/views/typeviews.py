from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from .. models import types
from django.contrib.auth.hashers import make_password, check_password
# Create your views here.
def add(request):
    context={'tlist':GetTypesAll()}
    return render(request,'admin/types/add.html',context)

def insert(request):
    try:
        ob=types()
        print(ob)
        ob.name=request.POST.get('typename')
        ob.pid=request.POST.get('upid')
        if ob.pid == '0':
            ob.path='0,'
        else:
            p=types.objects.get(id=ob.pid)
            ob.path=p.path+str(ob.pid)+','
        ob.save()
   
    
        return HttpResponse('<script>alert("添加成功");location.href="/admin/types/list/"</script>')
    except:
        return HttpResponse('<script>alert("添加失败");location.href="/admin/types/add/"</script>')


def list(request):
    type_s=request.GET.get('type',None)
    keywords=request.GET.get('keywords','')
    print(types,keywords)
    if type_s == 'name':
        from django.db.models import Q
        data=types.objects.filter(name__contains = keywords)
        for x in data:
            if x.pid == 0:
                x.pname = '顶级分类'
            else:
                p = types.objects.get(id=x.pid)
                x.pname = p.name
    # elif type_s == 'path':
    #     data=types.objects.filter(path__contains=keywords)
    #     for x in data:
    #         if x.pid == 0:
    #             x.pname = '顶级分类'
    #         else:
    #             p = Types.objects.get(id=x.pid)
    #             x.pname = p.name

    elif type_s=='id':
        data=types.objects.filter(id__contains=keywords)
        for x in data:
            if x.pid == 0:
                x.pname = '顶级分类'
            else:
                p = types.objects.get(id=x.pid)
                x.pname = p.name
    # elif type_s=='pid':
    #     data =types.objects.filter(pid__contains=keywords)
    #     for x in data:
    #         if x.pid == 0:
    #             x.pname = '顶级分类'
    #         else:
    #             p = Types.objects.get(id=x.pid)
    #             x.pname = p.name
    else:
        data=GetTypesAll()
    from django.core.paginator import Paginator
    paginator=Paginator(data,5)
    p=int(request.GET.get('p',1))
    typelist=paginator.page(p)
    num=paginator.page_range
    context={'tlist':typelist,'pagenum':num}

    # print(GetTypesAll()['pname'])


    # data['pname']=GetTypesAll()['pname']


    return render(request,'admin/types/list.html',context)

    



def edit(request,tid):
    
    
    ob=types.objects.get(id=tid)
    context={'tinfo':ob,'tlist':GetTypesAll()}
    # return HttpResponse('A')
    return render(request,'admin/types/edit.html',context)


def update(request):
    try:
        ob=types.objects.get(id=request.POST['tid'])
        print(ob)
        ob.name=request.POST['name']  

        ob.save()
        
        return HttpResponse('<script>alert("修改成功");location.href="/admin/types/list/"</script>')
    except:
        return HttpResponse('<script>alert("修改失败");location.href="/admin/types/edit/'+str(ob.id)+'"</script>')
def delete(request):
  
    num=types.objects.filter(pid=request.GET['tid']).count()
    if num:
        return JsonResponse({'status':1,'msg':'当前类下还有子类，不能删除'})
    ob=types.objects.get(id=request.GET['tid'])
    ob.delete()

    return JsonResponse({'status':0,'msg':'可以删除'})


def GetTypesAll():
    ob=types.objects.extra(select={'paths':'concat(path,id)'}).order_by('paths')
    print(ob)
    for x in ob:
        n= int(len(x.path)/2)-1
        x.name=(n*'|----')+x.name
        if x.pid==0:
            x.pname='顶级分类'
        else:
            obj=types.objects.get(id=x.pid)
            x.pname=obj.name
    return ob
