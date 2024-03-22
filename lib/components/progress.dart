import 'package:flutter/material.dart';

class ProgressLevel extends StatefulWidget {
  String prg_message;

  ProgressLevel({super.key, required this.prg_message});

  @override
  State<ProgressLevel> createState() => _ProgressLevelState();
}

class _ProgressLevelState extends State<ProgressLevel> {
  @override
  Widget build(BuildContext context) {
    return Center(
        widthFactor: 80,
        child: Column(
          children: [
            const CircularProgressIndicator(
              color: Colors.grey,
            ),
            Text(widget.prg_message),
          ],
        ));
  }
}
