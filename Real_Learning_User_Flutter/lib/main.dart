import 'package:flutter/material.dart';
import 'package:learningapp/service/authentication.dart';
import 'package:learningapp/pages/root_page.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
        title: 'Real Learning',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         primarySwatch: Colors.green,
       
      ),
        home: new RootPage(auth: new Auth()));
  }
}
