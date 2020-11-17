import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';





 final walkProvider = ChangeNotifierProvider((ref){
   return WalkNotifier();
 });

  Stream<StepCount> _stepCountStream;
 Stream<PedestrianStatus> _pedestrianStatusStream;


class WalkNotifier extends ChangeNotifier{
  /* WalkNotifier([this._walk = 0]); */
  int _walk;
  

  dynamic _status;
  

  String _pedesError;
  

  String _stepCountError;
  

  void onStepCount(event) {
    print(event.steps);
    //print(_walk);
    //DateTime timeStamp = event.timeStamp;
    this._walk = event.steps;
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

  

}




//WalkNotifier walkNotifier;


  