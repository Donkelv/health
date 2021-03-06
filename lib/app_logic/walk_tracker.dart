import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:hive/hive.dart';
import 'package:flutter_android/android_hardware.dart'
    show Sensor, SensorEvent, SensorManager;

final walkProvider = ChangeNotifierProvider((ref) {
  return WalkNotifier();
});

/* Pedometer _pedometer;
StreamSubscription<int> _subscription; */

Stream<StepCount> _stepCountStream;
Stream<PedestrianStatus> _pedestrianStatusStream;

//i dont know how to continue

class WalkNotifier extends ChangeNotifier {
  /* WalkNotifier([this._walk = 0]); */
  int _walk;

  double _heartRate;

  dynamic _status;

  String _pedesError;

  int _sundayBox;

  int _sunday;

  int _mondayBox;

  int _monday;

  int _tuesdayBox;

  int _tuesday;

  int _wednesdayBox;

  int _wednesday;

  int _thursdayBox;

  int _thursday;

  int _fridayBox;

  int _friday;

  int _saturdayBox;

  int _saturday;

  String _stepCountError;

  List days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  //var dateTime = DateTime.now();
  Box<int> stepsBox = Hive.box('steps');

  void heartMonitor() async {
    var sensor = await SensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);
    var sensorSubscribe = await sensor.subscribe();

