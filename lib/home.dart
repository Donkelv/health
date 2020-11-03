import 'package:flutter/material.dart';

import 'sections/home_profile.dart';
import 'sections/medical_details.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
    @required String steps,
    @required String dateTime,
  }) : _steps = steps, _dateTime = dateTime, super(key: key);

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
        MedicalDetails()
      ],
    );
  }
}

