import 'package:flutter/material.dart';

import 'package:health/profile_section/home_profile.dart';

import 'profile_section/medical_details.dart';
import 'profile_section/privacy.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key key,
    @required String steps,
    @required String dateTime,
  })  : _steps = steps,
        _dateTime = dateTime,
        super(key: key);

  final String _steps;
  final String _dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
