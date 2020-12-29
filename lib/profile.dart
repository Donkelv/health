import 'package:flutter/material.dart';

import 'package:health/profile_section/home_profile.dart';

import 'profile_section/medical_details.dart';
import 'profile_section/privacy.dart';

class Profile extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
