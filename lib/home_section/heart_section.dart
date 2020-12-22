import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Heart extends StatelessWidget {
  const Heart({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: Colors.transparent,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.0,
                width: 100.0,
                child: SvgPicture.asset(
                  "assets/heart.svg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Heart Rate",
                        style: TextStyle(
                          color: Color(0xFFFF235B),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "90  ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "BPM",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ])
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
