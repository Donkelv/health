import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/app_logic/walk_tracker.dart';

class TopHome extends StatefulWidget {
  final WalkNotifier provider;
  TopHome({this.provider});

  @override
  _TopHomeState createState() => _TopHomeState();
}



class _TopHomeState extends State<TopHome> {
  @override
  void initState() { 
    super.initState();
    widget.provider.initPlatformState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text("Summary", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold, ),),
            CircleAvatar(
              radius: 25.0,
              backgroundColor:  Color(0xFFAEC5FF),
              child: Center(
                child: Text("CA", style: TextStyle(color: Color(0xFF0070FF), fontSize: 13.0, fontWeight: FontWeight.bold,),),
              ),
            ),

          ]
        ),
        SizedBox(
          height: 25.0,
        ),
        Text("${widget.provider.walk}", style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold,),),
        /* Consumer(
          builder: (_, watch, __){
            final walkProvide = watch(walkProvider);
            return Text("${walkProvide.walk}", style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold,),);
          },
    ),  */
      ],
    );
  }
}

