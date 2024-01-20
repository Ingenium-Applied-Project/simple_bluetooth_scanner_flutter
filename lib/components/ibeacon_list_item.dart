import 'package:flutter/material.dart';

class IBeaconListItem extends StatelessWidget {
  final String identifier;
  final String distance;
  final String uuid;
  final String contentID;

  IBeaconListItem({
    required this.identifier,
    required this.distance,
    required this.uuid,
    required this.contentID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Identifier:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                identifier,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Distance:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(distance),
            ],
          ),
          Row(
            children: [
              const Text(
                'UUID:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(uuid),
            ],
          ),
          Row(
            children: [
              const Text(
                'ContentID:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(contentID),
            ],
          ),
        ],
      ),
    );
  }
}
