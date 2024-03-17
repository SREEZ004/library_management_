from django.shortcuts import render,redirect,HttpResponse
from django.contrib.auth.hashers import make_password
from .models import *
from django.contrib import messages
from django.db import connection
from django.contrib.auth import logout
from django.core.files.storage import FileSystemStorage
from django.http import JsonResponse
from django.db.models import Q
from datetime import date,datetime,timedelta
from email.message import EmailMessage
import ssl
import smtplib
from hashlib import sha256
# from reportlab.lib import colors
# from reportlab.lib.pagesizes import letter, landscape
# from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
# from django.shortcuts import get_object_or_404


# cursor = connection.cursor()
now = datetime.now()
today = date.today()

# Create your views here.
def home(request):
    if 'log_id' in request.session:
        user = request.session['log_id']
        data = Login.objects.get(log_id=user)

        if data.role == 'master':
            request.session['master'] = data.log_id
            return redirect('/master_home')
        elif data.role == 'member':
            me = Member_register.objects.get(log_id=user)
            request.session['member'] = me.m_id
            return redirect('/member_home')
        else:
            return redirect('/home')  
    else:
        data = Borrowed_book.objects.filter(status='Not Returned',return_date__lt=today)
        for i in data:
            Dues.objects.create(m_id=i.m_id,bd_id=i.bd_id,fine=20,status='Not paid')
            Borrowed_book.objects.filter(bd_id=i.bd_id).update(status='dues')
        return render(request,'home.html')


def login(request):
    if request.method == 'POST':
        username = request.POST['username']
        passw = request.POST['password']
        password = sha256(passw.encode()).hexdigest()
        try:
            data = Login.objects.get(username=username,password= password)
            if data.password == password:
                request.session['log_id'] = data.log_id
                return redirect('/home')
            else:
                messages.success(request,'Invalid Username Or Password')
                return redirect(login)
        except Exception:
            messages.success(request, 'Invalid Username Or Password')
            return redirect(login)
    else:
        return render(request,'login.html')


def user_register(request):
    if request.method == 'POST':
            name = request.POST['name']
            contact_no = request.POST['phone']
            email = request.POST['email']
            address = request.POST['address']
            username = request.POST['username']
            passw = request.POST['password']
            password = sha256(passw.encode()).hexdigest()

            dt = Member_register.objects.last()
            membership_id=''
            v=''
            if dt is None:
                membership_id = 'Z253981'
            else:
                
                mid = dt.membership_id
                for i in range(1,len(mid)):
                    v=v+mid[i]
                membership_id = 'Z'+str(int(v)+1)

            try:
                Login.objects.get(username=username)
                Member_register.objects.get(email=email)
                messages.success(request, 'This username or email is already Exist.....')
                return redirect('/user_register')
            except Exception:           
                email_sender="***"    
                email_password="***" 
                email_receiver=request.POST['email']
                subject="Library Membership"
                
                body="""Name: """  +str(name)+"""\n\nAddress: """  +str(address)+"""\n\n"""+str(name)+"""  You Have Got A Membership In the Library\n\nMembership taken Date:  """+str(today)+"""\n\nYour Membership Id Is:  """+str(membership_id)+""""""
                em=EmailMessage()
                em['From']=email_sender
                em['To']=email_receiver
                em['Subject']=subject
                em.set_content(body)
                context=ssl.create_default_context()
                with smtplib.SMTP_SSL('smtp.gmail.com',465,context=context) as smtp:
                    smtp.login(email_sender,email_password)
                    smtp.sendmail(email_sender,email_receiver,em.as_string())
                
                Login.objects.create(username=username,password=password,role='member')
                d = Login.objects.get(username=username)

                Member_register.objects.create(name=name,contact_no=contact_no,email=email,address=address,membership_id=membership_id,membership_taken_date=today,log_id=d.log_id)
                messages.success(request, 'Registered successfully.....')
                return redirect('/user_register')
    else:
        return render(request,'register.html')

def books(request):     
    data = Book_details.objects.select_related('c')
    data2 = Book_category.objects.all()
    return render(request,'books.html',{'data':data,'data2':data2})
        
