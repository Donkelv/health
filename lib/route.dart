import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:health/app_logic/walk_tracker.dart';
import 'package:health/home.dart';

import 'app_logic/walk_tracker.dart';
//import 'package:pedometer/pedometer.dart';
//import 'dart:async';

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
 
  String backImage = "assets/background.png";
  
  WalkNotifier walkNotifier = WalkNotifier();

  double _sigmaX = 3.0;
  double _sigmaY = 3.0;
  double _opacity = 0.5;


  

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
          
        ),
        
        ),
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            color: Color(0xFFC6D2D5).withOpacity(0.1),
            child: BackdropFilter(
              filter:ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
                child: Home(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
