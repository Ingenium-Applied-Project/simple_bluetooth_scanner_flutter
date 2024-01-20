import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:ibeacon_flutter/model/found_beacon.dart';
import "package:ibeacon_flutter/model/ing_beacon.dart";
import 'package:ibeacon_flutter/utils/util.dart';

// flutter_beacon: https://pub.dev/packages/flutter_beacon
class AppModel extends ChangeNotifier {
  AppModel() {
    // TODO: read existing data from local storage

    // it will only ask for bluetooth permissions
    initBeaconScanning();
  }
  bool _isScanning = false;
  final _beacons = <Beacon>[];

  var sortedBeacons = <FoundBeacon>[];

  var _userBeacons = <IngBeacon>[];
  bool _sorting = false;

  StreamSubscription? _beaconStream = null;

  void saveIBeaconsAndStartScanning(List<IngBeacon> ingBeacons) async {
    _userBeacons.clear();
    _userBeacons.addAll(ingBeacons);

    try {
      if (_beaconStream != null) {
        await _beaconStream?.cancel();
      }
    } catch (e) {
      // do nothing
    }

    initBeaconScanning();
  }

  Future<void> initBeaconScanning() async {
    // Check for permissions and initialize beacon scanning
    print("0");
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

    if (_userBeacons.isEmpty) {
      return;
    }

    final regions = <Region>[];
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

    // regions.add(Region(
    //     identifier: "First",
    //     proximityUUID: "1C60F3FC-E656-474F-82A7-4D2E9483D4F9",
    //     major: 0,
    //     minor: 0));
    // regions.add(Region(identifier: identifier,))
    _isScanning = true;

    print(regions);

    _beaconStream = flutterBeacon.ranging(regions).listen((result) {
      sortBeacons(result.beacons);
    });
  }

  void sortBeacons(List<Beacon> beacons) {
    //this is called from within an async function
    // wait until the current process is done.
    if (_sorting) return;
    _sorting = true;
    _beacons.clear();
    _beacons.addAll(beacons);

    _beacons.sort((a, b) {
      return a.accuracy.compareTo(b.accuracy);
    });

    sortedBeacons.clear();
    for (var beacon in _beacons) {
      sortedBeacons.add(
        FoundBeacon(
          identifier: "No ID",
          uuid: beacon.proximityUUID,
          major: beacon.major.toString(),
          minor: beacon.minor.toString(),
          contentId: "No Content",
          proximity: beacon.accuracy,
        ),
      );
    }

    notifyListeners();

    // print(sortedBeacons.length);

    _sorting = false;
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

  @override
  void dispose() {
    if (_isScanning) {
      try {
        _beaconStream?.cancel();
      } catch (e) {}
      // flutterBeacon.stopRanging();
    }
    super.dispose();
  }
}
