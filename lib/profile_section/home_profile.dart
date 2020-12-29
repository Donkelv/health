import 'package:flutter/material.dart';

class HomeProfileSection extends StatelessWidget {
  const HomeProfileSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(children: [
        Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16.0, fontFamily: "Inter",),
        ),
        SizedBox(
          height: 40.0,
        ),
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Color(0xFFAEC5FF),
          child: Center(
            child: Text(
              "CA",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 24.0,
        ),
        Text(
          "Cales Andrea",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}
