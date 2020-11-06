import 'package:flutter/material.dart';
import 'package:health/home_section/home_top.dart';


class Home extends StatelessWidget {
  const Home({
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
        TopHome(),
        
      ],
    );
  }
}

