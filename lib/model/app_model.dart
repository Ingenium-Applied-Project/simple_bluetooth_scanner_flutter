import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:ibeacon_flutter/model/found_beacon.dart';
import "package:ibeacon_flutter/model/ing_beacon.dart";
import 'package:ibeacon_flutter/utils/util.dart';

// flutter_beacon: https://pub.dev/packages/flutter_beacon

// Class definition extending ChangeNotifier to provide reactive state management
class AppModel extends ChangeNotifier {
  AppModel() {
    // Constructor initializes beacon scanning and a periodic task

    // TODO: read existing data from local storage

    initBeaconScanning(); // Initializes beacon scanning
    startPeriodicTask(); // a periodic task to remove disappeared beacons
  }

  // Nullable Timer to handle periodic tasks
  Timer? periodicTimer;

  // This array is consumed by the main screen and displays it as a list.
  var sortedBeacons = <FoundBeacon>[];

  // This stores the list of beacons entered by the user.
  final _userBeacons = <FoundBeacon>[];

  // Nullable StreamSubscription for beacon events
  StreamSubscription? _beaconStream = null;

  void startPeriodicTask() {
    periodicTimer =
        Timer.periodic(Duration(seconds: 10), (Timer t) => periodicTask());
  }

  // This task scans existing beacons displayed on the screen.
  // Any beacons that hasn't been detected the last 10 seconds are removed from the list.
  void periodicTask() {
    var newList = filterBeacons(_userBeacons);
    sortedBeacons.clear();
    sortedBeacons.addAll(newList);
    notifyListeners();
  }

  List<FoundBeacon> filterBeacons(List<FoundBeacon>? beacons) {
    if (beacons == null) {
      return [];
    }

    DateTime tenSecondsAgo =
        DateTime.now().subtract(const Duration(seconds: 10));
    var newList = beacons
        .where((element) =>
            element.lastFoundTime == null ||
            element.lastFoundTime!.isAfter(tenSecondsAgo))
        .toList();

    return newList;
  }

  // Method to stop the periodic task (onDispose)
  void stopPeriodicTask() {
    periodicTimer?.cancel();
  }

  // Method to save and start scanning iBeacons based on user input
  // This method updates the values on _userBeacons array (such as proximity).
  // _userBeacons array is updated and sorted, and a copy of it is displayed on the screen
  void saveIBeaconsAndStartScanning(List<IngBeacon> ingBeacons) async {
    // Build the _userBeacons array from user input
    DateTime twentySecondsAgo =
        DateTime.now().subtract(const Duration(seconds: 20));
    _userBeacons.clear();
    for (var beacon in ingBeacons) {
      _userBeacons.add(FoundBeacon(
          identifier: beacon.identifier,
          uuid: beacon.uuid,
          major: beacon.major,
          minor: beacon.minor,
          contentId: beacon.contentId,
          proximity: 0,
          lastFoundTime: twentySecondsAgo));
    }

    // stop the existing scan process (if it is already working)
    try {
      if (_beaconStream != null) {
        await _beaconStream?.cancel();
      }
    } catch (e) {
      // do nothing
    }

    //initialize or re-initialize the scanning process
    initBeaconScanning();
  }

  Future<void> initBeaconScanning() async {
    try {
      // if you want to manage manual checking about the required permissions
      await flutterBeacon.initializeScanning;
      // or if you want to include automatic checking permission
      // await flutterBeacon.initializeAndCheckScanning;
    } on PlatformException catch (e) {
      // library failed to initialize, check code and message
      if (kDebugMode) {
        print(e);
      }
      return;
    }

    //if the user hasn't entered any iBeacon info, exit!
    if (_userBeacons.isEmpty) {
      return;
    }

    // The bluetooth scanner needs an array of regions.
    // Each region is basically an iBeacon
    List<Region> regions = [];
    for (var i = 0; i < _userBeacons.length; i++) {
      var beacon = _userBeacons[i];
      var identifier =
          beacon.identifier.isNotEmpty ? beacon.identifier : "Beacon#${i + 1}";

      var region = Region(
        identifier: identifier,
        proximityUUID: beacon.uuid,
        major: parseMajorMinorValue(beacon.major),
        minor: parseMajorMinorValue(beacon.minor),
      );

      regions.add(region); // Add the created Region object to the list
    }

    // start scanning and call addBeacon function for every found beacon
    if (regions.isNotEmpty) {
      _beaconStream = flutterBeacon.ranging(regions).listen((result) {
        if (result.beacons.isNotEmpty) {
          if (kDebugMode) {}

          // This is ideally an array with 1 element.
          for (var beaconVar in result.beacons) {
            addBeacon(beaconVar);
          }
        }
      });
    } else {}
  }

  // Method to update the beacon list
  void addBeacon(Beacon foundBeacon) {
    var indexOfExistingElement = _userBeacons.indexWhere((element) =>
        element.uuid.toLowerCase().trim() ==
            foundBeacon.proximityUUID.toLowerCase().trim() &&
        parseMajorMinorValue(element.major) == foundBeacon.major &&
        parseMajorMinorValue(element.minor) == foundBeacon.minor);

    if (indexOfExistingElement == -1) {
      // This should not happen at all because we are scanning the network based on _userBeacons
      return;
    } else {
      _userBeacons[indexOfExistingElement].proximity = foundBeacon.accuracy;
      _userBeacons[indexOfExistingElement].lastFoundTime = DateTime.now();
      // print("updated!");
    }

    // sort existing master data by proximity
    _userBeacons.sort((a, b) {
      return a.proximity.compareTo(b.proximity);
    });

    sortedBeacons.clear();
    sortedBeacons.addAll(filterBeacons(_userBeacons));

    notifyListeners();
  }

  void cancelScanner() async {
    try {
      if (_beaconStream != null) {
        if (kDebugMode) {
          print("Cancelling the scanner...");
        }
        await _beaconStream?.cancel();
        sortedBeacons.clear();

        if (kDebugMode) {
          print("Scanner cancelled...");
        }
      } else {
        if (kDebugMode) {
          print("Scanner wasn't running");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception when stopping the scanner");
        print(e);
      }
    }
  }

  void stopScanning() {
    try {
      _beaconStream?.cancel();
    } catch (e) {}
  }

  @override
  void dispose() {
    stopPeriodicTask();
    stopScanning();

    super.dispose();
  }
}
