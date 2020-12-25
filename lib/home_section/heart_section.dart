import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health/app_logic/walk_tracker.dart';

class Heart extends StatefulWidget {
  const Heart({
    Key key,
    @required this.size,
    @required this.provider,
  }) : super(key: key);

  final Size size;
  final WalkNotifier provider;

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  void dispose() {
    widget.provider.dispose();
    widget.provider.removeListener(() {
      widget.provider.getFridayBox();
      widget.provider.getMondayBox();
      widget.provider.getSaturdayBox();
      widget.provider.getSundayBox();
      widget.provider.getThursdayBox();
      widget.provider.getTuesdayBox();
      widget.provider.getWednesdayBox();
      //widget.provider.cancel();
      widget.provider.heartMonitor();
    });
    widget.provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: () => widget.provider.heartMonitor(),
        child: Container(
          color: Colors.transparent,
          width: widget.size.width,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
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
                                "0.0 ",
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
      ),
    );
  }
}
