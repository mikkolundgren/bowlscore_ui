import 'package:flutter/material.dart';
import './views/dashboard.dart';
import './services/service_locator.dart';
import './services/firebase_service.dart';

void main() {
  setupLocator();
  signIn();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
