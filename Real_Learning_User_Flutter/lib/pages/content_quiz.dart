import 'package:flutter/material.dart';
import 'package:learningapp/pages/coursedetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/pages/quiz.dart';
import 'package:learningapp/pages/topic.dart';



class ContentQuiz extends StatelessWidget {
 String course;
 String topic;
 String coursedescription;
 ContentQuiz({this.course,this.topic,this.coursedescription});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('content and quiz'),
      ),

      body: Padding(
        padding: EdgeInsets.all(25),
        child: new Column(

          children: <Widget>[
            
            // new  Image.asset("C:/Users/harsh/Desktop/sdpPY/RL-master/download(1).jpeg"),
              // C:\Users\harsh\Desktop\sdpPY\RL-master
           Image.asset('images/content.jpeg'),
              RaisedButton(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        color: Colors.redAccent,
                        child: const Text('Content'),
                        onPressed: (){
                String courseDescription,courseName;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Topic(courseName :this.course,courseDescription:this.coursedescription),//Topic(courseName :'${course.courseName}',courseDescription:snapshot.data[index].data[
                    //"topicdescription"]),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.

                  ),
                );



              },
                      ),

  Image.asset('images/quiz.jpeg'),
         
            new RaisedButton(
              child: new Text("View Quiz"),
              elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),  
                        colorBrightness:Brightness.light,  
                        color: Colors.green,
              onPressed: (){
                String courseDescription,courseName;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>Quiz(topic:this.topic,course :this.course),//Topic(courseName :'${course.courseName}',courseDescription:snapshot.data[index].data[
                    //"topicdescription"]),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.

                  ),
                );



              },
            ),


          ],
        ),

      ),
    );
  }
}