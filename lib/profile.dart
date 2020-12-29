import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:health/profile_section/home_profile.dart';

import 'profile_section/medical_details.dart';
import 'profile_section/privacy.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  
String backImage = "assets/background.png";
double _sigmaX = 3.0;
  double _sigmaY = 3.0;
  double _opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: size.width,
          height: size.height,
          color: Color(0xFFC6D2D5).withOpacity(0.1),
          child: BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeProfileSection(),
                    SizedBox(
                      height: 40.0,
                    ),
                    MedicalDetails(),
                    SizedBox(
                      height: 28.0,
                    ),
                    PrivacySection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
