import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/app_logic/walk_tracker.dart';
import 'package:health/home.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
 
  String backImage = "assets/background.png";
  
  WalkNotifier walkNotifier = WalkNotifier();
  



  

  /* @override
  void initState() {
    super.initState();
    initPlatformState();
    
  } */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(backImage),
          fit: BoxFit.cover,
        ),),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Home(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