def book_donation(request):  
    if request.method == 'POST':
            name = request.POST['name']
            contact_no = request.POST['phone']
            email = request.POST['email']
            book_details = request.POST['book_details']
            Book_donation.objects.create(name=name,contact_no=contact_no,email=email,book_details=book_details)
            messages.success(request,'Submitted successfully')
            return redirect('/book_donation')
    else:
        return render(request,'book_donation.html')


def news(request):     
    data = News.objects.filter(status='active').order_by('-n_id')
    if 'member' in request.session:
        return render(request,'member/news.html',{'data':data})
    else:
        return render(request,'news.html',{'data':data})



#-------------------master-------------------
def master_home(request):
    if 'master' in request.session:
        data = Borrowed_book.objects.filter(status='Not Returned',return_date__lt=today)
        for i in data:
            Dues.objects.create(m_id=i.m_id,bd_id=i.bd_id,fine=20,status='Not paid')
            Borrowed_book.objects.filter(bd_id=i.bd_id).update(status='dues')
        return render(request,'master/home.html')
    else:
        return redirect('/home')
    
def add_news(request):
    if 'master' in request.session:
        if request.method == 'POST':
            title = request.POST['title']
            description = request.POST['description']
            News.objects.create(title=title,description=description,status='Not active')
            messages.success(request,'News added successfully')
            return redirect('/add_news')
        else:
            data = News.objects.all()
            return render(request,'master/add_news.html',{'data':data})
    else:
        return redirect('/home')
    
def up_news(request):
    if 'master' in request.session:
        data=News.objects.filter(n_id=request.GET['n_id'])
        return render(request,'master/edit_news.html',{'data':data})
    else:
        return redirect('/home')
    
def edit_news(request):
    if 'master' in request.session:
        if request.method == 'POST':
            n_id = request.POST['n_id']
            title = request.POST['title']
            description = request.POST['description']
            News.objects.filter(n_id=n_id).update(title=title,description=description)
            messages.success(request, 'Updated successfully')
            return redirect('/add_news')
        else: 
            return redirect('/add_news')
    else:
        return redirect('/home')

def delete_news(request):
    if 'master' in request.session:
        data  = News.objects.get(n_id=request.GET['n_id'])
        data.delete()
        messages.success(request, 'Deleted successfully')
        return redirect ('/add_news')
    else:
        return redirect('/home')
    
def active_news(request):
    if 'master' in request.session:
        News.objects.filter(n_id=request.GET['n_id']).update(status='active')
        messages.success(request, 'News Published successfully')
        return redirect ('/add_news')
    else:
        return redirect('/home')
    
def inactive_news(request):
    if 'master' in request.session:
        News.objects.filter(n_id=request.GET['n_id']).update(status='Not active')
        messages.success(request, 'News inactive Now')
        return redirect ('/add_news')
    else:
        return redirect('/home')

def add_category(request):
    if 'master' in request.session:
        if request.method == 'POST':
            category = request.POST['category']
            Book_category.objects.create(category_name=category)
            messages.success(request,'Book category added successfully')
            return redirect('/add_category')
        else:
            data = Book_category.objects.all()
            return render(request,'master/add_category.html',{'data':data})
    else:
        return redirect('/home')
    
def up_category(request):
    if 'master' in request.session:
        data=Book_category.objects.filter(bc_id=request.GET['bc_id'])
        return render(request,'master/update_category.html',{'data':data})
    else:
        return redirect('/home')
    
def update_category(request):
    if 'master' in request.session:
        if request.method == 'POST':
            bc_id = request.POST['bc_id']
            category = request.POST['category']
            Book_category.objects.filter(bc_id=bc_id).update(category_name=category)
            messages.success(request, 'Updated successfully')
            return redirect('/add_category')
        else: 
            return redirect('/add_category')
    else:
        return redirect('/home')
    
def delete_category(request):
    if 'master' in request.session:
        data  = Book_category.objects.get(bc_id=request.GET['bc_id'])
        data.delete()
        messages.success(request, 'Book category deleted successfully')
        return redirect ('/add_category')
    else:
        return redirect('/home')

