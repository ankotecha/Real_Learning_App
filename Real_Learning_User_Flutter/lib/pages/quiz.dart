import 'package:flutter/material.dart';
import 'package:learningapp/pages/coursedetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/pages/topic.dart';









class Quiz extends StatelessWidget {
  //final  Course course;
  //static Course detail;
  String cid,course,topic;
  Quiz({this.course,this.topic});


  // String coursename=course.courseName;
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(


        body: Quiz2(course:this.course,topic:this.topic)
    );
  }
}




class Quiz2 extends StatefulWidget{
  String topic,course;
  static String topicname,coursename;
  Quiz2({this.course,this.topic});
  @override
  Quiz1 createState() {
    coursename = this.course;
    topicname= this.topic;
    return  Quiz1();
    //  throw UnimplementedError();
  }


}

class Quiz1 extends State<Quiz2> {
  //final  Course course;
  //final String cid;
  String topic,course;
//var col=Colors.yellow;
  //var co= new List(50);
  var co = List.generate(100, (i) => List.generate(4, (j) => 0));
  var col = List.generate(100, (i) => List.generate(4, (j) => Colors.blue));
  Future getAllSubtopic() async {
    var firestore = Firestore.instance;
    String c=Quiz2.coursename;
    String t=Quiz2.topicname;//this.topic;
    c=c.trim();
    t=t.trim();
    String p='html';

    debugPrint(c+"INSIDE + " +t);

    //debugPrint(qn.toString());
    QuerySnapshot qn = await firestore.collection('quiz-question')
        .where('coursename',isEqualTo:c).where('topic',isEqualTo: t.toString()).getDocuments();

//qn = await firestore.collection('coursecontent').where('coursename',isEqualTo:'${this.cid}').getDocuments();

    debugPrint(qn.toString());
    //  debugPrint('${this.cid}');
    return qn.documents;
  }


  @override
  Widget build(BuildContext context) {
    String color;
    return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),

        body: Padding(
            padding: EdgeInsets.all(16.0),
            child:


            Container(
                child: FutureBuilder(
                    future: getAllSubtopic(),
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
                                  child:Column(
                                      children:<Widget>[ListTile(
                                        title: Text(snapshot.data[index].data["question"]),

                                      ),

                                        RaisedButton(
                                           elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        
                        color:col[index][0],child:Text(snapshot.data[index].data['option1']),onPressed:() {
                                          var cid = Firestore.instance.collection('quiz-question').where('answer',isEqualTo:snapshot.data[index].data['option1']).where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                                          cid.then((data1) {
                                            if (data1.documents.length > 0) {
                                              //setState(() {
                                              var op1 =data1.documents[0].data['answer'];
                                              print("hello"+op1);
                                            //  print(data1.documents[index].data['answer']);
                                              debugPrint(snapshot.data[index].data["question"]);
                                              debugPrint(data1.documents.length.toString());
                                              //if(op1==data1.documents[0].data['option1'])
                                                co[index][0]=1;
                                              setState(() {
                                                col[index][0]=Colors.green;
                                              });
                                                //lastName = data.documents[0].data['lastName'];
                                              // });
                                            }
                                            else
                                              {
                                                print("incorrect");
                                                cid = Firestore.instance.collection('quiz-question').where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                                                col[index][0]=Colors.red;

                                                if (data1.documents.length > 0) {
                                                //setState(() {
                                                var op1 = data1.documents[0]
                                                    .data['answer'];
                                                print("hello"+op1);
                                              }
                                                setState(() {

                                                  co[index][0]=0;
                                                });

                                              }

                                          });


                                        }),


                                        RaisedButton(
                                            elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        color:col[index][1],child:Text(snapshot.data[index].data['option2']),onPressed:() {
                                          var cid = Firestore.instance.collection('quiz-question').where('answer',isEqualTo:snapshot.data[index].data['option2']).where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                                          cid.then((data1) {
                                            if (data1.documents.length > 0) {
                                              //setState(() {
                                              var op1 =data1.documents[0].data['answer'];
                                              print("hello"+op1);
                                              //  print(data1.documents[index].data['answer']);
                                              debugPrint(snapshot.data[index].data["question"]);
                                              debugPrint(data1.documents.length.toString());
                                              //if(op1==data1.documents[0].data['option3'])
                                                col[index][1]=Colors.green;
                                              //lastName = data.documents[0].data['lastName'];
                                              // });
                                            }
                                            else
                                            {
                                              col[index][1]=Colors.red;

                                              print("incorrect");
                                              cid = Firestore.instance.collection('quiz-question').where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();


                                              if (data1.documents.length > 0) {
                                                //setState(() {
                                                var op1 = data1.documents[0]
                                                    .data['answer'];
                                                print("hello"+op1);
                                              }
                                              co[index][1]=0;
                                            }

                                          });

                                          setState(() {

                                          });
                                        }),
                                        RaisedButton(
                                            elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        
                                          color:col[index][2],child:Text(snapshot.data[index].data['option3']),onPressed:() {

                              var cid = Firestore.instance.collection('quiz-question').where('answer',isEqualTo:snapshot.data[index].data['option3']).where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                              cid.then((data1) {
                              if (data1.documents.length > 0) {
                              //setState(() {
                              var op1 =data1.documents[0].data['answer'];
                              print("hello"+op1);
                              //  print(data1.documents[index].data['answer']);
                              debugPrint(snapshot.data[index].data["question"]);
                              debugPrint(data1.documents.length.toString());
                             // if(op1==data1.documents[0].data['option2'])
                              col[index][2]=Colors.green;
                              //lastName = data.documents[0].data['lastName'];
                              // });
                              }
                              else
                              {
                              print("incorrect");
                              cid = Firestore.instance.collection('quiz-question').where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                              col[index][2]=Colors.red;


                              if (data1.documents.length > 0) {
                              //setState(() {
                              var op1 = data1.documents[0]
                                  .data['answer'];
                              print("hello"+op1);
                              }
                              co[index][2]=0;
                              }

                              });

                              setState(() {

                              });
                              }),
                                        RaisedButton(
                                              elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        
                                          color:col[index][3],child:Text(snapshot.data[index].data['option4']),onPressed:() {
                                          var cid = Firestore.instance.collection('quiz-question').where('answer',isEqualTo:snapshot.data[index].data['option4']).where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                                          cid.then((data1) {
                                            if (data1.documents.length > 0) {
                                              //setState(() {
                                              var op1 =data1.documents[0].data['answer'];
                                              print("hello"+op1);
                                              //  print(data1.documents[index].data['answer']);
                                              debugPrint(snapshot.data[index].data["question"]);
                                              debugPrint(data1.documents.length.toString());
                                              //if(op1==data1.documents[0].data['option1'])
                                              co[index][3]=1;
                                              setState(() {
                                                col[index][3]=Colors.green;
                                              });
                                              //lastName = data.documents[0].data['lastName'];
                                              // });
                                            }
                                            else
                                            {
                                              print("incorrect");
                                              cid = Firestore.instance.collection('quiz-question').where('question',isEqualTo: snapshot.data[index].data["question"]).getDocuments();
                                              col[index][3]=Colors.red;

                                              if (data1.documents.length > 0) {
                                                //setState(() {
                                                var op1 = data1.documents[0]
                                                    .data['answer'];
                                                print("hello"+op1);
                                              }
                                              setState(() {

                                                co[index][0]=0;
                                              });

                                            }

                                          });


                                        }),
                                      ]   ) );
                            });
                      }
                    })
            )));

  }
}
