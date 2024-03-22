import '../models/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfLoader extends StatelessWidget {
  const ProfLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: SizedBox(
        height: 52,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: accentclr, borderRadius: BorderRadius.circular(5)),
                  height: 8,
                  width: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  height: 12,
                  width: 80,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  height: 8,
                  width: 60,
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/svg/user1.svg',
            width: 55,
          )
        ]),
      ),
    );
  }
}