def add_book(request):
    if 'master' in request.session:
        if request.method == 'POST':
            c_id = request.POST['c_id']
            book_title = request.POST['book_title']
            img = request.FILES['image']
            author = request.POST['author']
            publisher = request.POST['publisher']
            published_date = request.POST['published_date']
            no_of_pages = request.POST['no_of_pages']
            no_of_copies = request.POST['no_of_copies']
            description = request.POST['description']
            additional_data = request.POST['additional_data']


            obj = FileSystemStorage()
            fl = obj.save(img.name,img)
            image = obj.url(fl)

            Book_details.objects.create(c_id=c_id,book_title=book_title,image=image,author=author,publisher=publisher,published_date=published_date,
                                        no_of_pages=no_of_pages,copies=no_of_copies,no_of_copies=no_of_copies,description=description,additional_data=additional_data)
            messages.success(request,'Book added successfully')
            return redirect('/add_book')
        else:
            data = Book_category.objects.all()
            return render(request,'master/add_book.html',{'data':data})
    else:
        return redirect('/home')

def up_book(request):
    if 'master' in request.session:
        data = Book_details.objects.filter(b_id=request.GET['b_id'])
        data2 = Book_category.objects.all()
        return render(request,'master/edit_book.html',{'data':data,'data2':data2})
    else:
        return redirect('/home')

def edit_book(request):
    if 'master' in request.session:
        if request.method == 'POST':
            b_id = request.POST['b_id']
            c_id = request.POST['c_id']
            book_title = request.POST['book_title']
            author = request.POST['author']
            publisher = request.POST['publisher']
            published_date = request.POST['published_date']
            no_of_pages = request.POST['no_of_pages']
            no_of_copies = request.POST['no_of_copies']
            description = request.POST['description']
            additional_data = request.POST['additional_data']


            if len(request.FILES) == 0:
                Book_details.objects.filter(b_id=b_id).update(c_id=c_id,book_title=book_title,author=author,publisher=publisher,published_date=published_date,
                                        no_of_pages=no_of_pages,no_of_copies=no_of_copies,description=description,additional_data=additional_data)
                messages.success(request,'Updated successfully')

            else:
                img = request.FILES['image']
                obj = FileSystemStorage()
                fl = obj.save(img.name,img)
                image = obj.url(fl)

                Book_details.objects.create(c_id=c_id,book_title=book_title,image=image,author=author,publisher=publisher,published_date=published_date,
                                            no_of_pages=no_of_pages,no_of_copies=no_of_copies,description=description,additional_data=additional_data)
                messages.success(request,'Updated successfully')
            return redirect('/view_books')
        else:
            return redirect('/view_books')
    else:
        return redirect('/home')


def view_books(request):
    if 'master' in request.session:
        data = Book_details.objects.select_related('c')
        return render(request,'master/view_books.html',{'data':data})
    else:
        return redirect('/home')
    
def delete_book(request):
    if 'master' in request.session:
        data = Book_details.objects.get(b_id=request.GET['b_id'])
        data.delete()
        messages.success(request, 'Book deleted successfully')
        return redirect('/view_books')
    else:
        return redirect('/home')
    

def user_list(request):
    if 'master' in request.session:
        data = Member_register.objects.all()
        return render(request,'master/user_list.html',{'data':data})
    else:
        return redirect('/home')
    
def subscription_details(request):
    if 'master' in request.session:
        data = Subscription.objects.select_related('m')
        return render(request,'master/subscription_details.html',{'data':data})
    elif 'member' in request.session:
        data = Subscription.objects.filter(m_id=request.session['member']).select_related('m')
        return render(request,'member/subscription_details.html',{'data':data})
    else:
        return redirect('/home')

def borrow_request(request):
    if 'master' in request.session:
        data = Borrowed_book.objects.filter(status='request')
        return render(request,'master/borrow_request.html',{'data':data})
    else:
        return redirect('/home')
    
def borrow_request_home(request):
    if 'master' in request.session:
        data = Borrowed_book.objects.filter(Q(status='request_home')|Q(status='no_delivary')|Q(status='deliver')|Q(status='Not Returned')|Q(status='Returned')|Q(status='rejected')).order_by('-bd_id')
        return render(request,'master/borrow_request_home.html',{'data':data})
    else:
        return redirect('/home')
    
