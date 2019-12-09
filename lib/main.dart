import 'package:flutter/material.dart';
import 'package:flutter_demo/routers/router.dart' as prefix0;
import 'pages/tabs/Tabs.dart';
import 'routers/router.dart';

void main(){
  runApp(MyApp());
}

//自定义组件
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      initialRoute: '/productContent',
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}