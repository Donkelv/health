import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:hive/hive.dart';



 final walkProvider = ChangeNotifierProvider((ref){
   return WalkNotifier();
 }); 

 Pedometer _pedometer;
 StreamSubscription<int> _subscription;

 Stream<StepCount> _stepCountStream;
 Stream<PedestrianStatus> _pedestrianStatusStream;

//i dont know how to continue





class WalkNotifier extends ChangeNotifier{
  /* WalkNotifier([this._walk = 0]); */
  int _walk;
  

  dynamic _status;
  

  String _pedesError;

  int _sundayBox;

  int _mondayBox;

  int _tuesdayBox;

  int _wednesdayBox;

  int _thursdayBox;

  int _fridayBox;

  int _saturdayBox;
  

  String _stepCountError;

  List days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
 //var dateTime = DateTime.now();
  Box<int> stepsBox = Hive.box('steps');
 //List steps = [];
  //Jiffy(dateTime); 

  getSundayBox() async{
    final box = await Hive.openBox("Sunday");

    this._sundayBox = box as int;
    notifyListeners();
  }

  int get sundayWalk => _sundayBox;

  getMondayBox() async{
    final box = await Hive.openBox("Monday");

    this._mondayBox = box as int;
    notifyListeners();
  }

  int get mondayWalk => _mondayBox;

  getTuesdayBox() async{
    final box = await Hive.openBox("Tuesday");

    this._tuesdayBox = box as int;
    notifyListeners();
  }

  int get tuesdayWalk => _tuesdayBox;

  getWednesdayBox() async{
    final box = await Hive.openBox("Wednesday");

    this._wednesdayBox = box as int;
    notifyListeners();
  }

  int get wednesdayWalk => _wednesdayBox;

  getThursdayBox() async{
    final box = await Hive.openBox("Thursday");

    this._thursdayBox = box as int;
    notifyListeners();
  }

  int get thusdayWalk => _thursdayBox;

  getFridayBox() async{
    final box = await Hive.openBox("Friday");

    this._fridayBox = box as int;
    notifyListeners();
  }

  int get fridayWalk => _fridayBox;

  getSaturdayBox() async{
    final box = await Hive.openBox("Saturday");

    this._saturdayBox = box as int;
    notifyListeners();
  }

  int get saturdayWalk => _saturdayBox;

  void onStepCount(event) {
    print(event.steps);
    //print(_walk);
    //DateTime timeStamp = event.timeStamp;
    if (Jiffy().day == 0) {
      stepsBox.put(days[0], event.steps );
      this._walk = sundayWalk;
    } else if (Jiffy().day == 1) {
      stepsBox.put(days[1], event.steps);
      this._walk = mondayWalk;
    } else if (Jiffy().day == 2){
      stepsBox.put(days[2], event.steps);
      this._walk = tuesdayWalk;
    } else if (Jiffy().day == 3){
      stepsBox.put(days[3], event.steps);
      this._walk = wednesdayWalk;
    } else if (Jiffy().day == 4){
      stepsBox.put(days[4], event.steps);
      this._walk = fridayWalk;
    } else if (Jiffy().day == 5) {
      stepsBox.put(days[5], event.steps);
      this._walk = saturdayWalk;
    } else if (Jiffy().day == 6) {
      stepsBox.put(days[6], event.steps);
      this._walk = sundayWalk;
    }

    //this._walk = stepsBox.get(Jiffy().day);
    this._walk = event.steps;
    
    //Jiffy().day;
    notifyListeners();
   
  }

  int get walk => _walk;

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    
     _status = event.status.toString();
    notifyListeners();
    
  }
  dynamic get status => _status;

  void onPedestrianStatusError(error) {
    print("pedestrian status error: $error");
    _pedesError = 'Pedestrian Status Not Available';
    notifyListeners();
    
  }
  String get pedesError => _pedesError;

  void onStepCountError(error) {
    print("step count error $error");
    _stepCountError = "Unable To Count Your Steps";
    notifyListeners();
    
  } 
  String get stepCountError => _stepCountError;

  
 
  
  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    
  }

  

  void save(){

   
  }

}


//WalkNotifier walkNotifier;


  