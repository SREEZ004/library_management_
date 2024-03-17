"""Library_management URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from .import views

urlpatterns = [
    path('', views.home),
    path('home/', views.home),
    path('login/', views.login),
    path('user_register/', views.user_register),
    path('books/', views.books),
    

    path('add_category/', views.add_category),
    path('up_category/',views.up_category),
    path('update_category/',views.update_category),
    path('delete_category/', views.delete_category),

    path('add_news/', views.add_news),
    path('up_news/',views.up_news),
    path('edit_news/',views.edit_news),
    path('delete_news/', views.delete_news),
    path('active_news/', views.active_news),
    path('inactive_news/', views.inactive_news),
    path('news/', views.news),
    path('request_details/', views.request_details),
    path('borrow_reject/', views.borrow_reject),
    path('forgot_password/', views.forgot_password),
    path('borrow_book_home/', views.borrow_book_home),
    path('borrow_request_home/', views.borrow_request_home),
    path('reject_home/', views.reject_home),

    path('add_book/', views.add_book),
    path('view_books/', views.view_books),
    path('up_book/', views.up_book),
    path('edit_book/', views.edit_book),
    path('master_home/', views.master_home),
    path('book_search/', views.book_search),
    path('borrow_request/', views.borrow_request),
    path('borrow_approval/', views.borrow_approval),

    path('delete_book/', views.delete_book),
    path('borrow_details/', views.borrow_details),
    path('update_return/', views.update_return),
    path('borrowed_history/', views.borrowed_history),
    path('member_dues/', views.member_dues),
    path('pay/', views.pay),
    path('pay_now/', views.pay_now),

    path('deliver_page/', views.deliver_page),
    path('deliver_book/', views.deliver_book),

    path('user_list/', views.user_list),
    path('subscription_details/', views.subscription_details),
    path('reservation_details/', views.reservation_details),
    path('reply/', views.reply),
    path('view_donations/', views.view_donations),
    path('approve_borrow/', views.approve_borrow),

    path('book_donation/', views.book_donation),
    path('member_home/', views.member_home),
    path('subscription/', views.subscription),
    path('more/', views.more),
    path('borrow_book/', views.borrow_book),
    path('reserve_book/', views.reserve_book),
    path('feedback/', views.feedback),
    path('profile/', views.profile),
    path('change_password/', views.change_password),
    # path('gen_pdf/', views.gen_pdf),

    path('book_search_title/', views.book_search_title),
    path('sign_out/', views.sign_out),
    path('master_register/', views.master_register),
    path('check_username/', views.check_username),
    path('check_email/', views.check_email),
]
