import 'dart:math';

import 'package:bloggapp/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'DialogBox.dart';

class LoginRegistration extends StatefulWidget{

  LoginRegistration({
    this.auth,
    this.onSignedIn
  });

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() {
    return _LoginRegistrationState(

    );
  }
}

enum FormType{
  login,
  register
}

class _LoginRegistrationState extends State<LoginRegistration>{

  DialogBox dialogBox =  new DialogBox();
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  bool _isLoading = false;

 bool validateInput(){
    final form  = formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
 }

 void submit() async {

   if(validateInput()){

     try{

       setState(() {
         _isLoading = true;
       });
       if(_formType == FormType.login){
          String userId = await widget.auth.SignIn(_email, _password);
          print("Login UserID:" + userId);
          setState(() {
            _isLoading = false;
          });
       } else {
         String userId = await widget.auth.SignUp(_email, _password);
         print("SignUp UserID:" + userId);
         setState(() {
           _isLoading = false;
         });
       }

       widget.onSignedIn();

     } catch(e){
         setState(() {
           _isLoading = false;
         });
        dialogBox.information(context, "Error", e.toString());
     }
   }

 }

 void moveToRegister(){

   formKey.currentState.reset();

   setState(() {
     _formType = FormType.register;
   });
 }

  void moveToLogin(){

    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

// ui code here
  @override
  Widget build(BuildContext context) {

    return new Scaffold(


      appBar: new AppBar(

        title: new Text("Blog App"),
      ),

      body: new Container(

        margin: EdgeInsets.all(15.0),

        child: new Form(

          key: formKey,

          child: new Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInput() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInput(){

    return[

      SizedBox(height: 10.0),
      logo(),
      SizedBox(height: 20.0),

      new TextFormField(

        decoration: new InputDecoration(labelText: "Email"),

        validator: (value){
          return value.isEmpty ? 'please enter email' : null;
        },

        onSaved: (value){
          return _email = value;
        },
      ),

      SizedBox(height: 20.0),

      showCircularProgress(),

      new TextFormField(

        decoration: new InputDecoration(labelText: "Password"),
        obscureText: true,

        validator: (value){
          return value.isEmpty ? 'please enter password' : null;
        },

        onSaved: (value){
          return _password = value;
        },
      ),

      SizedBox(height: 20.0),

    ];
  }

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget logo(){

    return new Hero(
      tag: "hero",
      child: new CircleAvatar(

        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset("images/logo.png"),
      ),
    );
  }

  List<Widget> createButtons(){

   if(_formType == FormType.login) {
     return [

       new RaisedButton(

         child: new Text("Login", style: new TextStyle(fontSize: 20.0),),
         textColor: Colors.white,
         color: Colors.blue,

         onPressed: submit,
       ),
       new FlatButton(

         child: new Text(
           "Create Account", style: new TextStyle(fontSize: 14.0),),
         textColor: Colors.blue,
         onPressed: moveToRegister,
       )

     ];
   } else{
     return [

       new RaisedButton(

         child: new Text("SignUp", style: new TextStyle(fontSize: 20.0),),
         textColor: Colors.white,
         color: Colors.blue,

         onPressed: submit,
       ),
       new FlatButton(

         child: new Text(
           "Already have Account? Login", style: new TextStyle(fontSize: 14.0),),
         textColor: Colors.blue,
         onPressed: moveToLogin,
       )

     ];

   }
  }

}