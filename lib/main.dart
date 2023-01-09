import 'package:family_tree/pages/homepage.dart';
import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'شجرة العائلة',
      theme: ThemeData(
        primarySwatch:Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Directionality(
          textDirection:TextDirection.rtl,
          child: HomePage()),
    );
  }
}

