// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import '../Controller/fields.dart';
import '../database/database_helper.dart';
import '../database/datafields.dart';
import '../models/data/user.dart';
import '../screens/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/env.dart';
import '../models/global_strings.dart';

class ProfileButton extends StatefulWidget {
  final String accNm, accPic, accAss;

  const ProfileButton({
    super.key,
    required this.accNm,
    required this.accAss,
    required this.accPic,
    required String dest,
  });

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        DatabaseHelper dbh = DatabaseHelper(table: appDtl);
        if (await dbh.queryRowCount() > 0) {
          List<Map<String, dynamic>> lst = await dbh.queryAllRows();

          Map<String, dynamic> mpp = lst[0];
          ussr_dmn = UserDomain.fromData(mpp);

          Navigator.of(context).pushNamed(probtn);
        } else {
          customSnackBar(
              context, "domain not set yet, kindly check back in few minutes");
        }
      },
      child: SizedBox(
          height: 52,
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome,',
                  style: TextStyle(color: accentclr),
                ),
                Text(
                  widget.accNm,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  widget.accAss,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            profPic != null
                ? Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(
                        File(profPic!.path),
                      ),
                    ),
                  )
                : SvgPicture.asset(
                    'assets/svg/user1.svg',
                    width: 55,
                  )
          ])),
    );
  }
}
