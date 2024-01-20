import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ibeacon_flutter/components/ibeacon_list_item.dart';
import 'package:ibeacon_flutter/model/app_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => Scaffold(
        body: appModel.sortedBeacons.isEmpty
            ? const Center(child: Text("Empty"))
            : ListView.builder(
                itemCount: appModel.sortedBeacons.length,
                itemBuilder: (context, index) {
                  var currentBeacon = appModel.sortedBeacons[index];
                  return IBeaconListItem(
                      identifier: currentBeacon.identifier,
                      distance: currentBeacon.proximity.toString(),
                      uuid: currentBeacon.uuid,
                      contentID: currentBeacon.contentId);
                },
              ),
      ),
    );
  }
}

// ListView.builder(
//                     itemCount: appModel.sortedBeacons.length,
//                     itemBuilder: (context, index) {
//                       var currentBeacon = appModel.sortedBeacons[index];
//                       return IBeaconListItem(
//                           identifier: currentBeacon.identifier,
//                           distance: currentBeacon.proximity.toString(),
//                           uuid: currentBeacon.uuid,
//                           contentID: currentBeacon.contentId);
//                     },
//                   ),

//  appModel.sortedBeacons.isEmpty
//                 ? const Center(child: Text("Emtpy List"))R
                // : 
