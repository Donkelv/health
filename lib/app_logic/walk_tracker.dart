import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:hive/hive.dart';



 final walkProvider = ChangeNotifierProvider((ref){
   return WalkNotifier();
 }); 

/* Pedometer _pedometer;
StreamSubscription<int> _subscription; */

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
    //final box = await Hive.openBox("Sunday");
    this._sundayBox = stepsBox.get("Sunday");
   // print("Steps from the box ${stepsBox.get('Sunday')}");
    //this._sundayBox = box.values as int;    
    notifyListeners();
  }

  int get sundayWalk => _sundayBox;

  getMondayBox() async{
    //final box = await Hive.openBox("Monday");

    this._mondayBox = stepsBox.get("Monday");
    notifyListeners();
  }

  int get mondayWalk => _mondayBox;

  getTuesdayBox() {
    //final box = await Hive.openBox("Tuesday");

    this._tuesdayBox = stepsBox.get("Tuesday");
    notifyListeners();
  }

  int get tuesdayWalk => _tuesdayBox;

  getWednesdayBox() async{
    //final box = await Hive.openBox("Wednesday");

    this._wednesdayBox = stepsBox.get("Wednesday");//box.values as int;
    notifyListeners();
  }

  int get wednesdayWalk => _wednesdayBox;

  getThursdayBox() async{
    //final box = await Hive.openBox("Thursday");

    this._thursdayBox = stepsBox.get("Thursday");//box.values as int;
    //print("this is ${this._thursdayBox}");
    notifyListeners();
  }

  int get thusdayWalk => _thursdayBox;

  getFridayBox() async{
    //final box = await Hive.openBox("Friday");

    this._fridayBox = stepsBox.get("Friday");//box.values as int;
    notifyListeners();
  }

  int get fridayWalk => _fridayBox;

  getSaturdayBox() async{
    //final box = await Hive.openBox("Saturday");

    this._saturdayBox = stepsBox.get("Saturday");
    notifyListeners();
  }

  int get saturdayWalk => _saturdayBox;

  void onStepCount(event) {
    //print(event.steps);
    //print(Jiffy().day);
    //print(days[0]);
    //pint(_walk);
    //DateTime timeStamp = event.timeStamp;
    if (Jiffy().day == 1) {
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
      stepsBox.put(days[0], event.steps );
      stepsBox.put(days[1], 0);
      stepsBox.put(days[2], 0);
      stepsBox.put(days[3], 0);
      stepsBox.put(days[4], 0);
      stepsBox.put(days[5], 0);
      stepsBox.put(days[6], 0);
      if (sundayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        this._walk = sundayWalk;
        notifyListeners();
      }
      
    } else if (Jiffy().day == 2) {
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
      stepsBox.put(days[1], event.steps);
      stepsBox.put(days[2], 0);
      stepsBox.put(days[3], 0);
      stepsBox.put(days[4], 0);
      stepsBox.put(days[5], 0);
      stepsBox.put(days[6], 0);
      if (mondayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        this._walk = mondayWalk;
        notifyListeners();
      }
    } else if (Jiffy().day == 3){
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
      stepsBox.put(days[2], event.steps);
      stepsBox.put(days[3], 0);
      stepsBox.put(days[4], 0);
      stepsBox.put(days[5], 0);
      stepsBox.put(days[6], 0);
      if (tuesdayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        this._walk = tuesdayWalk;
       
        notifyListeners();
      }
    } else if (Jiffy().day == 4){
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
      stepsBox.put(days[3], event.steps);
      stepsBox.put(days[4], 0);
      stepsBox.put(days[5], 0);
      stepsBox.put(days[6], 0);
      if (wednesdayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        this._walk = wednesdayWalk;
        notifyListeners();
      }
    } else if (Jiffy().day == 5){
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
      stepsBox.put(days[4], event.steps);
      stepsBox.put(days[5], 0);
      stepsBox.put(days[6], 0);
      if (thusdayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        
        this._walk = thusdayWalk;
         //print("walk: ${this._walk}");
        notifyListeners();
      }
    } else if (Jiffy().day == 6) {
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
      print (event.steps);
      
      stepsBox.put(days[5], event.steps);
      stepsBox.put(days[6], 0);
      
      if (fridayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        this._walk = fridayWalk;
        notifyListeners();
      }
    } else if (Jiffy().day == 7) {
      if(Jiffy().utc() == Jiffy().endOf(Units.DAY)){
        cancel();
      }
       print (event.steps);
      stepsBox.put(days[6], event.steps);
      if (saturdayWalk == null) {
        this._walk = 0;
        notifyListeners();
      } else{
        this._walk = saturdayWalk;
        notifyListeners();
      }
    }
    //print("this is the $_walk");

    //this._walk = stepsBox.get(Jiffy().day);
    //this._walk = event.steps;
    
    //Jiffy().day;
    
   
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

  void done() {
    print("just for commits");
  }
  
 
 
  
  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount)
    //.onDone(done);
    
   .onError(onStepCountError);
  
  }

  void cancel(){
    _stepCountStream.listen(onStepCount).cancel();
  }


}


//WalkNotifier walkNotifier;


  