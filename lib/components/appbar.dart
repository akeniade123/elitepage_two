import 'package:flutter/material.dart';

import '../models/env.dart';

class AppHead extends StatelessWidget {
  final String headtitle;
  const AppHead({super.key, required this.headtitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: accentclr),
      backgroundColor: bgmainclr,
      title: Text(
        headtitle,
        style: const TextStyle(fontSize: 16, color: accentclr),
      ),
    );
  }
}
