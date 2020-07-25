from django.shortcuts import render
from django.shortcuts import render_to_response,render,redirect
import pyrebase
from firebase_admin import auth
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from firebase_admin import firestore

# config = {
#   "apiKey": 'AIzaSyDOOmv9NiDLYB7U4SE88xLsh2CW58q36Yk',
#   "authDomain": 'learningapp-3032a.firebaseapp.com',
#   "databaseURL": 'https://learningapp-3032a.firebaseio.com',
# };
# firebase.initializeApp(config);
cred = credentials.Certificate('D:/sdpproject/Real_Learning_Admin/pythonadmin.json')
firebase_admin.initialize_app(cred, {
    'databaseURL' : 'https://learningapp-3032a.firebaseio.com/',
    'storageBucket': 'learningapp-3032a.appspot.com'

})
db=firestore.client();
doc = (db.collection(u'course').document())

docs= doc.get()

print(u'Document data:()'.format(docs.to_dict()))
# ref = db.reference().child('users').get();

doc = (db.collection(u'course').document())
def home(request):
	return render_to_response('home.html')

# @login_required(login_url='/login/')
def managecourse(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	print("Length is")
	size1=0
	print(size1)
	
	return render_to_response('managecourse.html',{'size':size1})




def course(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	return render(request,'course.html')

def viewcourse(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	users_ref=firestore.client().collection("course")
	docs = users_ref.stream()
	item=[]
	idlist=[]
	tlist=[]
	for doc in docs:
		idlist.append(doc.id)
		item.append(doc.to_dict())
		print(item[0].get('description'))
	users_ref=firestore.client().collection("coursecontent")
	docs = users_ref.stream()
	for doc in docs:
		tlist.append(doc.to_dict())
	l = zip(item, idlist) 
	return render_to_response('viewcourse.html',{'item_list':l,'tlist':tlist})

def deletecourse(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	# s=request.POST.get('coursename')
	s=request.GET.get('coursename','')
	users_ref=firestore.client().collection("course")
	print("hello"+s)
	results = users_ref.where('name', '==',s)
	docs = results.stream()
	for doc in docs:
		print(doc.id)
	firestore.client().collection(u'course').document(doc.id).delete()

		# item.append(doc.to_dict())
	# results.document(docs.id).delete()
	return render_to_response('success.html')

def deletetopic(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	# s=request.POST.get('coursename')
	s=request.POST.get('topicname','')
	users_ref=firestore.client().collection("coursecontent")
	print("hello"+s)
	results = users_ref.where('topicname', '==',s)
	docs = results.stream()
	for doc in docs:
		print(doc.id)
	firestore.client().collection(u'coursecontent').document(doc.id).delete()

		# item.append(doc.to_dict())
	# results.document(doc.id).delete()
	return render_to_response('success.html')

def viewselectedcourse(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	s=request.POST.get('coursename')
	users_ref=firestore.client().collection("course")
	results = users_ref.where('name', '==',s)
	docs = results.stream()
	item=[]
	idlist=[]
	tlist=[]
	for doc in docs:
		idlist.append(doc.id)
		item.append(doc.to_dict())
	print("hello")
	print(item)
	return render_to_response('viewselectedcourse.html',{'item':item})

def viewselectedtopic(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	s=request.POST.get('topicname','')
	print("hello")
	print(s)
	users_ref=firestore.client().collection("coursecontent")
	results = users_ref.where('topicname', '==',s)
	docs = results.stream()
	item=[]
	idlist=[]
	tlist=[]
	for doc in docs:
		idlist.append(doc.id)
		item.append(doc.to_dict())
	print("hello")
	#print(item)
	return render_to_response('viewselectedtopic.html',{'item':item})
def courseupdate(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	users_ref=firestore.client().collection("course")
	docs = users_ref.stream()
	item=[]
	idlist=[]
	tlist=[]
	for doc in docs:
		# print(u'{} => {}'.format(doc.id, doc.to_dict()))
		idlist.append(doc.id)
		item.append(doc.to_dict())
		print(item[0].get('description'))
	users_ref=firestore.client().collection("coursecontent")
	docs = users_ref.stream()
	for doc in docs:
		# print(u'{} => {}'.format(doc.id, doc.to_dict()))
		tlist.append(doc.to_dict())
	l = zip(item, idlist) 
	return render_to_response('courseupdate.html',{'item_list':l,'tlist':tlist})

def coursecontentupdate(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	coursename=request.POST.get('coursename','')
	coursedescription=request.POST.get('coursedescription','')
	courseOverView=request.POST.get('courseOverView','')
	print("d:"+coursedescription)
	print("o:"+courseOverView)
	col_ref = firestore.client().collection('course')
	results = col_ref.where('name', '==',coursename).get()
	field_updates = {"description":coursedescription}
	for item in results:
		doc = col_ref.document(item.id)
		doc.update(field_updates)
	return render(request,'success.html')

def viewtopic(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	coursename=request.POST.get('coursename','')
	col_ref = firestore.client().collection('coursecontent')
	results = col_ref.where('coursename', '==',coursename)
	docs=results.stream()
	item=[]
	idlist=[]
	tlist=[]
	for doc in docs:
		idlist.append(doc.id)
		item.append(doc.to_dict())
		# print(item[0].get('description'))
	return render_to_response('viewtopic.html',{'item':item})

	
def coursetopicupdate(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	topicid=request.POST.get('topicid','')
	topicname=request.POST.get('topicname','')
	coursename=request.POST.get('coursename','')
	topicdescription=request.POST.get('topicdescription','')
	# print("d:"+coursedescription)
	# print("o:"+courseOverView)
	print("hello"+coursename)
	col_ref = firestore.client().collection('coursecontent')
	results = col_ref.where('topicid', '==',topicid).get()
	field_updates = {"coursename":coursename,"topicdescription":topicdescription,"topicname":topicname}
	for item in results:
		doc = col_ref.document(item.id)
		doc.update(field_updates)
	return render(request,'success.html')
 

def addQuestion(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	users_ref=firestore.client().collection("course")
	course=request.POST.get('course',None)
	docs = users_ref.stream()
	item=[]
	idlist=[]
	tlist=[]
	for doc in docs:
		idlist.append(doc.id)
		item.append(doc.to_dict())
	users_ref=firestore.client().collection("coursecontent")
	docs = users_ref.stream()
	for doc in docs:
		if(course):
			x=doc.to_dict()
			if(x['coursename']==course):
				tlist.append(doc.to_dict())	
				print("added")	
		else:
			tlist.append(doc.to_dict())
	l = zip(item, idlist) 
	return render_to_response('question.html',{'item_list':l,'tlist':tlist});

def addquestionDB(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	coursename=request.POST.get('coursename','')
	topic=request.POST.get('topicname','')
	question=request.POST.get('question','')
	option1=request.POST.get('option1','')
	option2=request.POST.get('option2','')
	option3=request.POST.get('option3','')
	option4=request.POST.get('option4','')
	answer=request.POST.get('answer','')
	quiz = (db.collection(u'quiz-question').document())
	quiz.set({
	'coursename':coursename,
    'topic':topic ,
    'question':question,
    'option1':option1,
    'option2':option2,
    'option3':option3,
    'option4':option4,
    'answer':answer
	})
	return render(request,'success.html')
	#return addQuestion(request);



def uploadcoursecontent(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	topicname=request.POST.get('topicname','')
	text=request.POST.get('topicdescription','')#.encode("utf-8","strict")
	courseid=request.POST.get('courseid','')
	topicid=request.POST.get('topicid','')
	# print(text)
	print(courseid)
	print(topicname)
	print(text)
	print("String is")
	# print(str(text))
	coursecontentdoc = (db.collection(u'coursecontent').document())
	coursecontentdoc.set({
	'topicid':topicid,
    'topicname':topicname ,
    'topicdescription':text,
    'coursename':courseid
	})
	# alert("Course Uploaded successfully")
	return render(request,'success.html')

def courseupload(request):
	if(request.session.get('user')!='ashishkotecha'):
		return render(request,'login.html')
	coursename=request.POST.get('coursename','')
	text=request.POST.get('coursename','')#.encode("utf-8","strict")
	print(text)
	print("String is")
	print(str(text))
	imagename=request.POST.get('imagename','')
	print(imagename)
	image=request.POST.get('url','')
	print(image)
	doc.set({
    'name':(text) ,
    'imageurl': image,
    'description':request.POST.get('Description',''),
    'imagename':imagename
    	})
	# alert("Course Uploaded successfully")
	# print("coursename is")
	# print(coursename)
	# print(image)
	# print("Getting data")
	# user_ref = db.collection(u'course')
	# for k in db.collection('course').get():
 #    		z=k.to_dict()
 #    		print(z)#.get("name").decode())
	return render(request,'success.html')

def login(request):
	username=request.POST.get('username','')
	password=request.POST.get('password','')
	if(username=="ashishkotecha" and password=="ashish"):
		request.session['user'] = username
		l='login'
		return render(request,'managecourse.html',{'item':l})	
	else:
		return render(request,'login.html')

def logout(request):
	request.session['user']=''
	return render(request,'login.html')
