"""web URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from . views import views,typeviews,goodsviews,order


urlpatterns = [
    # url(r'^admin/', admin.site.urls),
    # 后台登录
     url(r'^login/$',views.login,name='admin_login'),
     # # 后台退出
     url(r'^loginout/$',views.loginout,name='admin_loginout'),
     # # 验证码verifycode
     url(r'^getverifycode/$',views.getverifycode,name='admin_getverifycode'),
     # session
     # url(r'^test/$',views.test),
     # ajax
     url(r'^ajax/upload/$',views.ajaxupload,name='admin_ajax_upload'),
     url(r'^ajax/upload/$',goodsviews.ajaxupload,name='admin_goodsajax_upload'),
     

    

    # 后台 用户管理增删改查
    url(r'^$', views.index,name='admin_user_index'),
    url(r'^user/add/$', views.add,name='admin_user_add'),
    url(r'^user/insert/', views.insert,name='admin_user_insert'),
    url(r'^user/list/$', views.list,name='admin_user_list'),
    url(r'^user/status/$', views.status,name='admin_user_status'),
    url(r'^user/update/$', views.update,name='admin_user_update'),
    url(r'^user/edit/(?P<uid>[0-9]+)$', views.edit,name='admin_user_edit'),
    url(r'^user/del/(?P<uid>[0-9]+)$', views.delete,name='admin_user_del'),
    # 后台  商品分类管理的增删改查
    
    url(r'^types/add/$', typeviews.add,name='admin_types_add'),
    url(r'^types/insert/', typeviews.insert,name='admin_types_insert'),
    url(r'^types/list/$', typeviews.list,name='admin_types_list'),
    url(r'^types/update/$', typeviews.update,name='admin_types_update'),
    url(r'^types/edit/(?P<tid>[0-9]+)$', typeviews.edit,name='admin_types_edit'),
    url(r'^types/del$', typeviews.delete,name='admin_types_del'),
    
    # 商品的管理的增删改查
    url(r'^goods/add/$', goodsviews.add,name='admin_goods_add'),
    url(r'^goods/insert/', goodsviews.insert,name='admin_goods_insert'),
    url(r'^goods/list/$', goodsviews.list,name='admin_goods_list'),
    url(r'^goods/update/$', goodsviews.update,name='admin_goods_update'),
    url(r'^goods/edit/(?P<gid>[0-9]+)$', goodsviews.edit,name='admin_goods_edit'),
    url(r'^goods/del/(?P<gid>[0-9]+)$', goodsviews.delete,name='admin_goods_del'),
    url(r'^goods/status/$', goodsviews.status,name='admin_goods_status'),

    # 订单的管理
    
    url(r'^order/list/$', order.list,name='admin_order_list'),
    url(r'^order/status/$', order.status,name='admin_order_status'),
    url(r'^order/edit/(?P<tid>[0-9]+)$', order.edit,name='admin_order_edit'),




    
]

