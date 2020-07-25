import 'package:flutter/material.dart';
import 'package:learningapp/pages/coursedetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/models/course.dart';
import 'package:learningapp/pages/home_page.dart';
import 'package:learningapp/pages/quiz.dart';
import 'package:learningapp/pages/topic.dart';

import 'content_quiz.dart';









class Subtopic extends StatelessWidget {
  final  Course course;
  static Course detail;
  String cid;
  Subtopic({this.course, String cid});


  // String coursename=course.courseName;
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(course.courseName),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:



            // MyStatelessWidget()
          Drawerlist()
         ) ,

    );
  }
}








class Drawerlist extends StatelessWidget {
final  Course course;
final String cid;
Drawerlist({this.course,this.cid});

  Future getAllSubtopic() async {
    var firestore = Firestore.instance;
    QuerySnapshot     qn = await firestore.collection('coursecontent').where('coursename',isEqualTo:'${this.cid}').getDocuments();
    debugPrint(qn.toString());

//qn = await firestore.collection('coursecontent').where('coursename',isEqualTo:'${this.cid}').getDocuments();

    debugPrint(qn.toString());
    debugPrint('${this.cid}');
    return qn.documents;
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(course.courseName),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:


     Container(


       //  Column(

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
                                child:ListTile(
                                  title: Text(snapshot.data[index].data[
                                      "topicname"]),
                                      onTap: (){
                                        String courseDescription,courseName;

  Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>ContentQuiz(topic:snapshot.data[index].data["topicname"],course :'${course.courseName}',coursedescription:snapshot.data[index].data[
                  "topicdescription"])
                    //Quiz(topic:snapshot.data[index].data["topicname"],course :'${course.courseName}')
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.

                ),
              );



                                      },
                                      ),


                             );
                        });
                  }
                })
    ),
     ),
    );


  }
}



