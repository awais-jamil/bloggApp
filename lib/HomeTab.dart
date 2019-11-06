import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Blog.dart';

class HomeTab extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return _HomeTabState();
  }
}

class _HomeTabState extends State<HomeTab>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Container(

         child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('blogs').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  Blog blog = new Blog(
                    document['date'],
                    document['time'],
                    document['description'],
                    document['image'],
                  );
                  
                  return BlogCard(blog);

                }).toList(),
              );
            },
          ),
      ),

    );
  }

  Widget BlogCard(Blog blog){
    return new Card(
       elevation: 10.0,
       margin: EdgeInsets.all(10.0),

       child: new Container(
          
         padding: EdgeInsets.all(10),
         child: new Column(
            
           crossAxisAlignment: CrossAxisAlignment.start,
            
           children: <Widget>[

              new Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    blog.date,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  new Text(
                    blog.date,
                    style: Theme.of(context).textTheme.subtitle,
                    textAlign: TextAlign.center,
                  )
                ],
              ),

             SizedBox(height: 10,),

             new Image.network(blog.imageUrl, fit: BoxFit.cover,),

             SizedBox(height: 10,),

             new Text(
               blog.description,
               style: Theme.of(context).textTheme.title,
               textAlign: TextAlign.center,
             )
             
           ],
         ),
       ),

    );
  }
}