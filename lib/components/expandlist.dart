// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:image_picker/image_picker.dart';
import 'package:elitepage_two/models/global_strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_background_service/flutter_background_service.dart';

import '../Controller/field.dart';
import '../Controller/fields.dart';
import '../Controller/filehandler.dart';
import '../Controller/sharedpref.dart';
import '../data/video.dart';
import '../database/database_helper.dart';
import '../database/datafields.dart';

import '../screens/common_widget.dart';
import '../views/studentView/cbtDisplay.dart';

class ExpandList extends StatelessWidget {
  final List<String> array;

  // final String list1, list2, list3, list4, list5, list6, list7, list8;
  const ExpandList({super.key, required this.array});

  @override
  Widget build(BuildContext context) {
    Future<List<Widget>>? futureclasses;
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            ListView.builder(
                itemCount: array.length,
                padding: const EdgeInsets.all(8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      array[index],
                      style: const TextStyle(
                          color: Color.fromARGB(255, 6, 43, 73)),
                    ),
                    onTap: () async {
                      switch (array[index]) {
                        case crtSct:
                        case crtSct_1:
                          Map<String, Object> tag = const {
                            "Essence": "Section",
                            "State": "read",
                          };
                          modalPane(
                              array[index],
                              tag,
                              desig,
                              sct,
                              "",
                              array[index],
                              server,
                              futureclasses,
                              false,
                              context);
                          break;
                        case crSess:
                        case crSess_1:
                          Map<String, Object> tag = const {
                            "Essence": "Session",
                            "State": "read",
                          };
                          modalPane(
                              array[index],
                              tag,
                              desig,
                              sct,
                              "",
                              array[index],
                              server,
                              futureclasses,
                              false,
                              context);
                          break;
                        case crSems:
                        case crSems_1:
                          Map<String, Object> tag = const {
                            "Essence": "term",
                            "State": "read",
                          };
                          modalPane(
                              array[index],
                              tag,
                              desig,
                              sct,
                              "",
                              array[index],
                              server,
                              futureclasses,
                              false,
                              context);
                          break;

                        case getfilepath:
                          break;

                        case encrypt_:
                          String key = await generateKey();
                          log("Key:$key");
                          String encr =
                              await encrypt("Akeni Adeyinka David", key);

                          log("Encrypt: $encr");

                          //  String dcry = await decrypt(encr, key);

                          //  log("Decrypted: $dcry");

                          break;

                        case decrypt_:
                          break;

                        case dirExist:
                          String dst = await getfilePath("testing");
                          if (await dirExists(dst)) {
                            log("Directory Exists");
                          } else {
                            log("Directory does not exist...");
                          }
                          break;
                        case crtDir:
                          String dst = await getfilePath("testing");

                          if (await createDir(dst)) {
                            log("Directory Created");
                          } else {
                            log("Directory Not Created");
                          }
                          break;
                        case listfiles:
                          try {
                            String pth = await getfilePath("contents");
                            log("Path: $pth");
                            final directory =
                                await getApplicationDocumentsDirectory(); // Directory(pth);
                            List fll = await listofFiles(directory);

                            log("Size: ${fll.length}");

                            for (int i = 0; i < fll.length; i++) {
                              try {
                                String str = fll[i]
                                    .toString()
                                    .replaceAll("Directory: ", "")
                                    .replaceAll("File: ", "")
                                    .replaceAll("'", "");

                                String size = await getFileSize(str, 1);
                                log("File Details: $str***$size");
                              } catch (e) {
                                log("SizeError: $e");
                              }
                            }
                          } catch (e) {
                            log("error: $e");
                          }
                          break;
                        case readfile:
                          int pp = await readCounter();
                          log('FileContent: $pp');
                          break;
                        case crfile:
                          break;

                        case unzipDir:
                          try {
                            String src = await getfilePath("test.zip");
                            String dst = await getfilePath("testing");
                            log("$src***$dst");
                            await unZip(src, dst);
                            // await extractZip(src, dst);
                            log("File Unzipped");
                          } catch (e) {
                            log("UnzipError: $e");
                          }
                          break;

                        case zipDir:
                          try {
                            String? selectedDirectory =
                                await FilePicker.platform.getDirectoryPath();

                            if (selectedDirectory != null) {
                              String fll = await getfilePath("test.zip");

                              await zipDirectory(selectedDirectory, fll);
                              log("Zip: Logged");

                              //  await File('$selectedDirectory/counter.txt');

/*
                              Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}
*/
                            } else {
                              log("Zip:User canceled the picker");
                              // User canceled the picker
                            }
                          } catch (e) {
                            log("Zip:File Picker error: $e");
                          }
                          break;
                        case mycnt:
                          DatabaseHelper dbh = DatabaseHelper(table: ttcnt);
                          List<Map<String, dynamic>> dd =
                              await dbh.queryAllRows();
                          for (int i = 0; i < dd.length; i++) {
                            Map<String, dynamic> cln = dd[i];
                          }
                          break;
                        case prfMode:
                          //  Navigator.of(context).pushNamed(texTest);

                          try {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              log("Zeroth");

                              String text;
                              try {
                                String? pth = result.files.single.path;

                                final File file = File(
                                    pth!); //File('${directory.path}/my_file.txt');
                                text = await file.readAsString();
                                String? text_ = await scoopLatex(text,
                                    context); // await scoopGPT(text, context);

                                cbtStack = {"ProofRead": text_!};

                                cbtCog = 0;

                                log("First");

                                cbtcontent = CBTDisplay(
                                    duration:
                                        const Duration(hours: 1, minutes: 25),
                                    contents: cbtStack,
                                    mode: prfMode,
                                    cog: cbtCog);

                                Navigator.of(context).pushNamed(cbtRoute);

                                log("Second");
                              } catch (e) {
                                log("Couldn't read file at the moment*** ");
                              }
                              log("${file.size}");
                              //  log(file.extension);
                              //  log(file.path);
                            } else {
                              // User canceled the picker
                            }
                          } catch (e) {
                            log("File Picker error: $e");
                          }

                          break;
                        case srlz:
                          try {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              String text;
                              try {
                                /*
                  final Directory directory =
                      await getApplicationDocumentsDirectory();

                  */
                                String? pth = result.files.single.path;

                                final File file = File(
                                    pth!); //File('${directory.path}/my_file.txt');
                                text = await file.readAsString();
                                log("Content: $text");

                                Map<String, dynamic>? cnnt =
                                    await contentConvert(text);
                                List<Map<String, dynamic>> qstnz =
                                    cnnt!["Questions"];
                                int crrt = qstnz.length;

                                Map<String, dynamic> flaw = cnnt["Flaws"];
                                int wrng = flaw.length;

                                if (wrng > 0) {
                                  final txt = cnnt["comment"];
                                  log("${cnnt["comment"]}");
                                  try {
                                    Widget wdg = Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Html(
                                          data: txt,
                                        ),
                                        const Text(
                                          'You have pushed the button this many times:',
                                        ),
                                      ],
                                    ));

                                    cbtCog = wrng;

                                    wdg = SingleChildScrollView(
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
                                                      Navigator.of(context)
                                                          .pop();

                                                      Navigator.of(drwdlg)
                                                          .pop();

                                                      launchCBT(
                                                          cnnt, context, false);
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
                                                    child:
                                                        const Text("Discard")),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                    Modal(context, 250, wdg);

                                    //  Navigator.of(context).pop();
                                  } catch (e) {
                                    log("Cast Error: $e ");
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
                                    duration:
                                        const Duration(hours: 1, minutes: 25),
                                    contents: cbtStack,
                                    mode: prfMode,
                                    cog: wrng,
                                  );

                                  Navigator.of(context).pushNamed(cbtRoute);
                                }
                              } catch (e) {
                                log("Couldn't read file***");
                              }
                              log("${file.size}");
                              //  log(file.extension);
                              //  log(file.path);
                            } else {
                              // User canceled the picker
                            }
                          } catch (e) {
                            log("File Picker error: $e");
                          }
                          break;
                        case ldbd:
                          try {
                            String text = await loadAssetString(
                                "assets/content/latex.txt");
                            await scoopLatex(text, context);

                            /*
                            String text = await loadAssetString(
                                "assets/content/measurements_units.txt");

                            String? dtt = await scoopGPT(text, context);

                            cbtStack = {"Physics": jsonEncode(dtt)};

                            cbtcontent = CBTDisplay(
                                duration: const Duration(hours: 1, minutes: 0),
                                contents: cbtStack,
                                mode: prfMode,
                                cog: 0);

                            Navigator.of(context).pushNamed(cbtRoute);

*/

                            /*
                            String subject = "English Language";
                            String url =
                                "https://myschool.ng/classroom/english-language?exam_type=jamb&exam_year=&type=&topic=&novel=";
                            //   getQuestionSize(context);

                            //collateJambSciences(context, "Physics", url);

                            collateJambEnglish(
                                context, "English Language", url);

                                */

/*
                            getContent(context, "mathematics", "jamb",
                                "Application of Integration");
*/
                            /*

                                String txt = await loadAssetString(
                                    "assets/content/scoop_1.txt");

                                await scoop(txt, context);

                            */
                          } catch (e) {
                            logger("The Error $e");
                          }

                          /*
                          String pth = "contents/robotics";
                          pth = "contents/biology";

                          String fll = "sevensegment_display.pdf";
                          fll = "livingorganisms.pdf";

                          if (await fileExists("$pth/$fll")) {
                            logger("File Exists...");
                            fileSize("$pth/$fll");
                          } else {
                            logger("File does not exist");
                          }

                          serverPrelim(context, pth, fll, "$pth/$fll");

                          // downloadFile(context, "$pth/$fll", pth, fll);
                          */
                          break;
                        case bbst:
                          /*
                          NotificationController.createNewNotification(
                              "Testing Feature", "Awesome!!!");
                              */

                          SharedPref pref = SharedPref();
                          String? bbs = await pref.getPrefString(bbst);

                          String bbsy =
                              "Best Brain holds three times weekly with great prices being won";

                          if (bbs != null) {
                            logger(bbs);
                            Map<String, dynamic> bbm = jsonDecode(bbs);

                            String bbsy = bbm["link"];

                            curr_vid = VideoModel(
                                link: bbsy,
                                name: bbm["episode"],
                                note: bbm[ttl],
                                access: bbm["header"],
                                topic: bbm["test_id"],
                                id: bbm["Content"],
                                material: "UTME",
                                essence: bbst);

                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(nowplaying);

                            //  Navigate().LearnTransit(context);
                          } else {
                            Navigator.of(context).pop();
                            customSnackBar(
                                context, "Best brain contests holds triweekly");
                          }

                          break;
                        case dgnt:
                          Navigator.of(context).pop();
                          customSnackBar(
                              context, "Digital Notes are yet to be stacked");

                          /*
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(chan);
                          setState(() {});
                          */
                          break;
                        case fgrnd:
                          FlutterBackgroundService().invoke("setAsForeground");
                          break;
                        case bkrnd:
                          FlutterBackgroundService().invoke("setAsBackground");
                          break;
                        case islt:
                          break;

                        case crlm:
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(sCurriculum);
                          setState(() {});
                          break;
                      }
                    },
                  );
                })
          ],
        ));
  }

  void setState(Null Function() param0) {}
}
