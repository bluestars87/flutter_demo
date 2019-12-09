import 'package:flutter/material.dart';

class ProductContentFirst extends StatefulWidget {
  ProductContentFirst({Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
         child: ListView.builder(
           itemCount: 50,
           itemBuilder: (context,index){
             return ListTile(
               title: Text("ddddddd${index}"),
             );
           },
         ),
       ),
    );
  }
}