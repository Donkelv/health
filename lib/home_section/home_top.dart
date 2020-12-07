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
  void initState() { 
    super.initState();
    widget.provider.initPlatformState();
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
                            mainData(),
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

  BarChartData mainData(){
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black,
          getTooltipItem: (group, groupIndex, rod, rodindex){
            String weekDay;
            switch (group.x.toInt()) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3: 
                weekDay = "Thursday";
                break;
              case 4:
                weekDay = "Friday";
                break;
              case 5: 
                weekDay = 'Satuday';
                break;
              case 6: 
                weekDay = 'Sunday';
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
              return 'M';
              case 1:
              return 'T';
              case 2:
              return 'W';
              case 3:
              return 'Th';
              case 4:
              return 'F';
              case 5:
              return 'Sa';
              case 6:
              return 'Su';

                
                
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
      barGroups: showingGroups(),
    );
  }


  List<BarChartGroupData> showingGroups() => List.generate(7, (index) {
    switch (index) {
          case 0:
            return makeGroupData(0, 5, isTouched: index == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: index == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: index == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: index == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: index == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: index == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: index == touchedIndex);
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

 /*  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: false,
          reservedSize: 22,
          getTextStyles: (value) =>
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 10,),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '9:00';
              case 2:
                return '10:00';
              case 3:
                return '12:00';
              case 4:
                return '4:00';
              case 5:
                return '8:00';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '100';
              case 2:
                return '500';
              case 3:
                return '1k';
              case 4:
                return '5k';
              case 5:
                return '10k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        border: Border(top: BorderSide.none, bottom: BorderSide.none, left: BorderSide.none, right: BorderSide.none),
      ),
         // FlBorderData(show: true, border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05), width: 1.0,), bottom:BorderSide(color: Colors.black.withOpacity(0.05), width: 1.0,), ),/* border: Border.all(color: const Color(0xff37434d), width: 1) */),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
 */

}



