import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoUpload extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _PhotoUploadState();
  }
}

class _PhotoUploadState extends State<PhotoUpload>{

  File sampleImage;
  final _formKey =  new GlobalKey<FormState>();
  String _myValue;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave(){

    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(

        appBar: new AppBar(

          title: new Text("Photo Upload"),
          centerTitle: true,
        ),
        body: new Center(

          child:  sampleImage == null? Text("Select Image"): enableUpload(),
        ),

        floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
          tooltip: "get Image",
          child: new Icon(Icons.add_a_photo),
        ),
      );
  }

  Widget enableUpload(){

    return Container(
        child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                Image.file(sampleImage, height: 330.0, width: 660.0,),
                SizedBox(height: 10.0),

                new TextFormField(

                  decoration: new InputDecoration(labelText: "Description"),
                  validator: (value){
                    return value.isEmpty ? "Blog decription is required" : null;
                  },
                  onSaved: (value){
                    return _myValue = value;
                  },
                ),
                SizedBox(height: 10.0),

                RaisedButton(
                  elevation: 10.0,
                  child: Text("Upload Post"),
                  textColor: Colors.white,
                  color: Colors.blue,

                  onPressed: validateAndSave,
                )

              ],
            )
        )
    );
  }
}