//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
////import 'package:quizstar/resultpage.dart';
//
//class getjson extends StatelessWidget {
//  // accept the langname as a parameter
//
//  String langname;
//  getjson(this.langname);
//  String assettoload;
//
//  // a function
//  // sets the asset to a particular JSON file
//  // and opens the JSON
//  setasset() {
//    if (langname == "Python") {
//      assettoload = "assets/python.json";
//    } else if (langname == "Java") {
//      assettoload = "assets/java.json";
//    } else if (langname == "Javascript") {
//      assettoload = "assets/js.json";
//    } else if (langname == "C++") {
//      assettoload = "assets/cpp.json";
//    } else {
//      assettoload = "assets/linux.json";
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // this function is called before the build so that
//    // the string assettoload is avialable to the DefaultAssetBuilder
//    setasset();
//    // and now we return the FutureBuilder to load and decode JSON
//    return FutureBuilder(
//      future:
//      DefaultAssetBundle.of(context).loadString(assettoload, cache: true),
//      builder: (context, snapshot) {
//        List mydata = json.decode(snapshot.data.toString());
//        if (mydata == null) {
//          return Scaffold(
//            body: Center(
//              child: Text(
//                "Loading",
//              ),
//            ),
//          );
//        } else {
//          return quizpage(mydata: mydata);
//        }
//      },
//    );
//  }
//}
//
//class quizpage extends StatefulWidget {
//  var mydata;
//
//  quizpage({Key key, @required this.mydata}) : super(key: key);
//  @override
//  _quizpageState createState() => _quizpageState(mydata);
//}
//
//class _quizpageState extends State<quizpage> {
//  var mydata;
//  _quizpageState(this.mydata);
//
//  Color colortoshow = Colors.indigoAccent;
//  Color right = Colors.green;
//  Color wrong = Colors.red;
//  int marks = 0;
//  int i = 1;
//  // extra varibale to iterate
//  int j = 1;
//  int timer = 30;
//  String showtimer = "30";
//
//  Map<String, Color> btncolor = {
//    "a": Colors.indigoAccent,
//    "b": Colors.indigoAccent,
//    "c": Colors.indigoAccent,
//    "d": Colors.indigoAccent,
//  };
//
//  bool canceltimer = false;
//
//  // code inserted for choosing questions randomly
//  // to create the array elements randomly use the dart:math module
//  // -----     CODE TO GENERATE ARRAY RANDOMLY
//
//  // import 'dart:math';
//
//  //   var random_array;
//  //   var distinctIds = [];
//  //   var rand = new Random();
//  //     for (int i = 0; ;) {
//  //     distinctIds.add(rand.nextInt(10));
//  //       random_array = distinctIds.toSet().toList();
//  //       if(random_array.length < 10){
//  //         continue;
//  //       }else{
//  //         break;
//  //       }
//  //     }
//  //   print(random_array);
//
//  // ----- END OF CODE
//  var random_array = [1, 6, 7, 2, 4, 10, 8, 3, 9, 5];
//
//  // overriding the initstate function to start timer as this screen is created
//  @override
//  void initState() {
//    starttimer();
//    super.initState();
//  }
//
//  // overriding the setstate function to be called only if mounted
//  @override
//  void setState(fn) {
//    if (mounted) {
//      super.setState(fn);
//    }
//  }
//
//  void starttimer() async {
//    const onesec = Duration(seconds: 1);
//    Timer.periodic(onesec, (Timer t) {
//      setState(() {
//        if (timer < 1) {
//          t.cancel();
//          nextquestion();
//        } else if (canceltimer == true) {
//          t.cancel();
//        } else {
//          timer = timer - 1;
//        }
//        showtimer = timer.toString();
//      });
//    });
//  }
//
//  void nextquestion() {
//    canceltimer = false;
//    timer = 30;
//    setState(() {
//      if (j < 10) {
//        i = random_array[j];
//        j++;
//      } else {
//        Navigator.of(context).pushReplacement(MaterialPageRoute(
//          builder: (context) => resultpage(marks: marks),
//        ));
//      }
//      btncolor["a"] = Colors.indigoAccent;
//      btncolor["b"] = Colors.indigoAccent;
//      btncolor["c"] = Colors.indigoAccent;
//      btncolor["d"] = Colors.indigoAccent;
//    });
//    starttimer();
//  }
//
//  void checkanswer(String k) {
//    // in the previous version this was
//    // mydata[2]["1"] == mydata[1]["1"][k]
//    // which i forgot to change
//    // so nake sure that this is now corrected
//    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
//      // just a print sattement to check the correct working
//      // debugPrint(mydata[2][i.toString()] + " is equal to " + mydata[1][i.toString()][k]);
//      marks = marks + 5;
//      // changing the color variable to be green
//      colortoshow = right;
//    } else {
//      // just a print sattement to check the correct working
//      // debugPrint(mydata[2]["1"] + " is equal to " + mydata[1]["1"][k]);
//      colortoshow = wrong;
//    }
//    setState(() {
//      // applying the changed color to the particular button that was selected
//      btncolor[k] = colortoshow;
//      canceltimer = true;
//    });
//
//    // changed timer duration to 1 second
//    Timer(Duration(seconds: 1), nextquestion);
//  }
//
//  Widget choicebutton(String k) {
//    return Padding(
//      padding: EdgeInsets.symmetric(
//        vertical: 10.0,
//        horizontal: 20.0,
//      ),
//      child: MaterialButton(
//        onPressed: () => checkanswer(k),
//        child: Text(
//          mydata[1][i.toString()][k],
//          style: TextStyle(
//            color: Colors.white,
//            fontFamily: "Alike",
//            fontSize: 16.0,
//          ),
//          maxLines: 1,
//        ),
//        color: btncolor[k],
//        splashColor: Colors.indigo[700],
//        highlightColor: Colors.indigo[700],
//        minWidth: 200.0,
//        height: 45.0,
//        shape:
//        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations(
//        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
//    return WillPopScope(
//      onWillPop: () {
//        return showDialog(
//            context: context,
//            builder: (context) => AlertDialog(
//              title: Text(
//                "Quizstar",
//              ),
//              content: Text("You Can't Go Back At This Stage."),
//              actions: <Widget>[
//                FlatButton(
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: Text(
//                    'Ok',
//                  ),
//                )
//              ],
//            ));
//      },
//      child: Scaffold(
//        body: Column(
//          children: <Widget>[
//            Expanded(
//              flex: 3,
//              child: Container(
//                padding: EdgeInsets.all(15.0),
//                alignment: Alignment.bottomLeft,
//                child: Text(
//                  mydata[0][i.toString()],
//                  style: TextStyle(
//                    fontSize: 16.0,
//                    fontFamily: "Quando",
//                  ),
//                ),
//              ),
//            ),
//            Expanded(
//              flex: 6,
//              child: Container(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    choicebutton('a'),
//                    choicebutton('b'),
//                    choicebutton('c'),
//                    choicebutton('d'),
//                  ],
//                ),
//              ),
//            ),
//            Expanded(
//              flex: 1,
//              child: Container(
//                alignment: Alignment.topCenter,
//                child: Center(
//                  child: Text(
//                    showtimer,
//                    style: TextStyle(
//                      fontSize: 35.0,
//                      fontWeight: FontWeight.w700,
//                      fontFamily: 'Times New Roman',
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
