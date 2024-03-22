import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../controller/fields.dart';

class DrawerSection extends StatefulWidget {
  DrawerSection({Key? key}) : super(key: drKey);

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

final GlobalKey<_DrawerSectionState> drKey = GlobalKey();

class _DrawerSectionState extends State<DrawerSection> {
  bool usrr = false;

  Future<void> drwSect() async {
    setState(() {
      usrr = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ussr_.Unique_ID.isNotEmpty) {
      switch (ussr_.Category) {
        case "2":
          return (!usrr)
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('');
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset('assets/svg/todo1.svg',
                                  height: 32,
                                  color: const Color.fromARGB(255, 6, 43, 73))),
                          const Text(
                            "Result collation",
                            style: TextStyle(
                                color: Color.fromARGB(255, 6, 43, 73)),
                          ),
                        ],
                      )),
                );
      }
    }
    return Container();
  }
}

Future<void> usrUpdate() async {
  try {
    await drKey.currentState!.drwSect();
  } catch (e) {
    log("$e");
  }
}