def borrow_approval(request):
    if 'master' in request.session:
        Borrowed_book.objects.filter(bd_id=request.GET['bd_id']).update(status='deliver')
        return redirect('/deliver_page')
    else:
        return redirect('/home')
    
def reject_home(request):
    if 'master' in request.session:
        Borrowed_book.objects.filter(bd_id=request.GET['bd_id']).update(status='no_delivary')
        return redirect('/borrow_request_home')
    else:
        return redirect('/home')

def deliver_page(request):
    if 'master' in request.session:
        data = Borrowed_book.objects.filter(status='deliver').select_related('b')
        return render(request,'master/deliver_book.html',{'data':data})
    else:
        return redirect('/home')

def deliver_book(request):
    t = today + timedelta(days=20)
    if 'master' in request.session:
        Borrowed_book.objects.filter(bd_id=request.GET['bd_id']).update(status='Not Returned',borrowed_date=today,return_date=t)
        d = Borrowed_book.objects.get(bd_id=request.GET['bd_id'])
        data = Book_details.objects.get(b_id=d.b_id)
        cp = int(data.no_of_copies)-1
        Book_details.objects.filter(b_id=d.b_id).update(no_of_copies=cp)
        return redirect('/borrow_details')
    else:
        return redirect('/home')
    

def borrow_reject(request):
    t = today + timedelta(days=20)
    if 'master' in request.session:
        Borrowed_book.objects.filter(bd_id=request.GET['bd_id']).update(status='rejected')
        return redirect('/borrow_request')
    else:
        return redirect('/home')



def borrow_details(request):
    if 'master' in request.session:
        data = Borrowed_book.objects.filter(Q(status='Not Returned')|Q(status='dues')).select_related('b').order_by('-bd_id')
        return render(request,'master/borrow_details.html',{'data':data})
    elif 'member' in request.session:
        data = Borrowed_book.objects.filter(Q(status='Not Returned')|Q(status='dues')|Q(status='returned'),m_id=request.session['member']).select_related('b')
        return render(request,'member/borrowed_details.html',{'data':data})
    else:
        return redirect('/home')

def update_return(request):
    if 'master' in request.session:
        Borrowed_book.objects.filter(bd_id=request.GET['bd_id']).update(status='Returned')
        b = Borrowed_book.objects.get(bd_id=request.GET['bd_id'])
        b_id = b.b_id
        data = Book_details.objects.get(b_id=b_id)
        cp = int(data.no_of_copies)+1
        Book_details.objects.filter(b_id=b_id).update(no_of_copies=cp)
        return redirect('/borrow_details')
    else:
        return redirect('/home')

def reservation_details(request):
    if 'master' in request.session:
        data = Book_reservation.objects.filter(status='pending').select_related('b').order_by('br_id')
        return render(request,'master/reservation_details.html',{'data':data})
    elif 'member' in request.session:
        data = Book_reservation.objects.filter(m_id=request.session['member']).select_related('b')
        return render(request,'member/reservation_details.html',{'data':data})
    else:
        return redirect('/home')
    
# def reservation_details(request):
#     if 'master' in request.session:
#         data = Book_reservation.objects.filter(status='pending').select_related('b').order_by('br_id')
#         li = []
#         for i in data:
#             m = i.m_id
#             sub = Subscription.objects.get(m_id=m).last()
#             if sub.subscription_validity<today:
#                 li.append({
#                     'sub': 'no',
#                 })
#         return render(request,'master/reservation_details.html',{'data':data})
#     elif 'member' in request.session:
#         data = Book_reservation.objects.filter(m_id=request.session['member']).select_related('b')
#         return render(request,'member/reservation_details.html',{'data':data})
#     else:
#         return redirect('/home')










def view_donations(request):
    if 'master' in request.session:
        data = Book_donation.objects.all()
        return render(request,'master/view_donations.html',{'data':data})
    
    else:
        return redirect('/home')
    
