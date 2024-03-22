import 'package:flutter/material.dart';

class LoaderD extends StatelessWidget {
  final List<Widget> vdd;
  const LoaderD({super.key, required this.vdd});

  Row logical() {
    List<Widget> cntt = vdd;
    return Row(
      children: vdd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 150,
        child: Row(
          children: [logical()],
        ),
      ),
    );
  }
}
