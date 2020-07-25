import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/coursedetail.dart';
import 'package:learningapp/service/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:learningapp/models/todo.dart';
import 'dart:async';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

String richtext;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  //Query _todoQuery;

  //bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

  }

@override
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Real Learning'),
        actions: <Widget>[
          
          new FlatButton(
              child: new Text('Logout',
                  style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: signOut)
        ],
      ),
      body:Padding(
        padding: EdgeInsets.all(16.0),
            child: MyStatelessWidget()
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  
  MyStatelessWidget({Key key}) : super(key: key);

  Future getAllCourses() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('course').getDocuments();
    return qn.documents;
  }


  @override
  Widget build(BuildContext context) {
    return Container(


            child: FutureBuilder(
                future: getAllCourses(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("loading..."),
                    );
                  } else {

                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          
                     richtext=  html2md.convert(snapshot.data[index].data["description"]);
                          return Container(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Card(
                              
                                 margin: EdgeInsets.only(left: 8,top:8, right: 8, bottom: 24),
                                 elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)), //<--custom shape
                                child:InkWell(
                                  onTap: () {
                                                  final Course course= Course( courseName : (snapshot.data[index].data["name"]),courseDescription : snapshot.data[index].data["description"],courseImage :snapshot.data[index].data["imageurl"]);
                                                  var cid = Firestore.instance.collection('course').where('name',isEqualTo:snapshot.data[index].data["name"]).reference();
                                                 // cid= cid.getId();


                                       Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetail(course : course,courseid:'${course.courseName}'),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
              
                ),
              );
            
            
                                        },

                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                
                              //  Spacer(),
            Text(" "),
          ClipRRect(  //<--clipping image
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)), 
            child:  new Image.network(
                                    snapshot.data[index].data["imageurl"],
              height: MediaQuery.of(context).size.height *0.3,
              fit: BoxFit.none,
            ),
          ),
 SizedBox(height: 8),

                               
                                
                                ListTile(
                                  title: Text(snapshot.data[index].data[
                                      "name"]), // height: 50,                         color: Colors.amber[colorCodes[index]],
                                  subtitle: Text(
                                    
                                        html2md.convert(snapshot.data[index].data["description"])
                                      ),
                                ),
                                     
            
                                ButtonBar(
                                    children: <Widget>[
                                     
                                      RaisedButton(
                                        color: Colors.lightGreen,
               
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                                        child: const Text('DETAILS'),
                                        onPressed: () {
                                                  final Course course= Course( courseName : (snapshot.data[index].data["name"]).toString(),courseDescription : snapshot.data[index].data["description"],courseImage :snapshot.data[index].data["imageurl"]);
                          
                                          
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetail(course : course,),
              
                ),
              );
            

                                        },
                                      ),
                                    ],
                                    alignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max),
                              ],
                            ),
                          
                          )
                        
                           ) );
                        });
                  }
                }));
  }
}
