import 'package:flutter/material.dart';
import 'package:learningapp/pages/coursedetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/home_page.dart';



import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';



String richdata;


class Topic extends StatelessWidget {
  final String courseName;
  final String courseDescription;
  Topic({this.courseName,this.courseDescription});
  // String coursename=course.courseName;
  @override
  Widget build(BuildContext context) {
    richtext=  html2md.convert('${courseDescription}');

    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text("CONTENT"),
        ),

        body: Padding(

          padding: EdgeInsets.all(16.0),
          child:
            ListView.builder(itemCount: 1,
            itemBuilder: (context,index)=>
                ListTile(
                  // title: Text(' ${courseName}'),
                  title:MarkdownBody(
                    data: richtext,
                  ),     ),



            // MyStatel
          ) ,
            //new RaisedButton(onPressed: null,child: new Text('hello'),),
        )
    );
  }
}