def borrowed_history(request):
    if 'master' in request.session:
        data = Borrowed_book.objects.filter(status='Returned').select_related('b')
        return render(request,'master/borrowed_history.html',{'data':data})
    else:
        return redirect('/home')
    
#---------------------Member----------------------

def member_home(request):
    if 'member' in request.session:
        data = Book_details.objects.select_related('c')
        data2 = Book_category.objects.all()
        data3 = Borrowed_book.objects.filter(status='Not Returned',return_date__lt=today)
        for i in data3:
            Dues.objects.create(m_id=i.m_id,bd_id=i.bd_id,fine=20,status='Not paid')
            Borrowed_book.objects.filter(bd_id=i.bd_id).update(status='dues')
        return render(request,'member/home.html',{'data':data,'data2':data2})
    else:
        return redirect('/home')
    
def book_search(request):
    str1=''
    data = Book_details.objects.select_related('c').filter(c__category_name__icontains=request.GET['cat'])
    for i in data:
        str1+= f'''<div class="col-lg-4 wow fadeInUp" data-wow-delay="0.1s" style="display: inline-block;padding: 10px;">
            <a href="/more?b_id={i.b_id}" style="color: inherit;">
            <div class="row g-4 align-items-center" id="ss" style="padding: 10px;">
                <div class="col-sm-4">
                    <img class="img-fluid" src="{i.image}" alt="">
                </div>
                <div class="col-sm-8">
                    <h3 class="mb-0" style="color: #FDA12B;">{i.book_title}</h3>
                    <p style="color: #1ABC9C;">{i.c.category_name}</p>
                    <h6>Book Details</h6>
                    <p style="height: 45px;overflow: hidden;">{i.description}</p>
                    <p class="mb-0">Author: <b style="color: #182333;">{i.author}</b></p>
                    <p class="mb-0">Publisher: {i.publisher}</p>                       
                </div>
            </div>
        </a>
        </div>'''
    return HttpResponse(str1)

def book_search_title(request):
    str1=''
    data = Book_details.objects.filter(book_title__icontains=request.GET['title'])
    for i in data:
        str1+= f'''<div class="col-lg-4 wow fadeInUp" data-wow-delay="0.1s" style="display: inline-block;padding: 10px;">
            <a href="/more?b_id={i.b_id}" style="color: inherit;">
            <div class="row g-4 align-items-center" id="ss" style="padding: 10px;">
                <div class="col-sm-4">
                    <img class="img-fluid" src="{i.image}" alt="">
                </div>
                <div class="col-sm-8">
                    <h3 class="mb-0" style="color: #FDA12B;">{i.book_title}</h3>
                    <p style="color: #1ABC9C;">{i.c.category_name}</p>
                    <h6>Book Details</h6>
                    <p style="height: 45px;overflow: hidden;">{i.description}</p>
                    <p class="mb-0">Author: <b style="color: #182333;">{i.author}</b></p>
                    <p class="mb-0">Publisher: {i.publisher}</p>                       
                </div>
            </div>
        </a>
        </div>'''
    return HttpResponse(str1)

def feedback(request):
    if 'member' in request.session:
        if request.method == 'POST':
            feedback = request.POST['feedback']
            Feedback.objects.create(feedback=feedback,feedback_date=today,m_id=request.session['member'])
            messages.success(request, 'Submittd successfully')
            return redirect('/feedback')
        else:
            data = Feedback.objects.filter(m_id=request.session['member'])
            return render(request,'member/feedback.html',{'data':data})
    else:
        return redirect('/home')
    
def reply(request):
    if 'master' in request.session:
        if request.method == 'POST':
            f_id = request.POST['f_id']
            reply = request.POST['reply']
            Feedback.objects.filter(f_id=f_id).update(reply=reply)
            messages.success(request, 'Submittd successfully')
            return redirect('/reply')
        else:
            data = Feedback.objects.all()
            return render(request,'master/reply.html',{'data':data})
    else:
        return redirect('/home')

