import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password,String name);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

//  Future<String> signUp(String email, String password,String name) async {
//    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
//        email: email, password: password);
//    FirebaseUser user = result.user;
//    var userUpdateInfo = new UserUpdateInfo(); //create user update object
//    userUpdateInfo.displayName = name; //set user display name to your variable.
//    await _firebaseAuth.updateProfile(userUpdateInfo); //update the info
//    await user.reload(); //reload the user data
//    return user.uid;
//  }

  Future<String> signUp(String email, String password, String name) async {
    AuthResult result =await  _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

 FirebaseUser user=result.user;
//    Firestore.instance.collection('users').document().setData({
//      'name': name,
//      'uid':user.uid,
//      'email': user.email,
//      'isEmailVerified': user.isEmailVerified, // will also be false
//      'photoUrl': user.photoUrl, // will always be null
//    }
//    ).catchError((err) => print(err));
    try
    {
    Firestore.instance.collection('users').document().setData({ 'userid': user.uid, 'name': name ,'email': user.email,});
  } catch (error) {
  print('Error: $error');
  // Do something to show user
  }
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}