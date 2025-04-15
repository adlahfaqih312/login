import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});


  @override
  State<SplachScreen> createState() => _SplachScreenState();

}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/Note.jpg"),
      ),
    );
  }
}
