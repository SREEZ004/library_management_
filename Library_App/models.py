from django.db import models


class Login(models.Model):
    log_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=20)
    password = models.TextField()
    role = models.CharField(max_length=20)
    class Meta:
        db_table = 'tb_Login'

class Member_register(models.Model):
    m_id = models.AutoField(primary_key=True)
    log = models.ForeignKey(Login,on_delete=models.CASCADE)
    name = models.CharField(max_length=30)
    contact_no = models.BigIntegerField()
    email =  models.CharField(max_length=50)  
    address = models.CharField(max_length=150,null=True,blank=True)  
    membership_id = models.CharField(max_length=30,null=True,blank=True) 
    membership_taken_date = models.DateField(null=True,blank=True)
    class Meta:
        db_table = 'tb_Member_register'

class Book_category(models.Model):
    bc_id = models.AutoField(primary_key=True)
    category_name = models.CharField(max_length=50) 
    class Meta:
        db_table = 'tb_Book_category'      

class Book_details(models.Model):
    b_id = models.AutoField(primary_key=True)
    c = models.ForeignKey(Book_category,on_delete=models.SET_NULL,null=True,blank=True)
    book_title = models.CharField(max_length=80)
    image = models.TextField()
    author =  models.CharField(max_length=50)  
    publisher = models.CharField(max_length=100)
    published_date = models.DateField()
    no_of_pages = models.IntegerField()
    copies = models.IntegerField()
    no_of_copies = models.IntegerField()
    description = models.TextField()
    additional_data = models.TextField()
    class Meta:
        db_table = 'tb_Book_details'

class Subscription(models.Model):
    s_id = models.AutoField(primary_key=True)
    m = models.ForeignKey(Member_register,on_delete=models.CASCADE)
    subscription_type =  models.CharField(max_length=50) 
    subscription_date = models.DateField()
    subscription_validity = models.DateField() 
    amount = models.IntegerField()
    class Meta:
        db_table = 'tb_Subscription'

class Borrowed_book(models.Model):
    bd_id = models.AutoField(primary_key=True)
    m = models.ForeignKey(Member_register,on_delete=models.CASCADE)
    b = models.ForeignKey(Book_details,on_delete=models.CASCADE)
    request_date = models.DateField()
    borrowed_date = models.DateField(null=True,blank=True)
    return_date = models.DateField(null=True,blank=True) 
    status = models.CharField(max_length=20) 
    class Meta:
        db_table = 'tb_Borrowed_book'

class Book_reservation(models.Model):
    br_id = models.AutoField(primary_key=True)
    m = models.ForeignKey(Member_register,on_delete=models.CASCADE)
    b = models.ForeignKey(Book_details,on_delete=models.CASCADE)
    reserved_date = models.DateField()
    status = models.CharField(max_length=20) 
    class Meta:
        db_table = 'tb_Book_reservation'

class Feedback(models.Model):
    f_id = models.AutoField(primary_key=True)
    m = models.ForeignKey(Member_register,on_delete=models.CASCADE)
    feedback_date = models.DateField()
    feedback = models.TextField()
    reply = models.TextField(blank=True,null=True)
    class Meta:
        db_table = 'tb_Feedback'

class Book_donation(models.Model):
    d_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=30)
    contact_no = models.BigIntegerField()
    email =  models.CharField(max_length=50)  
    book_details = models.TextField()
    class Meta:
        db_table = 'tb_Book_donation'

class Dues(models.Model):
    d_id = models.AutoField(primary_key=True)
    m = models.ForeignKey(Member_register,on_delete=models.CASCADE)
    bd = models.ForeignKey(Borrowed_book,on_delete=models.CASCADE)
    fine = models.IntegerField()
    status = models.CharField(max_length=20) 
    class Meta:
        db_table = 'tb_Dues'

class News(models.Model):
    n_id = models.AutoField(primary_key=True)
    title = models.TextField()
    description = models.TextField()
    status = models.CharField(max_length=20)
    class Meta:
        db_table = 'tb_News'

# Create your models here.
