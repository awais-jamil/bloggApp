import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Mapping.dart';

void main() {
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'BlogApp',

      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MappingPage( auth: Auth(),),
    );
  }
}

