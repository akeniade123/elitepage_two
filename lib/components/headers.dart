import 'package:flutter/material.dart';

class Headers extends StatelessWidget {
  final String headings;
  const Headers({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10),
      alignment: Alignment.bottomLeft,
      child: Text(
        headings,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