def subscription(request):
    if 'member' in request.session:
        if request.method == 'POST':
            subscription_type = request.POST['subscription_type']
            amount =  request.POST['amount']

            if subscription_type == 'Annual Membership':
                t = today + timedelta(days=365)
                subscription_validity = t
                
            elif subscription_type == 'Six Month':
                t = today + timedelta(days=180)
                subscription_validity = t
                
            elif subscription_type == 'Three Month':
                t = today + timedelta(days=90)
                subscription_validity = t
                
            elif subscription_type == 'Monthly':
                t = today + timedelta(days=30)
                subscription_validity = t
               

            
            Subscription.objects.create(subscription_type=subscription_type,subscription_date=today,subscription_validity=subscription_validity,amount=amount,m_id=request.session['member'])
            return redirect('/subscription_details')
        else:
            return render(request,'member/subscription.html')
    else:
        return redirect('/home')

def more(request):
    data = Book_details.objects.filter(b_id=request.GET['b_id'])
    if 'member' in request.session:
        mem = Subscription.objects.filter(m_id=request.session['member']).last()
        b = Borrowed_book.objects.filter(m_id=request.session['member'],status='Not Returned').count()
        due = Dues.objects.filter(m_id=request.session['member'],status='Not paid')
        bok=None
        if b >= 3:
            bok = 'You already take 3 books Not Returned'

        sub=None
        if mem is None:
            sub='Subscription Required for borrow and reservation'
        else:
            if mem.subscription_validity<today:
                sub='Your Subscription Expired'

        ret = Borrowed_book.objects.filter(Q(status='Not Retuned')|Q(status='dues'),m_id=request.session['member'],return_date__lt=today)
        return render(request,'member/more.html',{'data':data,'sub':sub,'bok':bok,'due':due,'ret':ret})
    
    elif 'master' in request.session:
        return render(request,'master/more.html',{'data':data})
    else:
        return render(request,'more.html',{'data':data})
    

    
def borrow_book(request):
    if 'member' in request.session:
        Borrowed_book.objects.create(m_id=request.session['member'],b_id=request.GET['b_id'],request_date=today,status="request")       
        return redirect('/request_details')
    else:
        return redirect('/home')
    
def borrow_book_home(request):
    if 'member' in request.session:
        Borrowed_book.objects.create(m_id=request.session['member'],b_id=request.GET['b_id'],request_date=today,status="request_home")       
        return redirect('/request_details')
    else:
        return redirect('/home')
    
def request_details(request):
    if 'member' in request.session:
        data = Borrowed_book.objects.filter(Q(status='request')|Q(status='Not Returned')|Q(status='rejected')|Q(status='deliver')|Q(status='no_delivary')|Q(status='request_home'),m_id=request.session['member'])
        return render(request,'member/request_details.html',{'data':data})
    else:
        return redirect('/home')
    
def approve_borrow(request):
    t = today + timedelta(days=10)
    if 'master' in request.session:
        Borrowed_book.objects.create(m_id=request.GET['m_id'],b_id=request.GET['b_id'],request_date=request.GET['rdate'],borrowed_date=today,return_date=t,status="deliver")
        data = Book_details.objects.get(b_id=request.GET['b_id'])
        cp = int(data.no_of_copies)-1
        Book_details.objects.filter(b_id=request.GET['b_id']).update(no_of_copies=cp)
        Book_reservation.objects.filter(br_id=request.GET['br_id']).update(status='borrowed')
        return redirect('/reservation_details')
    else:
        return redirect('/home')

def reserve_book(request):
    if 'member' in request.session:
        Book_reservation.objects.create(m_id=request.session['member'],b_id=request.GET['b_id'],reserved_date=today,status='pending')
        return redirect('/member_home')
    else:
        return redirect('/home')


def profile(request):
    if 'member' in request.session:
        if request.method == 'POST':
            name = request.POST['name']
            contact_no = request.POST['phone']
            email = request.POST['email']
            address = request.POST['address']
            
            Member_register.objects.filter(m_id=request.session['member']).update(name=name,contact_no=contact_no,email=email,address=address)
            messages.success(request, 'Updated successfully.....')
            return redirect('/profile')
        else:
            data = Member_register.objects.filter(m_id=request.session['member'])
            return render(request,'member/profile.html',{'data':data})
    else:
        return redirect('/home')
    

