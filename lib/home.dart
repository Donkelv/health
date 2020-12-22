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
    walk.initPlatformState();
    walk.getSundayBox();
    walk.getMondayBox();
    walk.getTuesdayBox();
    walk.getWednesdayBox();
    walk.getThursdayBox();
    walk.getFridayBox();
    walk.getSaturdayBox();
    //print(walk.walk.toString());
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopHome(provider: walk),
          Heart(size: size),
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
