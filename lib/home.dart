import 'package:flutter/material.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Steps Taken", style: TextStyle(fontSize: 30.0, color: Colors.black,),),
        Row(
          children: [
            Text("$_steps", style: TextStyle(color: Colors.black, fontSize: 60.0, fontWeight: FontWeight.w500,),),
            Text("$_dateTime", style: TextStyle(color: Colors.black, fontSize: 15.0),)
          ],
        )
      ],
    );
  }
}