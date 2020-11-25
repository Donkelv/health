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
    Size size = MediaQuery.of(context).size;
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20.0),
          child: Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                color: Colors.transparent,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total", style: TextStyle(color: Colors.black,  fontSize: 12.0, fontWeight: FontWeight.w100, ),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${widget.provider.walk} ", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold,),),
                          Text("steps", style: TextStyle(color: Colors.black,  fontSize: 12.0, fontWeight: FontWeight.w100, ),),
                        ],
                      ),
                
                    ]
                  ),
                ),
              ),
            ),
          ),
        ),
        
        
      ],
    );
  }
}

