import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhotoUpload extends StatefulWidget{

  final AuthImplementation auth;
  final db = Firestore.instance;
  final VoidCallback onSwitchTab;

  PhotoUpload({
    this.auth,
    this.onSwitchTab
  });

  @override
  State<StatefulWidget> createState() {

    return _PhotoUploadState();
  }
}

class _PhotoUploadState extends State<PhotoUpload>{

  File sampleImage;
  final _formKey =  new GlobalKey<FormState>();
  String _myValue;
  String url;
  bool _isLoading = false;

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

  void uploadImageAndSaveBlog() async {

    if(validateAndSave()) {

      setState(() {
        _isLoading = true;
      });

      final StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('post images');

      var timeKey = DateTime.now();

      final StorageUploadTask uploadTask = storageReference.child(timeKey.toString()+ ".jpg").putFile(sampleImage);

      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      print('File Uploaded');
        setState(() {
          url = imageUrl;
        });
      uploadBlog();
    }
  }

  void uploadBlog() async {
    if(validateAndSave()){

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String formattedTime= DateFormat(' hh:mm a').format(now);

      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      await Firestore.instance.collection('blogs').document(user.uid)
          .setData({ 'description': _myValue , 'image': url, 'date':  formattedDate.toString(), 'time': formattedTime.toString()});

      print("success");

      setState(() {
        _isLoading = false;
      });

      widget.onSwitchTab();
    }
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(

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
        margin: EdgeInsets.all(15.0),
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

                  onPressed: uploadImageAndSaveBlog,
                ),

                SizedBox(height: 20.0),

                showCircularProgress()
              ],
            )
        )
    );
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

}