def forgot_password(request):
    if request.method == 'POST':
        member_id = request.POST['member_id']
        username = request.POST['username']
        passw = request.POST['password']
        password = sha256(passw.encode()).hexdigest()
        try:
            data = Login.objects.get(username=username)
            d = Member_register.objects.get(log_id=data.log_id)
            if d.membership_id == member_id:
                Login.objects.filter(log_id=data.log_id).update(password=password)
                messages.success(request, 'Your Password has been changed successfully')
                return redirect('/forgot_password')
            else:
                messages.success(request, 'Invalid Username or Membership id')
                return redirect('/forgot_password')
        except Exception:
            messages.success(request,'Invalid Username or Membership id')
            return redirect('/forgot_password')
    else:
        return render(request,'forgot_password.html')


def change_password(request):
    if 'member' in request.session:
        if request.method == 'POST':
            cpassw = request.POST['cpassword']
            cpassword = sha256(cpassw.encode()).hexdigest()
            passw = request.POST['password']
            password = sha256(passw.encode()).hexdigest()
            try:
                data = Login.objects.get(log_id=request.session['log_id'])
                if data.password == cpassword:
                    Login.objects.filter(log_id=request.session['log_id']).update(password=password)
                    messages.success(request, 'Your Password has been Reset successfully.....')
                    return redirect('/change_password')
                else:
                    messages.success(request, 'Enter valid current password',extra_tags='msg')
                    return redirect('/change_password')
            except Exception:
                messages.success(request, 'Invalid User',extra_tags='msg')
                return redirect('/change_password')
        else:
          return redirect('/profile')
    elif 'master' in request.session:
        if request.method == 'POST':
            cpassw = request.POST['cpassword']
            cpassword = sha256(cpassw.encode()).hexdigest()
            passw = request.POST['password']
            password = sha256(passw.encode()).hexdigest()
            try:
                data = Login.objects.get(log_id=request.session['log_id'])
                if data.password == cpassword:
                    Login.objects.filter(log_id=request.session['log_id']).update(password=password)
                    messages.success(request, 'Your Password has been Reset successfully.....')
                    return redirect('/change_password')
                else:
                    messages.success(request, 'Enter valid current password',extra_tags='msg')
                    return redirect('/change_password')
            except Exception:
                messages.success(request, 'Invalid User',extra_tags='msg')
                return redirect('/change_password')
        else:
          return render(request,'master/change_password.html')
    else:
        return redirect('/home')  




def member_dues(request):
    if 'member' in request.session:
        data = Dues.objects.filter(m_id=request.session['member'])
        return render(request,'member/member_dues.html',{'data':data})
    elif 'master' in request.session:
        data = Dues.objects.all()
        return render(request,'master/member_dues.html',{'data':data})
    else:
        return redirect('/home')
    
def pay(request):
    if 'member' in request.session:
        data = Dues.objects.filter(d_id=request.GET['d_id'])
        return render(request,'member/pay.html',{'data':data})
    else:
        return redirect('/home')
    
def pay_now(request):
    if 'member' in request.session:
        if request.method == 'POST':
            d_id = request.POST['d_id']
            Dues.objects.filter(d_id=d_id).update(status='paid')
            return redirect('/member_dues')
        else:
            return redirect('/member_dues')
    else:
        return redirect('/home')

def check_username(request):
    username = request.GET.get("username")
    data = {
       'username_exists': Login.objects.filter(username=username).exists(),
        'error':"This Username already has an account"
    }
    if(data["username_exists"]==False):
        data["success"]="Available"

    return JsonResponse(data)

def check_email(request):
    email = request.GET.get("email")
    data = {
       'email_exists': Member_register.objects.filter(email=email).exists(),
        'error':"This email already has an account"
    }
    if(data["email_exists"]==False):
        data["success"]="Available"

    return JsonResponse(data)

def sign_out(request):
    logout(request)
    request.session.delete()
    return redirect('/home')


def master_register(request):
    if request.method == 'POST':
        username = request.POST['username']
        passw = request.POST['password']
        password = sha256(passw.encode()).hexdigest()
        Login.objects.create(username=username,password=password,role='master')
        return redirect('/master_register')
    else:
        return render(request,'master_register.html')