    sensorSubscribe.listen((SensorEvent event) {
      this._heartRate = event.values[0];
      notifyListeners();
      print(event.values[0]);
    });
  }

  double get heartRate => _heartRate;
  //List steps = [];
  //Jiffy(dateTime);

  getSundayBox() async {
    //final box = await Hive.openBox("Sunday");
    this._sundayBox = stepsBox.get("Sunday");
    // print("Steps from the box ${stepsBox.get('Sunday')}");
    //this._sundayBox = box.values as int;
    notifyListeners();
  }

  int get sundayWalk => _sundayBox;

  getSunday() async {
    this._sunday = stepsBox.get("sundayMain");
    notifyListeners();
  }

  int get sunday => _sunday;

  getMondayBox() async {
    //final box = await Hive.openBox("Monday");

    this._mondayBox = stepsBox.get("Monday");
    notifyListeners();
  }

  int get mondayWalk => _mondayBox;

  getMonday() async {
    this._monday = stepsBox.get("mondayMain");
    notifyListeners();
  }

  int get monday => _monday;

  getTuesdayBox() {
    //final box = await Hive.openBox("Tuesday");

    this._tuesdayBox = stepsBox.get("Tuesday");
    notifyListeners();
  }

  int get tuesdayWalk => _tuesdayBox;

  getTuesday() async {
    this._tuesday = stepsBox.get("tuesdayMain");
    notifyListeners();
  }

  int get tuesday => _tuesday;

  getWednesdayBox() async {
    //final box = await Hive.openBox("Wednesday");

    this._wednesdayBox = stepsBox.get("Wednesday"); //box.values as int;
    notifyListeners();
  }

  int get wednesdayWalk => _wednesdayBox;

  getWednesday() async {
    this._wednesday = stepsBox.get("wednesdayMain");
    notifyListeners();
  }

  int get wednesday => _wednesday;

  getThursdayBox() async {
    //final box = await Hive.openBox("Thursday");

    this._thursdayBox = stepsBox.get("Thursday"); //box.values as int;
    //print("this is ${this._thursdayBox}");
    notifyListeners();
  }

  int get thusdayWalk => _thursdayBox;

  getThursday() async {
    this._thursday = stepsBox.get("thursdayMain");
    notifyListeners();
  }

  int get thursday => _thursday;

  getFridayBox() async {
    //final box = await Hive.openBox("Friday");

    this._fridayBox = stepsBox.get("Friday"); //box.values as int;
    notifyListeners();
  }

  int get fridayWalk => _fridayBox;

  getFriday() async {
    this._friday = stepsBox.get("fridayMain");
    notifyListeners();
  }

  int get friday => _friday;

  getSaturdayBox() async {
    //final box = await Hive.openBox("Saturday");

    this._saturdayBox = stepsBox.get("Saturday");
    notifyListeners();
  }

  int get saturdayWalk => _saturdayBox;

  getSaturday() async {
    this._saturday = stepsBox.get("saturdayMain");
    notifyListeners();
  }

  int get saturday => _saturday;

  void onStepCount(event) {
    if (Jiffy().day == 1) {
      if (event.steps > 0) {
        if (saturday != null) {
          int todaySteps = event.steps - saturday;
          stepsBox.put("sundayMain", event.steps);
          stepsBox.put(days[0], todaySteps);
          stepsBox.put(days[1], 0);
          stepsBox.put(days[2], 0);
          stepsBox.put(days[3], 0);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = sundayWalk;
          notifyListeners();
        } else {
          int todaySteps = event.steps - 0;
          stepsBox.put("sundayMain", event.steps);
          stepsBox.put(days[0], todaySteps);
          stepsBox.put(days[1], 0);
          stepsBox.put(days[2], 0);
          stepsBox.put(days[3], 0);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = sundayWalk;
          notifyListeners();
        }
      } else {
        stepsBox.put(days[0], event.steps);
        stepsBox.put(days[1], 0);
        stepsBox.put(days[2], 0);
        stepsBox.put(days[3], 0);
        stepsBox.put(days[4], 0);
        stepsBox.put(days[5], 0);
        stepsBox.put(days[6], 0);
        if (sundayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = sundayWalk;
          notifyListeners();
        }
      }
    } else if (Jiffy().day == 2) {
      if (event.steps > 0) {
        if (sunday != null) {
          int todaysSteps = event.steps - sunday;
          stepsBox.put("mondayMain", event.steps);
          stepsBox.put(days[1], todaysSteps);
          stepsBox.put(days[2], 0);
          stepsBox.put(days[3], 0);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = mondayWalk;
          notifyListeners();
        } else {
          int todaysSteps = event.steps - 0;
          stepsBox.put("mondayMain", event.steps);
          stepsBox.put(days[1], todaysSteps);
          stepsBox.put(days[2], 0);
          stepsBox.put(days[3], 0);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = mondayWalk;
          notifyListeners();
        }
      } else {
        stepsBox.put(days[1], event.steps);
        stepsBox.put(days[2], 0);
        stepsBox.put(days[3], 0);
        stepsBox.put(days[4], 0);
        stepsBox.put(days[5], 0);
        stepsBox.put(days[6], 0);
        if (mondayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = mondayWalk;
          notifyListeners();
        }
      }
    } else if (Jiffy().day == 3) {
      if (event.steps > 0) {
        if (monday != null) {
          int todaysSteps = event.steps - monday;
          stepsBox.put("tuesdayMain", event.steps);
          stepsBox.put(days[2], todaysSteps);
          stepsBox.put(days[3], 0);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = tuesdayWalk;

          notifyListeners();
        } else {
          int todaysSteps = event.steps - 0;
          stepsBox.put("tuesdayMain", event.steps);
          stepsBox.put(days[2], todaysSteps);
          stepsBox.put(days[3], 0);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = tuesdayWalk;

          notifyListeners();
        }
      } else {
        stepsBox.put(days[2], event.steps);
        stepsBox.put(days[3], 0);
        stepsBox.put(days[4], 0);
        stepsBox.put(days[5], 0);
        stepsBox.put(days[6], 0);
        if (tuesdayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = tuesdayWalk;

          notifyListeners();
        }
      }
    } else if (Jiffy().day == 4) {
      if (event.steps > 0) {
        if (tuesday != null) {
          int todaysSteps = event.steps - tuesday;
          stepsBox.put("wednesdayMain", event.steps);
          stepsBox.put(days[3], todaysSteps);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = wednesdayWalk;
          notifyListeners();
        } else {
          int todaysSteps = event.steps - 0;
          stepsBox.put("wednesdayMain", event.steps);
          stepsBox.put(days[3], todaysSteps);
          stepsBox.put(days[4], 0);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = wednesdayWalk;
          notifyListeners();
        }
      } else {
        stepsBox.put(days[3], event.steps);
        stepsBox.put(days[4], 0);
        stepsBox.put(days[5], 0);
        stepsBox.put(days[6], 0);
        if (wednesdayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = wednesdayWalk;
          notifyListeners();
        }
      }
    } else if (Jiffy().day == 5) {
      if (event.steps > 0) {
        if (wednesday != null) {
          int todaysSteps = event.steps - wednesday;
          stepsBox.put("thursdayMain", event.steps);
          stepsBox.put(days[4], todaysSteps);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = thusdayWalk;
          //print("walk: ${this._walk}");
          notifyListeners();
        } else {
          int todaysSteps = event.steps - 0;
          stepsBox.put("thursdayMain", event.steps);
          stepsBox.put(days[4], todaysSteps);
          stepsBox.put(days[5], 0);
          stepsBox.put(days[6], 0);

          this._walk = thusdayWalk;
          //print("walk: ${this._walk}");
          notifyListeners();
        }
      } else {
        stepsBox.put(days[4], event.steps);
        stepsBox.put(days[5], 0);
        stepsBox.put(days[6], 0);
        if (thusdayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = thusdayWalk;
          //print("walk: ${this._walk}");
          notifyListeners();
        }
      }
    } else if (Jiffy().day == 6) {
      if (event.steps > 0) {
        if (thursday != null) {
          int todaysSteps = event.steps - thursday;
          print(" today $todaysSteps");
          print(event.steps);
          stepsBox.put("fridayMain", event.steps);
          stepsBox.put(days[5], todaysSteps);
          stepsBox.put(days[6], 0);

          this._walk = fridayWalk;
          notifyListeners();
        } else {
          int todaysSteps = event.steps - 0;
          print(" today $todaysSteps");
          print(event.steps);
          stepsBox.put("fridayMain", event.steps);
          stepsBox.put(days[5], todaysSteps);
          stepsBox.put(days[6], 0);

          this._walk = fridayWalk;
          notifyListeners();
        }
      } else {
        print(event.steps);

        stepsBox.put(days[5], event.steps);
        stepsBox.put(days[6], 0);

        if (fridayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = fridayWalk;
          notifyListeners();
        }
      }
    } else if (Jiffy().day == 7) {
      if (event.steps > 0) {
        if (friday != null) {
          int todaysSteps = event.steps - friday;
          print(event.steps);
          stepsBox.put("saturdayMain", event.steps);
          stepsBox.put(days[6], todaysSteps);

          this._walk = saturdayWalk;
          notifyListeners();
        } else {
          int todaysSteps = event.steps - 0;
          print(event.steps);
          stepsBox.put("saturdayMain", event.steps);
          stepsBox.put(days[6], todaysSteps);

          this._walk = saturdayWalk;
          notifyListeners();
        }
      } else {
        print(event.steps);
        stepsBox.put(days[6], event.steps);
        if (saturdayWalk == null) {
          this._walk = 0;
          notifyListeners();
        } else {
          this._walk = saturdayWalk;
          notifyListeners();
        }
      }
    }
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
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void cancel() {
    _stepCountStream.listen(onStepCount).cancel();
  }
}

//WalkNotifier walkNotifier;
