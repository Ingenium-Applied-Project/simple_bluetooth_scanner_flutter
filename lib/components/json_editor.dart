import 'package:flutter/material.dart';

class JsonEditorWidget extends StatefulWidget {
  final Function(String) onJsonChanged;

  JsonEditorWidget({super.key, required this.onJsonChanged});

  @override
  _JsonEditorWidgetState createState() => _JsonEditorWidgetState();
}

class _JsonEditorWidgetState extends State<JsonEditorWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onJsonChanged(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: 8, // Allows multiple lines
      keyboardType: TextInputType.multiline,
      style: const TextStyle(
        fontFamily: 'RobotoMono', // Use your monospace font
        fontSize: 12.0,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter JSON code here',
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
