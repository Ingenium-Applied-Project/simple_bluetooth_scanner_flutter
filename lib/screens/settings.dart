import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibeacon_flutter/components/ibeacon_card.dart';
import 'package:ibeacon_flutter/model/app_model.dart';
import 'package:ibeacon_flutter/model/ing_beacon.dart';

import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final identifierController1 = TextEditingController();
  final uuidController1 = TextEditingController();
  final majorController1 = TextEditingController();
  final minorController1 = TextEditingController();
  final contentController1 = TextEditingController();

  final identifierController2 = TextEditingController();
  final uuidController2 = TextEditingController();
  final majorController2 = TextEditingController();
  final minorController2 = TextEditingController();
  final contentController2 = TextEditingController();

  final identifierController3 = TextEditingController();
  final uuidController3 = TextEditingController();
  final majorController3 = TextEditingController();
  final minorController3 = TextEditingController();
  final contentController3 = TextEditingController();

  final identifierController4 = TextEditingController();
  final uuidController4 = TextEditingController();
  final majorController4 = TextEditingController();
  final minorController4 = TextEditingController();
  final contentController4 = TextEditingController();

  final identifierController5 = TextEditingController();
  final uuidController5 = TextEditingController();
  final majorController5 = TextEditingController();
  final minorController5 = TextEditingController();
  final contentController5 = TextEditingController();

  void populateIngeniumValues() {
    identifierController1.text = "Ingenium #1";
    uuidController1.text = "f7826da6-4fa2-4e98-8024-bc5b71e0893e";
    majorController1.text = "2657";
    minorController1.text = "31308";

    identifierController2.text = "Ingenium #2";
    uuidController2.text = "f7826da6-4fa2-4e98-8024-bc5b71e0893e";
    majorController2.text = "31463";
    minorController2.text = "59526";

    identifierController3.text = "Ingenium #3";
    uuidController3.text = "f7826da6-4fa2-4e98-8024-bc5b71e0893e";
    majorController3.text = "34925";
    minorController3.text = "36456";
  }

  void populateMyBeaconValues() {
    identifierController1.text = "My IBeacon #1";
    uuidController1.text = "1C60F3FC-E656-474F-82A7-4D2E9483D4F9";
    majorController1.text = "";
    minorController1.text = "";
    // contentController1.text = "";

    identifierController2.text = "My IBeacon #2";
    uuidController2.text = "";
    majorController2.text = "";
    minorController2.text = "";
    // contentController2.text = "";

    identifierController3.text = "My IBeacon #3";
    uuidController3.text = "";
    majorController3.text = "";
    minorController3.text = "";
    // contentController3.text = "";
  }

  void saveValuesAndStartScanning(AppModel appModel) {
    // print(appModel);

    var beacons = <IngBeacon>[];
    IngBeacon? newBeacon = null;

    if (uuidController1.text.isNotEmpty) {
      newBeacon = IngBeacon(
          identifier: identifierController1.text,
          uuid: uuidController1.text,
          major: majorController1.text,
          minor: minorController1.text,
          contentId: contentController1.text);
      beacons.add(newBeacon);
    }

    if (uuidController2.text.isNotEmpty) {
      newBeacon = IngBeacon(
          identifier: identifierController2.text,
          uuid: uuidController2.text,
          major: majorController2.text,
          minor: minorController2.text,
          contentId: contentController2.text);
      beacons.add(newBeacon);
    }

    if (uuidController3.text.isNotEmpty) {
      newBeacon = IngBeacon(
          identifier: identifierController3.text,
          uuid: uuidController3.text,
          major: majorController3.text,
          minor: minorController3.text,
          contentId: contentController3.text);
      beacons.add(newBeacon);
    }

    if (uuidController4.text.isNotEmpty) {
      newBeacon = IngBeacon(
          identifier: identifierController4.text,
          uuid: uuidController4.text,
          major: majorController4.text,
          minor: minorController4.text,
          contentId: contentController4.text);
      beacons.add(newBeacon);
    }

    if (uuidController5.text.isNotEmpty) {
      newBeacon = IngBeacon(
          identifier: identifierController5.text,
          uuid: uuidController5.text,
          major: majorController5.text,
          minor: minorController5.text,
          contentId: contentController5.text);
      beacons.add(newBeacon);
    }

    appModel.saveIBeaconsAndStartScanning(beacons);
  }

  void handleCancelScanner(AppModel appModel) {
    appModel.cancelScanner();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: populateIngeniumValues,
                    child: const Text("Populate with Ingenium Values"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: populateMyBeaconValues,
                    child: const Text("Populate with my UUID Values"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () => {saveValuesAndStartScanning(appModel)},
              child: const Text("Save IBeacons and Start Scanning"),
            ),
            ElevatedButton(
              onPressed: () => {handleCancelScanner(appModel)},
              child: const Text("Stop Scanning"),
            ),
            IBeaconCard(
              identifierController: identifierController1,
              uuidController: uuidController1,
              majorController: majorController1,
              minorController: minorController1,
              contentController: contentController1,
            ),
            const SizedBox(
              height: 40,
            ),
            IBeaconCard(
              identifierController: identifierController2,
              uuidController: uuidController2,
              majorController: majorController2,
              minorController: minorController2,
              contentController: contentController2,
            ),
            const SizedBox(
              height: 40,
            ),
            IBeaconCard(
              identifierController: identifierController3,
              uuidController: uuidController3,
              majorController: majorController3,
              minorController: minorController3,
              contentController: contentController3,
            ),
            const SizedBox(
              height: 40,
            ),
            IBeaconCard(
              identifierController: identifierController4,
              uuidController: uuidController4,
              majorController: majorController4,
              minorController: minorController4,
              contentController: contentController4,
            ),
            const SizedBox(
              height: 40,
            ),
            IBeaconCard(
              identifierController: identifierController5,
              uuidController: uuidController5,
              majorController: majorController5,
              minorController: minorController5,
              contentController: contentController5,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    identifierController1.dispose();
    uuidController1.dispose();
    majorController1.dispose();
    minorController1.dispose();
    contentController1.dispose();

    identifierController2.dispose();
    uuidController2.dispose();
    majorController2.dispose();
    minorController2.dispose();
    contentController2.dispose();

    identifierController3.dispose();
    uuidController3.dispose();
    majorController3.dispose();
    minorController3.dispose();
    contentController3.dispose();

    identifierController4.dispose();
    uuidController4.dispose();
    majorController4.dispose();
    minorController4.dispose();
    contentController4.dispose();

    identifierController5.dispose();
    uuidController5.dispose();
    majorController5.dispose();
    minorController5.dispose();
    contentController5.dispose();
    super.dispose();
  }
}
