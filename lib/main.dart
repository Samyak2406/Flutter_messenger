import 'package:flutter/material.dart';
import 'package:messenger001/register.dart';
import 'login.dart';
import 'home.dart';
import 'register.dart';
import 'chat.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.cyanAccent,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: home.id,
    routes: {
      login.id:(context)=>login(),
      register.id:(context)=>register(),
      home.id:(context)=>home(),
      chat.id:(context)=>chat(),
    },
    );
  }
}
