import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      color: Colors.cyan,
    );
  }
}
