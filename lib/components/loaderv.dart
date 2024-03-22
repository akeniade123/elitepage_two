import 'package:flutter/material.dart';

class LoaderV extends StatelessWidget {
  final List<Widget> vdd;
  const LoaderV({super.key, required this.vdd});

  Column logical() {
    List<Widget> cntt = vdd;
    return Column(
      children: vdd,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        child: Column(
          children: [logical()],
        ),
      ),
    );
  }
}
