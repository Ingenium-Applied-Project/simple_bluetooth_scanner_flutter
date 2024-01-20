import 'package:flutter/material.dart';

// Custom Widget
class IBeaconCard extends StatefulWidget {
  final TextEditingController identifierController;
  final TextEditingController uuidController;
  final TextEditingController majorController;
  final TextEditingController minorController;
  final TextEditingController contentController;

  const IBeaconCard({
    super.key,
    required this.identifierController,
    required this.uuidController,
    required this.majorController,
    required this.minorController,
    required this.contentController,
  });

  @override
  _IBeaconCardState createState() => _IBeaconCardState();
}

class _IBeaconCardState extends State<IBeaconCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.cyan.shade100),
      child: Column(
        children: <Widget>[
          TextField(
            controller: widget.identifierController,
            decoration: const InputDecoration(labelText: 'Identifier'),
          ),
          TextField(
            controller: widget.uuidController,
            decoration: const InputDecoration(labelText: 'UUID'),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: widget.majorController,
                  decoration: const InputDecoration(labelText: 'Major'),
                ),
              ),
              const SizedBox(width: 10), // spacing
              Expanded(
                child: TextField(
                  controller: widget.minorController,
                  decoration: const InputDecoration(labelText: 'Minor'),
                ),
              ),
            ],
          ),
          TextField(
            controller: widget.contentController,
            decoration: const InputDecoration(labelText: 'Content Id'),
          ),
        ],
      ),
    );
  }
}
