import 'package:flutter/material.dart';
import 'package:learningapp/pages/coursedetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/pages/topic.dart';



  var co = List.generate(100, (i) => List.generate(3, (j) => 0));





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
     

      body: Quiz2(course:this.course)
    );
  }
}




class Quiz2 extends StatefulWidget{
  String topic,course;
  static String coursename;
  Quiz2({this.course});
  @override
  Quiz1 createState() {
      coursename = this.course;
     return  Quiz1();
  //  throw UnimplementedError();
  }
  

}

class Quiz1 extends State<Quiz2> {
  //final  Course course;
  //final String cid;
  String topic,course;
  
  //var co= new List(50);
    var co = new List<int>.generate(100, (i) =>0).cast<int>();

  Future getAllSubtopic() async {
    var firestore = Firestore.instance;
    String c=Quiz2.coursename;
    String t="html intro";//this.topic;
  c=c.trim();
    String p='html';
  
    t=t.toString();
    debugPrint(c+"INSIDE");

    //debugPrint(qn.toString());
    QuerySnapshot qn = await firestore.collection('quiz-question')
        .where('coursename',isEqualTo:c).getDocuments();

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
          title: Text('hello'),
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

                                    
                                        RaisedButton(color:co[index]==0? Colors.red : Colors.green,child:Text(snapshot.data[index].data['option1']),onPressed:() {

                              var cid = Firestore.instance.collection('quiz-question').where('answer',isEqualTo:snapshot.data[index].data['option1']).where('question',isEqualTo: snapshot.data[index].data["question"]).reference();
                              cid.getDocuments().then((data1) {
                              if (data1.documents.length > 0) {
                              //setState(() {
                              var op1 =data1.documents[index].data['answer'];
                              print("hello"+op1);
                              if(op1==data1.documents[index].data['option1'])
                                co[index]=1;
                              //lastName = data.documents[0].data['lastName'];
                              // });
                              }
                              });

                                    setState(() {
                                      
                                    });    }),


                                        RaisedButton(color:co[index]==0? Colors.red : Colors.green,child:Text(snapshot.data[index].data['option2']),onPressed:() {

                                          var cid = Firestore.instance.collection('quiz-question').where('question',isEqualTo:
                                          snapshot.data[index].data["question"]).reference();
                                          cid.getDocuments().then((data1) {
                                            if (data1.documents.length > 0) {
                                             // setState(() {
                                              var op1 = snapshot.data[index].documents[index].data['answer'];
                                           
                                              if(op1==snapshot.data[index].documents[index].data['option1'])
                                             { co[index]=1;
                                                print("ans "+ op1);

                                              }//lastName = data.documents[0].data['lastName'];
                                              // });
                                            }
                                          });
                                            setState(() {
                                          
                                          //  co[index]=1;
                                            });    
                                        }),
                                        RaisedButton(color:co[index]==0? Colors.red : Colors.green,child:Text(snapshot.data[index].data['option3']),onPressed:() {

                                          var cid = Firestore.instance.collection('quiz-question').where('answer',isEqualTo:snapshot.data[index].data['option3']).where('question',isEqualTo: snapshot.data[index].data["question"]).reference();
                                          cid.getDocuments().then((data) {
                                            if (data.documents.length > 0) {
                                              //setState(() {
                                              var op1 = data.documents[index].data['answer'];
                                              print("hello"+op1);
                                               
                                              if(op1==snapshot.data[index].documents[index].data['option3'])
                                             { co[index]=1;
                                                print("ans "+ op1);

                                              }//lastNam
                                              //lastName = data.documents[0].data['lastName'];
                                              // });
                                            }
                                          });
setState(() {
                                          
                                          //  co[index]=1;
                                            });    
                                        }
                                        ),
                                      ]   ) );
                            });
                      }
                    })
            )));

  }
}


