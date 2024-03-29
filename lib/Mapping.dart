import 'package:flutter/material.dart';
import 'LoginRegistration.dart';
import 'Authentication.dart';
import 'MainTabBar.dart';

class MappingPage extends StatefulWidget{

  final AuthImplementation auth;

  MappingPage({
    this.auth,
  });

  @override
  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _MappingPageState extends State<MappingPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();

    widget.auth.GetCurrentUser().then((firebaseUserID){

      setState(() {
        authStatus = firebaseUserID == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginRegistration(
          auth:  widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new MainTabBar(
          auth:  widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return null;
  }
}