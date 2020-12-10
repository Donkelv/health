import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/app_logic/walk_tracker.dart';
import 'package:pedometer/pedometer.dart';
import 'package:hive/hive.dart';
import 'package:fl_chart/fl_chart.dart';


class TopHome extends StatefulWidget {
  final WalkNotifier provider;
  TopHome({this.provider});

  @override
  _TopHomeState createState() => _TopHomeState();
}



class _TopHomeState extends State<TopHome> {
  @override
  void initState()  {
    super.initState();
    widget.provider.initPlatformState();
    widget.provider.getSundayBox();
    widget.provider.getSaturdayBox();
    widget.provider.getMondayBox();
    widget.provider.getFridayBox();
    widget.provider.getTuesdayBox();
    widget.provider.getWednesdayBox();
    widget.provider.getThursdayBox();
    
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final Color barBackgroundColor = const Color(0xFF1B6B76).withOpacity(0.1);

  int touchedIndex;

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
        Text("Today's Highlights", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13.0),),
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 20.0),
          child: Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.white,
              elevation: 0.5,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                color: Colors.transparent,
                width: size.width,
                //height: 200.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total", style: TextStyle(color: Colors.black,  fontSize: 12.0, fontWeight: FontWeight.normal, ),),
                      SizedBox(height: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${widget.provider.walk} ", style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold,),),
                          
                          Text("steps today!!", style: TextStyle(color: Colors.black,  fontSize: 12.0, fontWeight: FontWeight.w200, ),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Center(
                          child: BarChart(
                            mainData(widget.provider),
                          ),
                        ),
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

  BarChartData mainData(WalkNotifier provider) => BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black,
          getTooltipItem: (group, groupIndex, rod, rodindex){
            String weekDay;
            switch (group.x.toInt()) {
              case 0:
                weekDay = 'Sunday';
                break;
              case 1:
                weekDay = 'Monday';
                break;
              case 2:
                weekDay = 'Tuesday';
                break;
              case 3: 
                weekDay = "Wednesday";
                break;
              case 4:
                weekDay = "Thursday";
                break;
              case 5: 
                weekDay = 'Friday';
                break;
              case 6: 
                weekDay = 'Saturday';
                break;
                
             // default: null;
            }
            return BarTooltipItem(weekDay + '\n' + (rod.y -1).toString(), TextStyle(color: Colors.white,),);
          }
        ),
        touchCallback: (barTouch){
          setState(() {
            if (barTouch.spot != null && barTouch.touchInput is! FlPanEnd && barTouch.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouch.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        }
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0,),
          margin: 16.0,
          getTitles: (double value){
            switch (value.toInt()) {
              case 0:
              return 'Su';
              case 1:
              return 'M';
              case 2:
              return 'T';
              case 3:
              return 'W';
              case 4:
              return 'Th';
              case 5:
              return 'Fr';
              case 6:
              return 'Sa';

                
                
              default: return '';
                
            }
          }
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(provider),
    );


  List<BarChartGroupData> showingGroups(WalkNotifier provider) => List.generate(7, (index) {
    switch (index) {
          case 0:
            return makeGroupData(0, provider.sundayWalk == null ? 0.0 : provider.sundayWalk.toDouble(), isTouched: index == touchedIndex);
          case 1:
            return makeGroupData(1, provider.mondayWalk == null ? 0.0 : provider.mondayWalk.toDouble(), isTouched: index == touchedIndex);
          case 2:
            return makeGroupData(2, provider.tuesdayWalk == null ? 0.0 : provider.tuesdayWalk.toDouble(), isTouched: index == touchedIndex);
          case 3:
            return makeGroupData(3, provider.wednesdayWalk == null ? 0.0 : provider.wednesdayWalk.toDouble(), isTouched: index == touchedIndex);
          case 4:
            return makeGroupData(4, provider.thusdayWalk == null ? 0.0 : provider.thusdayWalk.toDouble(), isTouched: index == touchedIndex);
          case 5:
            return makeGroupData(5, provider.fridayWalk == null ? 0.0 : provider.fridayWalk.toDouble(), isTouched: index == touchedIndex);
          case 6:
            return makeGroupData(6, provider.saturdayWalk == null ? 0.0 : provider.saturdayWalk.toDouble(), isTouched: index == touchedIndex);
          default:
            return null;
        }
  });



  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.black,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

}



