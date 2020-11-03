import 'package:flutter/material.dart';
import 'package:health/home.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';

class AuthRoute extends StatefulWidget {
  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '...';
  String _steps = '...';
  String _dateTime = "...";
  String backImage = "assets/background.png";

  void onStepCount(StepCount event) {
    print(event);
    DateTime timeStamp = event.timeStamp;
    setState(() {
      _steps = event.steps.toString();
      _dateTime = timeStamp.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    //DateTime timeStamp = event.timeStamp;
    setState(() {
      _status = event.status.toString();
    });
  }

  void onPedestrianStatusError(error) {
    print("pedestrian status error: $error");
    setState(() {
      _status = 'Pedestrian Status Not Available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print("step count error $error");
    setState(() {
      _steps = "Unable To Count Your Steps";
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(backImage),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Home(steps: _steps, dateTime: _dateTime),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
