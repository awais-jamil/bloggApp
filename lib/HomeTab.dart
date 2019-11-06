import 'package:bloggapp/Authentication.dart';
import 'package:bloggapp/PhotoUpload.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeTab extends StatefulWidget{

//  HomeTab({
//    this.auth,
//    this.onSignedOut
//  });

//  final AuthImplementation auth;
//  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {

    return _HomeTabState();
  }
}

class _HomeTabState extends State<HomeTab>{


//  void logoutUser() async {
//    try{
//
//      await widget.auth.SignOut();
//      widget.onSignedOut();
//
//    } catch(e) {
//
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Container(


      ),

    );
  }
}