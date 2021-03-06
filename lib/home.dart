import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/home_section/heart_section.dart';
import 'package:health/home_section/home_top.dart';
import 'package:health/home_section/sleep_section.dart';

import 'app_logic/walk_tracker.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Size size = MediaQuery.of(context).size;
    final walk = watch(walkProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      walk.initPlatformState();
      walk.getSundayBox();
      walk.getSunday();
      walk.getMondayBox();
      walk.getMonday();
      walk.getTuesdayBox();
      walk.getTuesday();
      walk.getWednesdayBox();
      walk.getWednesday();
      walk.getThursdayBox();
      walk.getThursday();
      walk.getFridayBox();
      walk.getFriday();
      walk.getSaturdayBox();
      walk.getSaturday();
    });

    //walk.heartMonitor();
    //print(walk.walk.toString());
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopHome(provider: walk),
          Heart(size: size, provider: walk),
          SizedBox(height: 20.0),
          Sleep(size: size),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}
