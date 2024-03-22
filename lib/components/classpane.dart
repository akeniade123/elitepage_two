// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import '../Controller/filehandler.dart';
import '../database/database_helper.dart';
import '../database/datafields.dart';
import '../screens/common_widget.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../Controller/fields.dart';
import '../models/global_strings.dart';
import '../screens/procesion.dart';
import '../views/studentView/cbtDisplay.dart';

class ClassPane extends StatefulWidget {
  final String name;
  final String essence;
  // ignore: prefer_typing_uninitialized_variables
  final identifier;
  final String endgoal;
  final String phase;
  final bool active;
  const ClassPane(
      {super.key,
      required this.name,
      required this.essence,
      this.identifier,
      required this.endgoal,
      required this.phase,
      required this.active});

  @override
  State<ClassPane> createState() => _ClassPaneState();
}

// ignore: non_constant_identifier_names
SnackBar DisplaySnackBar(String message) {
  return SnackBar(
    content: Text(message),
  );
}

class _ClassPaneState extends State<ClassPane> {
  @override
  Widget build(BuildContext context) {
    endgoal = widget.endgoal;
    //  phase = widget.phase;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: (widget.active) ? Colors.white : Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 5)),
      ], border: Border.all(), borderRadius: BorderRadius.circular(10)),
      // padding: const EdgeInsets.all(),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      width: double.infinity,
      child: TextButton(
        onPressed: () async {
          Map<String, Object> tag = {};
          sct_var = {};

          Navigator.of(context).pop();
          if (widget.active) {
            switch (widget.essence) {
              case mycl:
                /*

              {
   "Essence":"access",
   "State":"specific_tsk",
   "Specific":"Router",
   "Table":"class_member",
   "Joint":" b INNER JOIN class_particular c on b.class = c.Unique_ID INNER JOIN class_arms m on c.Class_arm = m.Unique_ID INNER JOIN session s on c.Session = s.Session_ID  WHERE b.User_ID = 9025108 AND role = 1 AND c.Session = 3076424 ",
   "Rep":"b.id, c.Class_tag AS Class, m.Class_Name AS Dept, s.Session AS current_session"
}

              */

                Map<String, Object> tgg = {
                  "Essence": "access",
                  "State": "specific_tsk",
                  "Specific": "Router",
                  "Table": "class_member",
                  "Joint":
                      " b INNER JOIN class_particular c on b.class = c.Unique_ID INNER JOIN class_arms m on c.Class_arm = m.Unique_ID INNER JOIN session s on c.Session = s.Session_ID  WHERE b.User_ID = 9025108111 AND role = 1 AND c.Session = 3076424 ",
                  "Rep":
                      "b.id, c.Class_tag AS Class, m.Class_Name AS Dept, s.Session AS current_session"
                };

                Future<List<Widget>>? futureclasses;

                modalPane(mycl, tgg, communal, mycl, mycl, widget.endgoal,
                    server, futureclasses, true, context);

                break;
              case mysb:
                break;
              case sct_e:
                sct_var = {"class": widget.identifier};
                tag = {
                  "Essence": "access",
                  "State": "specific_tsk",
                  "Specific": "getCourses",
                  "Manifest": sct_var
                };
                log("Go search for contents in Market");

                //["EAB700","EAC700","EAM700","EAP700","EAE700","EAG720","UAE700"]

                bdyCourses = ProcessionClassList(
                  tagged: tag,
                  essence: crsTbl,
                  endgoal: '',
                  title: "Subjects",
                  view_: crsTbl,
                  domain: desig,
                  function: server,
                );

                Navigator.of(context).pushNamed(crsLst);
                break;
              case facI:

              /*
              sct_var = {"body": widget.identifier};
                tag = {"Essence": crsTbl, "State": rd_e, "Manifest": sct_var};
                
                Future<List<Widget>>? futureclasses;
                modalPane(sct_ttled, tag, desig, ess, endgoal, server,
                    futureclasses, true, context);
                break;
                */

              case assc:
                sct_var = {"body": widget.identifier};
                tag = {"Essence": crsTbl, "State": rd_e, "Manifest": sct_var};

                bdyCourses = ProcessionClassList(
                  tagged: tag,
                  essence: crsTbl,
                  endgoal: '',
                  title: "Courses",
                  view_: crsTbl,
                  domain: desig,
                  function: server,
                );

                Navigator.of(context).pushNamed(crsLst);
                break;

              case bds:

                /*
                sct_var = {avl: "1", "faculty": widget.identifier};
                tag = {"Essence": bds, "State": rd_e, "Manifest": sct_var};
                */
                tag = {
                  "Essence": "access",
                  "State": "specific_tsk",
                  "Specific": "getFaculty",
                  "Manifest": {"id": widget.identifier}
                };

                String ess = facI; //assc;
                Future<List<Widget>>? futureclasses;
                modalPane(sct_ttled, tag, desig, ess, widget.essence, endgoal,
                    server, futureclasses, true, context);
                break;

              case sct:
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                bool trnzt = true;

                if (widget.identifier == "1") {
                  String ess = "";

                  log("TheCurrent**$phase");

                  switch (widget.phase) {
                    case "1":
                      tag = {
                        "Essence": "class_tag",
                        "State": rd_e,
                        "Manifest": sct_var
                      };
                      ess = sct_e;
                      break;

                    case "2":
                      sct_var = {"tag": widget.name};
                      tag = {
                        "Essence": "access",
                        "State": "specific_tsk",
                        "Specific": "getCourses",
                        "Manifest": sct_var
                      };
                      log("Go search for contents in Market");

                      trnzt = false;

                      //["EAB700","EAC700","EAM700","EAP700","EAE700","EAG720","UAE700"]

                      bdyCourses = ProcessionClassList(
                        tagged: tag,
                        essence: crsTbl,
                        endgoal: '',
                        title: "Subjects",
                        view_: crsTbl,
                        domain: desig,
                        function: server,
                      );

                      Navigator.of(context).pushNamed(crsLst);
                      break;

                    case "3":
                      sct_var = {avl: "1"};
                      tag = {
                        "Essence": "institution",
                        "State": rd_e,
                        "Manifest": sct_var
                      };

                      /*
                      tag = {
                        "Essence": "faculty",
                        "State": rd_e,
                        "Manifest": sct_var
                      };
                      */
                      ess = bds;

                      /*
                              identifier: '',
                              essence: 'tert',
                              endgoal: endgoal,
                              title: sct_ttled,
                              view_: '',
                              name: '',
                              */

                      break;
                  }

                  if (trnzt == true) {
                    Future<List<Widget>>? futureclasses;

                    modalPane(sct_ttled, tag, desig, ess, "", endgoal, server,
                        futureclasses, true, context);
                  }
                }
                break;
              case cCbt:
                Navigator.of(drwdlg).pop();
                switch (widget.identifier) {
                  case repository:
                    DatabaseHelper dbh = DatabaseHelper(table: endgoal);
                    int num = await dbh.queryRowCount();
                    if (num > 0) {
                    } else {
                      customSnackBar(
                          context, "Your repository is currently empty");
                    }
                    break;
                  case open:
                    String rdd = await readFile(endgoal);
                    //  String dcry = await decrypt(rdd, phase);
                    //log("File As String :$rdd");
                    //  log("My Key: $phase: $dcry");

                    Map<String, dynamic> cbbt = jsonDecode(rdd);

                    launchCBT(cbbt, context, true);
                    break;
                  case import:
                    try {
                      //  Navigator.of(dlg!).pop();
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;

                        String text;
                        try {
                          String? pth = result.files.single.path;

                          final File file = File(
                              pth!); //File('${directory.path}/my_file.txt');
                          text = await file.readAsString();
                          log("Positionz a");

                          Map<String, dynamic>? cnnt =
                              await contentConvert(text);
                          List<Map<String, dynamic>> qstnz = cnnt!["Questions"];
                          int crrt = qstnz.length;

                          Map<String, dynamic> flaw = cnnt["Flaws"];
                          int wrng = flaw.length;

                          cbtCog = wrng;

                          log("Positionz b");

                          if (wrng > 0) {
                            final txt = cnnt["comment"];
                            log("${cnnt["comment"]}");
                            try {
                              Widget wdg = SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Format Warnings",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      thickness: 0.1,
                                    ),
                                    Text(txt),
                                    Center(
                                      child: Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                //
                                                //  Navigator.of(context).pop();

                                                Navigator.of(drwdlg).pop();
                                                Navigator.of(basedlg).pop();

                                                launchCBT(cnnt, context, false);
                                                //  dismissDailog();

                                                //  dismissDailog();
                                              },
                                              child: const Text("Ok")),
                                          const SizedBox(width: 35),
                                          const Divider(
                                            color: Colors.black,
                                            thickness: 0.1,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                log("Contentzzz");
                                                dismissDailog();
                                              },
                                              child: const Text("Discard")),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              Future<List<Widget>>? futureclasses;

                              log("Position d");
                              modalPane("title", {}, desig, vww, widget.essence,
                                  endgoal, vww, futureclasses, true, context);
                              // Modal(context, 250, wdg);
                              log("Position e");

                              //  Navigator.of(context).pop();
                            } catch (e) {
                              log("Cast Error***: $e ***");
                            }
                          } else {
                            log("Efficiently Deserialized: $crrt, Flaws: $wrng");
                            String hm = jsonEncode(qstnz);

                            Map<String, dynamic> cnpp = cnnt["Manifest"];
                            String ttl = "Proofread";
                            if (cnpp.isNotEmpty) {
                              ttl = cnpp["subject"];
                            }
                            cbtStack = {ttl: hm};

                            cbtcontent = CBTDisplay(
                              duration: const Duration(hours: 1, minutes: 25),
                              contents: cbtStack,
                              mode: prfMode,
                              cog: wrng,
                            );

                            Navigator.of(drwdlg).pop();
                            //  Navigator.of(basedlg).pop();
                            Navigator.of(context).pushNamed(cbtRoute);
                          }
                          log("Positionz c");
                        } catch (e) {
                          log("Couldn't read file***");
                        }
                        log("${file.size}");
                        //  log(file.extension);
                        //  log(file.path);
                      } else {
                        // User canceled the picker
                      }

                      //
                    } catch (e) {
                      log("File Picker error: $e");
                    }

                    break;
                  case new_:
                    Navigator.of(context).pushNamed(widget.essence);
                    break;
                }
                break;

              case classes:
                sct_var = {};
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                (widget.identifier == "1")
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ClassList(
                              tagged: {
                                "Essence": "class_tag",
                                "State": rd_e,
                                "Manifest": sct_var
                              },
                              domain: desig,
                              name: '',
                              identifier: '',
                              essence: sct_e,
                              endgoal: endgoal,
                              title: 'sct_ttled',
                              view_: clsmgt,
                            )))
                    : Navigator.of(context).pop();

                break;

              case pCbt:
                sct_var = {};
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                (widget.identifier == "1")
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ClassList(
                              tagged: {
                                "Essence": "class_tag",
                                "State": rd_e,
                                "Manifest": sct_var
                              },
                              domain: desig,
                              name: '',
                              identifier: '',
                              essence: sct_e,
                              endgoal: endgoal,
                              title: 'sct_ttled',
                              view_: prtcCbt,
                            )))
                    : Navigator.of(context).pop();

                break;

              case classesv:
                sct_var = {};
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                (widget.identifier == "1")
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ClassList(
                              tagged: {
                                "Essence": "class_tag",
                                "State": rd_e,
                                "Manifest": sct_var
                              },
                              domain: desig,
                              name: '',
                              identifier: '',
                              essence: sct_e,
                              endgoal: endgoal,
                              title: 'sct_ttled',
                              view_: clsvw,
                            )))
                    : Navigator.of(context).pop();

                break;
              case classes4cur:
                sct_var = {};
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                (widget.identifier == "1")
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ClassList(
                              tagged: {
                                "Essence": "class_tag",
                                "State": rd_e,
                                "Manifest": sct_var
                              },
                              name: '',
                              identifier: '',
                              essence: sct_e,
                              endgoal: endgoal,
                              title: 'sct_ttled',
                              view_: crrMgt,
                            )))
                    : Navigator.of(context).pop();

                break;
              case classes4curv:
                sct_var = {};
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                (widget.identifier == "1")
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ClassList(
                              tagged: {
                                "Essence": "class_tag",
                                "State": rd_e,
                                "Manifest": sct_var
                              },
                              domain: desig,
                              name: '',
                              identifier: '',
                              essence: sct_e,
                              endgoal: endgoal,
                              title: 'sct_ttled',
                              view_: crlmVw,
                            )))
                    : Navigator.of(context).pop();

                break;
              case classes4resltv:
                sct_var = {};
                sct_ttled = widget.name;
                sct_var.addEntries({sct: widget.name}.entries);

                String? msg = widget.identifier;

                log(msg!);

                (widget.identifier == "1")
                    ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ClassList(
                              tagged: {
                                "Essence": "class_tag",
                                "State": rd_e,
                                "Manifest": sct_var
                              },
                              domain: desig,
                              name: '',
                              identifier: '',
                              essence: sct_e,
                              endgoal: endgoal,
                              title: 'sct_ttled',
                              view_: clsRslt,
                            )))
                    : Navigator.of(context).pop();

                break;
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: const TextStyle(color: Colors.black),
            ),
            (widget.active)
                ? const Icon(
                    Icons.arrow_right_alt_rounded,
                    color: Colors.black,
                  )
                : const Text("")
          ],
        ),
      ),
    );
  }
}
