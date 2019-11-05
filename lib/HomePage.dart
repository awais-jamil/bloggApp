import 'package:bloggapp/Authentication.dart';
import 'package:bloggapp/PhotoUpload.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget{

  HomePage({
    this.auth,
    this.onSignedOut
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {

    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{


  void logoutUser() async {
    try{

     await widget.auth.SignOut();
     widget.onSignedOut();

    } catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: new AppBar(
        
        title: new Text("Home"),
      ),

      body: new Container(


      ),

      bottomNavigationBar: new BottomAppBar(

        color: Colors.blue,

        child: new Container(

          margin: const EdgeInsets.only(left: 80, right: 80),

          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[

              new IconButton(
                  icon: new Icon(Icons.home),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context){
                          return new PhotoUpload();
                        }),
                    );
                  }
              ),
              new IconButton(
                  icon: new Icon(Icons.settings),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: logoutUser
              )
            ],
          ),
        ),
      ),
    );
  }
}