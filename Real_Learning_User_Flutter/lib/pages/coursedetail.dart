

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/pages/quiz.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:learningapp/pages/subtopic.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
var x;

class CourseDetail extends StatelessWidget {
  final Course course;
  final String courseid;
  String richtext;
  CourseDetail({this.course, this.courseid});
  @override
  Widget build(BuildContext context) {
      // richtext=  html2md.convert('${courseDescription}');

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(course.courseName),
      ),
      drawer: new Drawer(
          child:new ListView(
              children:<Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("Hash"),
                  accountEmail:new Text("harshs1868@gmail.com"),
                  currentAccountPicture: new CircleAvatar(
                    backgroundColor:Colors.green,
                    child:new Text("H"),
                  ),

                ),

                new ListTile(
                  title:new Text("Courses"),
                  trailing: new Icon(Icons.home),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),

                      ),
                    );

                  },
                ),
              
                Drawerlist1(),











                new Divider(),
                new ListTile(
                  title:new Text("close"),
                  trailing: new Icon(Icons.close),
                  onTap: ()=>Navigator.of(context).pop(),
                )

              ]
          )
      ),
      body: Padding(
        
        padding: EdgeInsets.all(16.0),
        child: Container(

            child: Card(
              
                                 margin: EdgeInsets.only(left: 8,top:8, right: 8, bottom: 24),
                                 elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                child:InkWell(
                  onTap: ()   {
                    var firestore =  Firestore.instance;
                    var size = firestore.collection('course').where('name',isEqualTo: course.courseName).snapshots();
                    debugPrint(size.toString());

                    size.listen((QuerySnapshot data) {
                      List<DocumentSnapshot> userLastMess = data.documents;
                      var chatDetailSnapshotList = userLastMess.map((DocumentSnapshot doc) {
                        return doc.data;
                      }).toList();
                      (chatDetailSnapshotList==null)?x=1:x=0;
                      debugPrint(chatDetailSnapshotList.toString());
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                     
                      ListTile(
                          leading: Icon(Icons.pageview),
                          title: Text('Course Overview'),
                          subtitle: Text('')),
                      new Image.network('${course.courseImage}'),
                      Container(
                        padding: EdgeInsets.all(0),
                      ),
                      ListTile(
                        title: Text(' ${course.courseName}'),
                          subtitle:MarkdownBody(
                    data:  html2md.convert('${course.courseDescription}'),
                  ), 
                    //    subtitle: Text(' ${course.courseDescription}'),
                        trailing: Text(''),
                      ),
                      RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        color: Colors.cyan,
                        child: const Text('Explore....'),
                        onPressed: () {
                          final Course detail= Course( courseName :' ${course.courseName}',courseDescription : ' ${course.courseDescription}',courseImage :'${course.courseImage}');


                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Drawerlist(course : detail,cid:'${course.courseName}'),

                            ),
                          );


                        },
                      ),
                      //  RaisedButton(
                      //    elevation: 3,
                      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                      
                      //   color: Colors.yellowAccent,
                      //   child: const Text('Quiz'),
                      //   onPressed: () {
                      //     final Quiz detail= Quiz( course :' ${course.courseName}');


                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Quiz( course :' ${course.courseName}'),

                      //       ),
                      //     );


                      //   },
                      // ),
                    ],

                  ),

                ) )),
      ),
    );
  }
}



class Drawerlist1 extends StatelessWidget {

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

                      return Container(
                        child:ListTile(
                            title: Text(snapshot.data[index].data[
                            "name"])),

                      );
                    });
              }
            })
    );
  }
}