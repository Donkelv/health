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
  

  String _stepCountError;

  List days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  
 //var dateTime = DateTime.now();
  Box<int> stepsBox = Hive.box('steps');
 //List steps = [];
  //Jiffy(dateTime); 

  void onStepCount(event) {
    print(event.steps);
    //print(_walk);
    //DateTime timeStamp = event.timeStamp;
    if (Jiffy().day == 0) {
      stepsBox.put(days[0], event.steps );
    } else if (Jiffy().day == 1) {
      stepsBox.put(days[1], event.steps);
    }
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


  