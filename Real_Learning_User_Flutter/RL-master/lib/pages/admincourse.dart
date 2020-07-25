import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/service/authentication.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;

class AdminCourse extends StatefulWidget {
AdminCourse({Key key, this.auth, this.userId, this.logoutCallback})
    : super(key: key);
final BaseAuth auth;
final VoidCallback logoutCallback;
final String userId;
  @override
  State<StatefulWidget> createState() => new _AdminCoursePageState();

}
class _AdminCoursePageState extends State<AdminCourse> {
  String _name;
  String _description;
  File _image;
  String _uploadedFileURL;
  final _formKey = new GlobalKey<FormState>();
  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
Future clearFile() async
{
  print('hello');
 setState(() {
    _image=null;
 });

}
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() async{
        _uploadedFileURL = fileURL;
        var firestore = Firestore.instance;
        await firestore.collection("course").add({
          'name': _name,
          'description': _description,
          'imageurl':_uploadedFileURL,
        }).then((documentReference) {
          print(documentReference.documentID);
//      clearForm();
        }).catchError((e) {
          print(e);
        });
      });
    });

  }
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
        body: Stack(
          children: <Widget>[

            _showForm(),
           // _showCircularProgress(),
          ],
        ));


  }
  Widget showUploadImage()
  {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),

    child: Column(
    children: <Widget>[
      _image!=null ? Text('selected image'):Container(),
        _image != null
            ? Image.file(
          _image,
          height: 150,
        )
            : Container(),
        _image == null
            ? RaisedButton(
          child: Text('Choose File'),
          onPressed: chooseFile,
          color: Colors.cyan,
        )
            : Container(),
        _image != null
            ? RaisedButton(
          child: Text('Clear Selection'),
          onPressed: clearFile,
        )
            : Container(),
      _uploadedFileURL != null?Text('Uploaded Image'):Container(),
        _uploadedFileURL != null
            ? Image.network(
          _uploadedFileURL,
          height: 150,
          )
              : Container(),

  ]
    ),
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[

              showNameInput(),

              showDescriptionInput(),
              showUploadImage(),
              showPrimaryButton(),
              //showSecondaryButton(),
              //showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Course Name',
            icon: new Icon(
              Icons.text_fields,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) {_name = value.trim();print(_name);},
      ),
    );
  }
    Widget showDescriptionInput() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Course descripiton',
              icon: new Icon(
                Icons.text_fields,
                color: Colors.grey,
              )),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (value) => _description = value.trim(),
        ),
      );
  }
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {

    });
    if (validateAndSave()) {
   uploadFile();
    }
    }
  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.deepOrange,
            child: new Text('submit',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}