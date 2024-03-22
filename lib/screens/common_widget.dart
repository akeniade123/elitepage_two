// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onscreen_num_keyboard/onscreen_num_keyboard.dart';

import '../Components/appbar.dart';
import '../Components/classpane.dart';
import '../Components/headers.dart';
import '../Controller/elitebasis.dart';
import '../Controller/field.dart';
import '../Controller/fields.dart';
import '../Controller/filehandler.dart';
import '../Controller/navigation.dart';
import '../Controller/sharedpref.dart';
import '../database/database_helper.dart';
import '../database/datafields.dart';
import '../models/endpoints.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';
import '../views/dashboardlayout.dart';
import '../views/nowPlaying.dart';
import '../views/studentView/todo_list.dart';
import '../views/videos.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Squire extends StatefulWidget {
  final num? height;
  final num? width;
  final Widget? child;
  const Squire({super.key, this.height, this.width, this.child});

  @override
  State<Squire> createState() => _SquireState();
}

class _SquireState extends State<Squire> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: (widget.height?.toDouble() ?? 50.0),
        width: (widget.width?.toDouble() ?? double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: List.filled(
            4,
            BoxShadow(
                blurRadius: 1,
                offset: Offset(2, 2),
                color: Colors.black.withAlpha(20)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: widget.child,
        ),
      ),
    );
  }
}

class OnBoardingBackground extends StatelessWidget {
  Widget? child;
  OnBoardingBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(top: 0, left: 0, child: Image.asset('assets/logo.png')),
        Center(
          child: child ?? const Placeholder(),
        ),
      ]),
    );
  }
}

void customSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(DisplaySnackBar(message));
}

Container dropDown(final items, String initial) {
  //final items = ['One', 'Two', 'Three', 'Four'];
  // String selectedValue = 'Four';
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),

      // dropdown below..
      child: DropdownButton<String>(
        value: initial,

        onChanged: (String? value) {
          slctItem = value!;
        },

        /*
        onChanged: (String newValue) =>
            setState(() => selectedValue = newValue),
            */

        items: items
            .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
            .toList(),

        // add extra sugar..
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 42,
        underline: SizedBox(),
      ));
}

class BigButton extends StatelessWidget {
  final lcname, lcn;
  const BigButton({super.key, this.lcname, this.lcn});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // customSnackBar(context, "Contents are not yet stacked");
        switch (lcn) {
          case "lcn":
            break;

          case fac:
            Map<String, Object> tag = {"Essence": "faculty", "State": "read"};

            Future<List<Widget>>? futureclasses;

            modalPane("faculty", tag, desig, "essence", lcn, endgoal, server,
                futureclasses, true, context);
            break;

          default:
            switch (lcn) {
              case lectrr:
                myContents = Videos(
                  essence: videos,
                  data: {
                    "Essence": "course_content",
                    "State": "read_expl",
                    "Manifest": {"Unique_ID": ussr_.Unique_ID}
                  },
                  title: '',
                  exec: adlct,
                  fltclr: bgmainclr,
                );
                break;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(lcn);
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5,
                  blurStyle: BlurStyle.normal,
                  color: Color.fromARGB(99, 158, 158, 158),
                  offset: Offset(0, 2),
                  spreadRadius: 2)
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(lcname),
            Icon(
              Icons.arrow_circle_right,
              color: bgmainclr,
            )
          ],
        ),
      ),
    );
  }
}

class Course extends StatelessWidget {
  final String id, content;

  const Course({super.key, required this.id, required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sct_var = {"tag": content};

        Map<String, Object> tag = {
          "Essence": "topic",
          "State": rd_e,
          "Manifest": sct_var
        };

        Future<List<Widget>>? futureclasses;

        modalPane("Loading Contentz", tag, desig, tpd, "", '', server,
            futureclasses, true, context);

        /*

        crsContents = ProcessionClassList(
          tagged: tag,
          essence: tpd,
          endgoal: '',
          title: "Channels",
          view_: crsCnt,
          domain: desig,
          function: server,
        );
        // Navigator.of(context).pushNamed(cntLst);

        */
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 15, 15, 0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 1))
                        ]),
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Html(
                        data: content,
                      ),
                    )),
              ),
            ],

            /*
              child: Html(
                  data: """
                  <div>Follow<a class='sup'><sup>pl</sup></a> 
                    Below hr
                      <b>Bold</b>
                  <h1>what was sent down to you from your Lord</h1>, 
                  and do not follow other guardians apart from Him. Little do 
                  <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                  """,
                )
      
            */
          )
        ],
      ),
    );
  }
}

class LearnMore extends StatelessWidget {
  final String heading, image, click, faqQst, faqAns;
  const LearnMore(
      {super.key,
      required this.heading,
      required this.image,
      required this.click,
      required this.faqQst,
      required this.faqAns});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: AppHead(headtitle: heading)),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: More(
                image: image, click: click, faqQst: faqQst, faqAns: faqAns)));
  }
}

class More extends StatelessWidget {
  final String image, click, faqQst, faqAns;
  const More(
      {super.key,
      required this.image,
      required this.click,
      required this.faqQst,
      required this.faqAns});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,

            // width: double.infinity,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, top: 30),
            child: Text(
              faqQst,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 20), child: Text(faqAns)),
          TextButton(
              onPressed: () {
                launch('whatsapp://send?phone=234.text+8132547993.text');
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      'assets/svg/whatsapp.svg',
                      width: 20,
                    ),
                  ),
                  const Text(
                    'Send us a DM',
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class Explicit extends StatelessWidget {
  final List content;
  const Explicit({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class ContentUnit extends StatelessWidget {
  final String tagged, endgoal;
  final List<Widget> expp;

  const ContentUnit(
      {super.key,
      required this.tagged,
      required this.endgoal,
      required this.expp});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        sct_var = {"tag": tagged};

        Map<String, Object> tag = {
          "Essence": "topic",
          "State": rd_e,
          "Manifest": sct_var
        };

        Future<List<Widget>>? futureclasses;

        bool crsChk = false;

        /*

        modalPane("Loading Content", tag, desig, tpd, "", '', server,
            futureclasses, true, context);

            */

        switch (endgoal) {
          case bbst:
            break;
          case prfMode:
            /*
            TextEditingController ttl_ = TextEditingController();
            Map<String, TextEditingController> fields = {ttl: ttl_};
            */

            try {
              String key_ = await generateKey();
              //  String encr = await encrypt(cntt, key_);
              String ttl_ = tagged; // fields[ttl]!.text;
              DatabaseHelper dbh = DatabaseHelper(table: ttcnt);

              if (!await dbh.rowExists({ttl: ttl_})) {
                String flnm = "${ussr_.Unique_ID}$ttl_.txt";
                writeToFile(cbtCnt, flnm);

                int crtAt = DateTime.now().millisecondsSinceEpoch;
                Map<String, dynamic> mpp = {
                  ttl: ttl_,
                  key: key_,
                  flln: flnm,
                  createdAt: crtAt,
                  updatedAt: crtAt
                };

                await dbh.insertData(mpp);
                /*
                            $fld = array(
                            "user_id"  => "987987989",
                            "domain"=> 104,
                            "filename"  => "Awessome",
                            "path"=> $fl_path."/". $fnm
                            );
                            */

                Map<String, Object> tag = {
                  "Essence": "access",
                  "State": "specific_tsk",
                  "Specific": "CBT_Upload",
                  "Full_Name": ussr_.Name,
                  unq: ussr_.Unique_ID,
                  "domain": "112",
                  "access": "122",
                  "File": cbtCnt,
                  "FileName": ttl_,
                  "FileType": "Text",
                  "Folder": "EliteCBT",
                  "Manifest": {"user": "5943074", "domain": "107"}
                };
                svrRequest(tag, "essence", endgoal, context);
              } else {
                customSnackBar(context, "Content Exists already");
              }
            } catch (e) {}
            break;
          case accStore:
            List<String> bbd = crs_cd.split(RegExp("##"));

            sct_var = {
              "user": ussr_.Unique_ID,
              "course": bbd[1],
              "identity": bbd[0]
            };

            Map<String, Object> tag = {
              "Essence": "subscription",
              "State": rd_e,
              "Manifest": sct_var
            };

            modalPane("User Access", tag, desig, aid, "", '', server,
                futureclasses, true, context);

            /*
            if (crsSub.isNotEmpty) {
              Map<String, dynamic> subs = jsonDecode(crsSub);
              subs.forEach(
                (key, value) {
                  if (key == crs_cd) {}
                },
              );
            }

            if (crsChk != true) {
              dialogResponse(
                  context,
                  "You currently don't have an active subscription to this content, kindly subscribe",
                  subscr,
                  subscr);
            } else {
              modalPane("Loading Content", tag, desig, tpd, "", '', server,
                  futureclasses, true, context);
            }
            */
            break;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 15, 15, 0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 1))
                        ]),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Html(
                            data: "<u><b>$tagged</b></u>",
                          ),
                        ),
                        Column(
                          children: expp,
                        )
                      ],
                    )),
              ),
            ],

            /*
              child: Html(
                  data: """
                  <div>Follow<a class='sup'><sup>pl</sup></a> 
                    Below hr
                      <b>Bold</b>
                  <h1>what was sent down to you from your Lord</h1>, 
                  and do not follow other guardians apart from Him. Little do 
                  <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                  """,
                )
      
            */
          )
        ],
      ),
    );
  }
}

class Sect extends StatelessWidget {
  final List components;
  final String content, endgoal;

  const Sect(
      {super.key,
      required this.components,
      required this.endgoal,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        List<Widget> wdg = [];

        for (int i = 0; i < components.length; i++) {
          final tpc = components[i]["topic"];
          final cntt = components[i]["contents"];

          bool dsc = false;

          List<Widget> elucid = [];

          for (int j = 0; j < cntt.length; j++) {
            try {
              final cnt_ = cntt[j]["content"];
              dsc = true;

              Container cntp = Container(
                padding: const EdgeInsets.all(7),
                child: Html(
                  data: cnt_,
                ),
              );

              elucid.add(cntp);

              /*

              try {
                final ntt_ = cntt[j]["note"];
                for (int k = 0; k < ntt_.length; k++) {
                  Container cntp = Container(
                    padding: const EdgeInsets.all(8),
                    child: Html(
                      data: "<i>${ntt_[k]}</i>",
                    ),
                  );
                  elucid.add(cntp);
                }
              } catch (e) {}

              */

              try {
                Html obb = Html(
                  data: "<i>Objectives</i>",
                );
                elucid.add(obb);

                final obj_ = cntt[j]["objectives"];
                for (int l = 0; l < obj_.length; l++) {
                  Container cntp = Container(
                    padding: const EdgeInsets.all(5),
                    child: Html(
                      data: "<b>${obj_[l]}</b>",
                    ),
                  );
                  elucid.add(cntp);
                }
              } catch (e) {}
            } catch (e) {
              try {
                Container cntp = Container(
                  padding: const EdgeInsets.all(7),
                  child: Html(
                    data: cntt[j],
                  ),
                );
                elucid.add(cntp);
              } catch (e) {}
            }
          }
          try {
            if (!dsc) {
              Html obb = Html(
                data: "<i>Objectives</i>",
              );
              elucid.add(obb);
            }

            final obj_ = components[i]["objectives"];
            for (int l = 0; l < obj_.length; l++) {
              Container cntp = Container(
                padding: const EdgeInsets.all(5),
                child: Html(
                  data: "<b>${obj_[l]}</b>",
                ),
              );
              elucid.add(cntp);
            }
          } catch (e) {}

          wdg.add(ContentUnit(
            tagged: tpc,
            expp: elucid,
            endgoal: endgoal,
          ));
        }

        Column clm = Column(children: wdg);

        Modal(
            context,
            320,
            SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: SizedBox(
                    width: 350,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(content),
                          Container(child: clm),
                        ]),
                  )),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 15, 15, 0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 1))
                        ]),
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Html(
                        data: content,
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Decker extends StatelessWidget {
  final String code, lcname, lcn, identity;
  const Decker(
      {super.key,
      required this.lcname,
      required this.lcn,
      required this.code,
      required this.identity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // customSnackBar(context, "Contents are not yet stacked");
        switch (lcn) {
          case "lcn":
            break;

          case crsTbl:
            crs_cd = "$identity##$code";
            logger("CourseCheck: $crs_cd");

            sct_var = {cdd: identity};

            //tag = {"Essence": crsTbl, "State": rd_e, "Manifest": sct_var};

            Map<String, Object> tag = {
              "Essence": crsLne,
              "State": rd_e,
              "Manifest": sct_var
            };

            Future<List<Widget>>? futureclasses;

            modalPane("Course Content", tag, desig, crsLne, "", endgoal, server,
                futureclasses, true, context);
            break;

          case fac:
            Map<String, Object> tag = {"Essence": "faculty", "State": "read"};

            Future<List<Widget>>? futureclasses;

            modalPane("faculty", tag, desig, "essence", "", endgoal, server,
                futureclasses, true, context);
            break;

          default:
            switch (lcn) {
              case lectrr:
                myContents = Videos(
                  essence: videos,
                  data: {
                    "Essence": "course_content",
                    "State": "read_expl",
                    "Manifest": {"Unique_ID": ussr_.Unique_ID}
                  },
                  title: '',
                  exec: adlct,
                  fltclr: bgmainclr,
                );
                break;
            }
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(lcn);
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5,
                  blurStyle: BlurStyle.normal,
                  color: Color.fromARGB(99, 158, 158, 158),
                  offset: Offset(0, 2),
                  spreadRadius: 2)
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(code),
                ),
              ),
              Text(lcname)
            ]),
            Icon(
              Icons.arrow_circle_right,
              color: bgmainclr,
            )
          ],
        ),
      ),
    );
  }
}

@override
Modal(BuildContext context, double hth, Widget? entry) {
  dlg = context;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        dlg = context;
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: hth,
            child: entry,
          ),
        );
      });
}

Widget customUI(String type, List<dynamic> content) {
  late Widget uiWidget;
  switch (type) {
    case cedar:
      uiWidget = InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(content[0]),
                ),
              ),
              Text(content[1])
            ]),
            Icon(
              Icons.arrow_circle_right,
              color: bgmainclr,
            )
          ],
        ),
      );

      break;
  }
  return uiWidget;
}

void serverEntry(
    String title,
    Map<Map<String, String>, TextEditingController> fields,
    String essence,
    String btnText,
    BuildContext context,
    GlobalKey<ScaffoldState> ctxKey) {
  Modal(
      context, 200, formContent(title, fields, essence, sbm, context, ctxKey));
}

dismissDailog() {
  if (dlg != null) {
    Navigator.pop(dlg!);
  }

  /*
  if (mounted) {
    MediaQuery.of(context).size;
    Navigator.of(context).pop();
  }
  */
}

//ServerCreate

bool statusCode = false;

void modalPane(
    String title,
    Map<String, Object> tag,
    String domain,
    String essence,
    String designation,
    String endgoal,
    String function,
    Future<List<Widget>>? futureclasses,
    bool active,
    BuildContext context) {
  drwdlg = context;
  switch (essence) {
    case vww:
      break;
    default:
      futureclasses = obtainData(tag, domain, essence, designation, endgoal,
          function, active, context);
      Modal(
          context,
          320,
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: SizedBox(
                  width: 350,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        Container(
                            child: (futureclasses == null)
                                ? const Text(" No Data Yet")
                                : castData(
                                    futureclasses, function, essence, endgoal)),
                      ]),
                )),
          ));

      break;
  }
}

SingleChildScrollView formContent(
    String title,
    Map<Map<String, String>, TextEditingController> fields,
    String essence,
    String btnText,
    BuildContext context,
    GlobalKey<ScaffoldState> ctxKey) {
  List<Widget> wdg = [];

  logger("The Entries ${fields.length}");

  /*

  if (fields.isNotEmpty) {
    fields.forEach((key, value) {
      wdg.add(SizedBox(
        height: 50,
        width: double.infinity,
        child: TextField(
          maxLines: 20,
          controller: value,
          cursorColor: Colors.black,
          textAlign: TextAlign.start,
          textCapitalization: TextCapitalization.sentences,
          textAlignVertical: const TextAlignVertical(y: 1),
          decoration: InputDecoration(
            hintText: key[0],
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: bgmainclr),
            ),
          ),
        ),
      ));
    });
  }

  */

  if (fields.isNotEmpty) {
    fields.forEach((key, value) {
      logger("The Entry Cast: ${jsonEncode(key)}");
      Map<String, String> kv = key;
      String elmnt = "";
      String plch = "";
      key.forEach((key, value) {
        elmnt = key;
        plch = value;
      });

      switch (elmnt) {
        case txtEdt:
          wdg.add(SizedBox(
            height: 50,
            width: double.infinity,
            child: TextField(
              maxLines: 20,
              controller: value,
              cursorColor: Colors.black,
              textAlign: TextAlign.start,
              textCapitalization: TextCapitalization.sentences,
              textAlignVertical: const TextAlignVertical(y: 1),
              decoration: InputDecoration(
                hintText: plch,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: bgmainclr),
                ),
              ),
            ),
          ));

          break;

        case drpDwn:
          //  final items = ["Ade", "Yinka"];

          String dropdownvalue = 'Item 1';

          // List of items in our dropdown menu
          var items = [
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 4',
            'Item 5',
          ];
          //  wdg.add(dropDown(items, items[0]));
          wdg.add(DropdownButton(
            // Initial Value
            value: dropdownvalue,

            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              /*
              setState(() {
                dropdownvalue = newValue!;
              });

              */
            },
          ));
          break;
      }
    });
  }

  ListView lstv = ListView.builder(
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: wdg.length,
      itemBuilder: (BuildContext context, int index) {
        return wdg[index];
      });

  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: SizedBox(
        // height: MediaQuery.of(context).size.height,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [Headers(headings: title), Divider()],
            ),
            //  Flexible(fit: FlexFit.tight, child: const Divider()),
            Container(
              // flex: 3,
              // fit: FlexFit.loose,
              child: lstv,
            ),
            Container(
                child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: accentclr),
                  onPressed: () async {
                    //   Navigator.of(context);
                    switch (essence) {
                      case uplCBT:
                        try {
                          String key_ = await generateKey();
                          //  String encr = await encrypt(cntt, key_);

                          String ttl_ = fields[ttl]!.text;

                          DatabaseHelper dbh = DatabaseHelper(table: ttcnt);

                          if (!await dbh.rowExists({ttl: ttl_})) {
                            String flnm = "${ussr_.Unique_ID}$ttl_.txt";
                            writeToFile(cbtCnt, flnm);

                            int crtAt = DateTime.now().millisecondsSinceEpoch;
                            Map<String, dynamic> mpp = {
                              ttl: ttl_,
                              key: key_,
                              flln: flnm,
                              createdAt: crtAt,
                              updatedAt: crtAt
                            };

                            await dbh.insertData(mpp);

                            /*
                            $fld = array(
                            "user_id"  => "987987989",
                            "domain"=> 104,
                            "filename"  => "Awessome",
                            "path"=> $fl_path."/". $fnm
                            );
                            */

                            Map<String, Object> tag = {
                              "Essence": "access",
                              "State": "specific_tsk",
                              "Specific": "CBT_Upload",
                              "Full_Name": ussr_.Name,
                              unq: ussr_.Unique_ID,
                              "domain": "112",
                              "access": "122",
                              "File": cbtCnt,
                              "FileName": ttl_,
                              "FileType": "Text",
                              "Folder": "EliteCBT",
                              "Manifest": {"user": "5943074", "domain": "107"}
                            };
                            svrRequest(tag, "essence", endgoal, context);
                          } else {
                            customSnackBar(context, "Content Exists already");
                          }
                        } catch (e) {}
                        break;
                      case todoTbl:
                        try {
                          String ttl_ = fields[ttl]!.text;
                          String note_ = fields[note]!.text;
                          String schedule_ = fields[schedule]!.text;
                          int crtAt = DateTime.now().millisecondsSinceEpoch;
                          int updAt = crtAt;

                          DatabaseHelper dbh = DatabaseHelper(table: todoTbl);
                          Map<String, dynamic> row = {
                            ttl: ttl_,
                            note: note_,
                            deadline: schedule_,
                            createdAt: crtAt,
                            updatedAt: updAt
                          };
                          dbh.insertData(row);

                          dismissDailog();

                          Modal(
                              ctxKey.currentContext!,
                              75,
                              Column(
                                children: [
                                  Text("Entry Successful"),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(ctxKey.currentContext!)
                                            .pop();
                                      },
                                      child: Text("OK"))
                                ],
                              ));

                          await refeshData();

                          /*
                            customSnackBar(
                                ctxKey.currentContext!, "Successful Entry");
                                */

                          //  ctxKey.currentContext!.;

                          //myData = _obtainData();
                        } catch (e) {
                          logger("DebugError: $e");
                          customSnackBar(context, "Entry error");
                        }
                        break;

                      case prm:
                        String pin_ = fields[pin]!.text;
                        //     String srl_ = fields[serial]!.text;

                        if (fbId != community) {
                          Map<String, Object> tag = {};
                          tag.addEntries({
                            "Essence": "reconciliation",
                            "State": "specific_tsk",
                            "Specific": "Promo Entry",
                            "Pin": pin_,
                            "Device": fbId,
                            "App_Name": community,
                            "Phone": ussr_.Phone,
                            "Manifest": {
                              "User_ID": ussr_.Unique_ID,
                              "Domain": "107"
                            }
                          }.entries);

                          //Navigator.pop(context, result);

                          //          Navigator.pop(context);

                          Navigate nvg = Navigate();

                          Map<String, dynamic>? obj = await nvg.eliteApi(
                              tag, desig, "essence", "", true, context);

                          ServerPrelim? svp =
                              ServerPrelim.fromJson(obj!); // as ServerPrelim?;

                          //  String mssg = svp!.msg.toString();
                          print("chkzz${obj.toString()}");
                          /*
                            showDialog(context: _scaffoldKey.currentContext ,builder: (context){
                              return dialog;
                            });
                            }
                            */
                          customSnackBar(
                              ctxKey.currentContext!, obj["message"]);

                          dismissDailog();

                          //  Function

                          //  _processKey;

                          //  customSnackBar(context, obj["message"]);

                          //  if (svp!.status) {}

                          // ServerResponse? svp = await nvg.getEliteApi(
                          //     tag, desig, "essence", true, context);
                        } else {
                          // customSnackBar(context,
                          //     "Device Unique ID not assigned, kindly ensure you're connected to the internet");
                        }
                        break;
                    }
                  },
                  child: Text(btnText)),
            )),
          ],
        ),
      ),
    ),
  );
}

void customMessage(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: Text(title),
        content: Text(message),
      );
    },
  );
}

void dialogResponse(
  BuildContext context,
  String message,
  String button,
  String essence,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        title: Text(
          message,
          style: TextStyle(
            color: Color.fromARGB(255, 6, 43, 73),
            fontSize: 13,
          ),
        ),
        content: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                  onPressed: () async {
                    SharedPref pref = SharedPref();
                    switch (essence) {
                      case subscr:
                        Map<String, Object> tag = {
                          "Essence": "plans",
                          "State": rd
                        };
                        Future<List<Widget>>? futureclasses;
                        modalPane("Subscription", tag, desig, essence, essence,
                            endgoal, server, futureclasses, true, context);
                        // formContent("Subscribe", fields, essence, btnText, context, ctxKey)
                        break;
                      case logout:
                        Navigate().LogOut(context);
                        break;
                      case bbst:
                        String? bbs = await pref.getPrefString(bbst);
                        if (bbs != null) {
                          // Navigator.of(context).pop();
                          //   Navigator.of(context).pushNamed(nowplaying);
                        } else {
                          logger("No Content Yet...");
                        }

                        /*

                          nowplaying: (context) => NowPlaying(
            vmd: curr_vid,
          ),

          */

                        String bbsy =
                            "Best Brain holds three times weekly with great prices being won";

                        if (bbs != null) {
                          logger(bbs);
                          Map<String, dynamic> bbm = jsonDecode(bbs);
                          bbsy = bbm[ttl];
                        } else {
                          logger("No Content Yet...");
                        }

                        dialogResponse(context, bbsy, "Connect", bbst);

                        break;
                      default:
                        Navigator.of(context).pop();
                        break;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey, width: 1)),
                  child: Text(
                    button,
                    style: TextStyle(color: Colors.red),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 6, 43, 73),
                    side: BorderSide(color: Colors.grey, width: 1)),
                child: Text('Cancel'))
          ],
        ),
      );
    },
  );
}

class ClassList extends StatefulWidget {
  final Map<String, Object> tagged;
  final name, domain, essence, endgoal, identifier, view_, title;

  const ClassList(
      {super.key,
      this.name,
      this.essence,
      this.endgoal,
      this.identifier,
      required this.tagged,
      this.view_,
      this.title,
      this.domain});

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  Future<List<Widget>>? _futureclasses;
  late Navigate nvg;
  late Endpoint enp;
  var index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nvg = Navigate();
    enp = Endpoint();

    switch (widget.view_) {
      default:
        _futureclasses = obtainData(widget.tagged, widget.domain, widget.view_,
            "", endgoal, server, true, context);
        //  obtainData(widget.tagged, widget.essence, widget.endgoal);
        break;
    }
  }

  @override
  build(BuildContext context) {
    switch (widget.view_) {
      default:
        return Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: AppHead(
                headtitle: 'classes',
              )),
          body: Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: (_futureclasses == null)
                  ? const Text(" No Data Yet")
                  : castData(_futureclasses, server, widget.essence, endgoal)),
        );
    }
  }

  Text pagePreload(String presTatus) {
    return Text(presTatus);
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outlined,
                    size: 100,
                    color: Colors.red,
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                        textAlign: TextAlign.center,
                        ' Could not fetch data at the moment \nplease check your internet access and try again'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 30), backgroundColor: bgmainclr),
                onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => DashboardLayout(),
                      ),
                    ),
                child: const Text(
                  'Return to Dashboard',
                  style: TextStyle(color: accentclr),
                ))
          ],
        ),
      ),
    );
  }
}

class ContentDisplay extends StatelessWidget {
  final mainhead,
      description,
      purp,
      image,
      dest,
      imgsize,
      playicn,
      link,
      essence;
  const ContentDisplay(
      {super.key,
      this.mainhead,
      this.description,
      this.purp,
      this.image,
      this.imgsize,
      this.playicn,
      this.link,
      this.essence,
      this.dest});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(dest);
        switch (essence) {
          case vdd:
            log(link);
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    blurStyle: BlurStyle.inner,
                    blurRadius: 2,
                    color: Color.fromARGB(26, 158, 158, 158),
                    offset: Offset(2, 2),
                    spreadRadius: 2)
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              image,
                              width: imgsize.toDouble(),
                            ),
                            //    playicn
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        mainhead,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            overflow: TextOverflow.clip,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              width: 140,
                              child: Text(
                                description,
                                maxLines: 2,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: 70,
                          child: Text(
                            purp,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CurrViews extends StatefulWidget {
  final String duration, topic, objective;
  const CurrViews(
      {super.key,
      required this.duration,
      required this.topic,
      required this.objective});

  @override
  State<CurrViews> createState() => _CurrViewsState();
}

class _CurrViewsState extends State<CurrViews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 233, 233, 233)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 211, 208, 208)),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(widget.duration),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Text(widget.topic),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: Column(
              children: [
                Text(widget.objective),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IndividualList extends StatefulWidget {
  final sClass,
      image,
      name,
      gender,
      phone,
      email,
      essbtn,
      essdest,
      addpurp,
      addpic,
      addednm,
      addedid,
      addnm;

  const IndividualList({
    super.key,
    required this.sClass,
    required this.image,
    required this.name,
    required this.gender,
    required this.essbtn,
    required this.essdest,
    required this.phone,
    required this.email,
    this.addpurp,
    this.addnm,
    this.addpic,
    this.addednm,
    this.addedid,
  });

  @override
  State<IndividualList> createState() => _IndividualListState();
}

class _IndividualListState extends State<IndividualList> {
  var dsgn_ = ButtonStyle(
      side: MaterialStateProperty.all(const BorderSide(width: 1)),
      backgroundColor:
          MaterialStateProperty.all(const Color.fromARGB(0, 158, 158, 158)));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Text(widget.sClass),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(widget.image),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.name,
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        widget.gender,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      switch (widget.essbtn) {
                        case 'View Profile':
                          Modal(
                              context,
                              500,
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage(widget.image),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Full Name ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: 120,
                                            child: Text(
                                              widget.name,
                                              style: const TextStyle(
                                                  color: accentclr,
                                                  fontSize: 14),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Email ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              widget.email,
                                              style: const TextStyle(
                                                  color: accentclr,
                                                  fontSize: 14),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Phone ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            widget.phone,
                                            style: const TextStyle(
                                                color: accentclr, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Gender ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            widget.gender,
                                            style: const TextStyle(
                                                color: accentclr, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.addpurp),
                                          TextButton(
                                              onPressed: () {
                                                switch (widget.addnm) {
                                                  case 'assign course':
                                                    Modal(context, 300,
                                                        Container());
                                                    break;
                                                  case 'Tag child/ward':
                                                    Modal(context, 300,
                                                        Container());
                                                    break;
                                                }
                                              },
                                              child: Text(widget.addnm))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          widget.addpic,
                                          width: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(widget.addednm),
                                                Text(
                                                  widget.addedid,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                )
                                              ]),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ));

                          break;
                        case " Select":
                          dsgn_ = ButtonStyle(
                              side: MaterialStateProperty.all(
                                  const BorderSide(width: 1)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(0, 215, 19, 19)));
                          break;
                        case 'view result':
                          Modal(
                              context,
                              500,
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage(widget.image),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Full Name ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: 120,
                                            child: Text(
                                              widget.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: accentclr,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Gender ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            widget.gender,
                                            style: const TextStyle(
                                                color: accentclr, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Class ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            widget.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: accentclr, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'subjects',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'C.A',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                ),
                                                Text(
                                                  'Exam',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: Text(
                                              'Mathemathics ',
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '30',
                                                  style: TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  '60',
                                                  style: TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: Text(
                                              'English Language ',
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '30',
                                                  style: TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  '60',
                                                  style: TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: Text(
                                              'EconomicsEconomicsEconomicsEconomicsEconomics ',
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '30',
                                                  style: TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  '60',
                                                  style: TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));

                          break;

                        case 'update result':
                          Modal(
                              context,
                              500,
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage(widget.image),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Full Name ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: 120,
                                            child: Text(
                                              widget.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: accentclr,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Gender ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            widget.gender,
                                            style: const TextStyle(
                                                color: accentclr, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Class ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            widget.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: accentclr, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'subjects',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'C.A',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.orange),
                                                ),
                                                Text(
                                                  'Exam',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.green),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              'Mathemathics ',
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 84,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    child: TextField(
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                    focusColor: Colors.white,
                                                    constraints: BoxConstraints(
                                                        maxWidth: 40,
                                                        maxHeight: 30),
                                                    label: Text(
                                                      '50',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              216,
                                                              216)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                )),
                                                SizedBox(
                                                    child: TextField(
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                    focusColor: Colors.white,
                                                    constraints: BoxConstraints(
                                                        maxWidth: 40,
                                                        maxHeight: 30),
                                                    label: Text(
                                                      '50',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              216,
                                                              216)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              'English Language ',
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 84,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    child: TextField(
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                    focusColor: Colors.white,
                                                    constraints: BoxConstraints(
                                                        maxWidth: 40,
                                                        maxHeight: 30),
                                                    label: Text(
                                                      '50',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              216,
                                                              216)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                )),
                                                SizedBox(
                                                    child: TextField(
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                    focusColor: Colors.white,
                                                    constraints: BoxConstraints(
                                                        maxWidth: 40,
                                                        maxHeight: 30),
                                                    label: Text(
                                                      '50',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              216,
                                                              216)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              31, 141, 141, 141),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              'EconomicsEconomicsEconomicsEconomicsEconomics ',
                                              style: TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 84,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    child: TextField(
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                    focusColor: Colors.white,
                                                    constraints: BoxConstraints(
                                                        maxWidth: 40,
                                                        maxHeight: 30),
                                                    label: Text(
                                                      '50',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              216,
                                                              216)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                )),
                                                SizedBox(
                                                    child: TextField(
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                    focusColor: Colors.white,
                                                    constraints: BoxConstraints(
                                                        maxWidth: 40,
                                                        maxHeight: 30),
                                                    label: Text(
                                                      '50',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey),
                                                    ),
                                                    hintStyle: TextStyle(
                                                        fontSize: 9,
                                                        color: Colors.black),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Color.fromARGB(
                                                              255,
                                                              216,
                                                              216,
                                                              216)),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          width: 1,
                                                          color: Colors.blue),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));

                          break;
                      }
                    },
                    style: dsgn_,
                    child: Text(
                      widget.essbtn,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            constraints: BoxConstraints(
                                maxHeight: 500,
                                minWidth: MediaQuery.of(context).size.width),
                            shape: const ContinuousRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  widget.name,
                                                  style: const TextStyle(
                                                      color: accentclr,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  widget.gender,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundImage:
                                                    AssetImage(widget.image),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 20),
                                            width: double.infinity,
                                            height: 150,
                                            child: TextField(
                                              minLines: 30,
                                              maxLines: 35,
                                              textAlignVertical:
                                                  const TextAlignVertical(y: 1),
                                              decoration: InputDecoration(
                                                focusColor: Colors.white,
                                                hintText:
                                                    'send a message to ${widget.name}',
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        216,
                                                                        216,
                                                                        216)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            )),
                                        ElevatedButton(
                                            onPressed: () {
                                              Modal(
                                                  context,
                                                  50,
                                                  const Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .check_circle_sharp,
                                                        color: Colors.green,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        'Successfully sent',
                                                      )
                                                    ],
                                                  ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: accentclr),
                                            child: const Text('send message'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: SvgPicture.asset('assets/svg/chat1.svg'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    String initialCountry = 'NG';
    PhoneNumber number = PhoneNumber(isoCode: 'NG');
    return InternationalPhoneNumberInput(
      inputDecoration: InputDecoration(
        border: InputBorder.none,
      ),
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: TextStyle(color: Colors.black),
      initialValue: number,
      textFieldController: controller,
      formatInput: true,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: OutlineInputBorder(),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}

class TitleMoreAndBodyWidget extends StatelessWidget {
  String title;
  void Function()? seeAllFunction;
  Widget body;

  // TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black);

  final bool? isSeeAll;
  // ignore: non_constant_identifier_names
  // Widget SeeAll=TextButton(onPressed: (){seeAllFunction()}, child: Text("see all"));

  TitleMoreAndBodyWidget({
    super.key,
    required this.title,
    this.seeAllFunction,
    required this.body,
    this.isSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.bodySmall;
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: style),
            Expanded(child: SizedBox()),
            SeeAllOrNot(
                isSeeAll ?? false,
                TextButton(
                    onPressed: () {
                      print(isSeeAll);
                    },
                    child: Text("see all", style: style))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        body
      ],
    );
  }
}

class SeeAllOrNot extends StatelessWidget {
  bool isTrue;

  Widget wdgy;
  SeeAllOrNot(this.isTrue, this.wdgy, {super.key});

  @override
  Widget build(BuildContext context) {
    return (isTrue)
        ? wdgy
        : SizedBox(
            height: 2,
            width: 2,
          );
  }
}

class IconTextWidget extends StatelessWidget {
  final void Function()? onTap;
  final TextStyle? style;
  final Widget icon;

  final iconString;

  final num? height;

  final num? width;

  const IconTextWidget(this.iconString, this.icon,
      {this.height, this.width, super.key, this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: onTap ?? () {},
      splashColor: Colors.transparent,
      child: SizedBox(
        // color: Colors.amber,
        height: (height ?? 100.0) as double,
        width: (width ?? 100.0) as double,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(height: 5),
            Text(
              iconString,
              style: style ?? TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TelephoneNumberWidget extends StatelessWidget {
  TextEditingController? controller;
  TelephoneNumberWidget({
    super.key,
    required this.context,
    this.controller,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    String initialCountry = 'NG';
    PhoneNumber number = PhoneNumber(isoCode: 'NG');
    return InternationalPhoneNumberInput(
      inputDecoration: InputDecoration(
        // constraints:
        // BoxConstraints.tight(Size(double.maxFinite, double.minPositive)),
        border: InputBorder.none,
      ),
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: TextStyle(color: Colors.black),
      initialValue: number,
      textFieldController: controller ?? controller,
      formatInput: true,
      keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: OutlineInputBorder(),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}

class PopUpPinWidget extends StatefulWidget {
  const PopUpPinWidget({super.key});

  @override
  State<PopUpPinWidget> createState() => _PopUpPinWidgetState();
}

class _PopUpPinWidgetState extends State<PopUpPinWidget> {
  String text = '';

  _onKeyboardTap(String value) {
    setState(() {
      //TODO 3: RECORD THE VALUE
      if (text.length < 6) text += '#';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: 200,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 280,
              decoration: BoxDecoration(
                  color: Colors.black.withAlpha(20),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  text,
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              // width: 320,
              child: NumericKeyboard(
                textStyle: TextStyle(fontSize: 30),
                mainAxisAlignment: MainAxisAlignment.start,
                onKeyboardTap: _onKeyboardTap,
                rightButtonFn: () {
                  if (text.isEmpty) return;
                  setState(() {
                    text = text.substring(0, text.length - 1);
                  });
                },
                rightButtonLongPressFn: () {
                  if (text.isEmpty) return;
                  setState(() {
                    text = '';
                  });
                },
                rightIcon: Icon(
                  Icons.backspace,
                  color: Theme.of(context).primaryColorLight,
                ),
                leftButtonFn: () {
                  print('left button clicked');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Alert1 extends StatelessWidget {
  // Offset? offset = Offset.fromDirection(180, 5);
  bool fromLeft;
  Alert1({
    super.key,
    this.fromLeft = false,
  });

  // final List<Widget> popUpList;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        SlideEffect(begin: Offset.fromDirection((fromLeft) ? pi : 0, 5))
      ],
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        title: Align(alignment: Alignment.center, child: Text('Create Pin')),
        // alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        content: const FittedBox(child: PopUpPinWidget()),
        // contentPadding: const EdgeInsets.only(bottom: 0),
        actions: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        DialogRoute(
                          context: context,
                          builder: (context) => Animate(
                            effects: [
                              SlideEffect(
                                  // duration: Duration(milliseconds: 1000),
                                  begin: Offset.fromDirection(0, 5))
                            ],
                            child: Alert2(),
                          ),
                        ));
                  },
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  color: Theme.of(context).primaryColor,
                  child: Text('Create',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white))))
        ],
      ),
    );
  }
}

class Alert2 extends StatelessWidget {
  const Alert2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [SlideEffect(begin: Offset.fromDirection(0, 5))],
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(DialogRoute(
                    context: context,
                    builder: (context) => Alert1(fromLeft: true),
                  ));
                },
                icon: const Icon(Icons.arrow_back_rounded)),
            const Text('Confirm Pin'),
          ],
        ),
        // alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        content: FittedBox(child: PopUpPinWidget()),
        // contentPadding: const EdgeInsets.only(bottom: 0),
        actions: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  color: Theme.of(context).primaryColor,
                  child: Text('Create',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white))))
        ],
      ),
    );
  }
}

class EnterPinAlert extends StatelessWidget {
  final Function? onClick;
  const EnterPinAlert({
    super.key,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [SlideEffect(begin: Offset.fromDirection(0, 5))],
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
              ],
            ),
            const Text('Enter Pin'),
          ],
        ),
        // alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        content: FittedBox(child: PopUpPinWidget()),
        // contentPadding: const EdgeInsets.only(bottom: 0),
        actions: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    (onClick == null) ? 1 : onClick!();
                    // onClick!();
                  },
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  color: Theme.of(context).primaryColor,
                  child: Text('Pay',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white))))
        ],
      ),
    );
  }
}

class NoticeAlert extends StatelessWidget {
  final String message;
  final String? buttonString;

  const NoticeAlert({
    super.key,
    required this.message,
    this.buttonString,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [SlideEffect(begin: Offset.fromDirection(0, 5))],
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
          ],
        ),
        // alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
            height: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/circledCheck.png'),
                SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        // contentPadding: const EdgeInsets.only(bottom: 0),
        actions: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  color: Theme.of(context).primaryColor,
                  child: Text(buttonString ?? 'Return Home',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white)))),
        ],
      ),
    );
  }
}

class ConfirmAlert extends StatelessWidget {
  final Function? onYes;
  final String message;
  const ConfirmAlert({
    super.key,
    required this.message,
    this.onYes,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [SlideEffect(begin: Offset.fromDirection(0, 5))],
      child: AlertDialog(
        // backgroundColor: Colors.brown,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(30)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
          ],
        ),
        // alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        content: SizedBox(
            height: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/circledQuestionMark.png'),
                SizedBox(height: 20),
                Text(message),
              ],
            )),
        // contentPadding: const EdgeInsets.only(bottom: 0),
        actions: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    (onYes == null) ? 1 : onYes!();
                  },
                  minWidth: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  color: Theme.of(context).primaryColor,
                  child: Text('Yes',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white)))),
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  minWidth: 50,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(7)),
                  elevation: 4,
                  color: Colors.white,
                  // color: Theme.of(context).primaryColor,
                  child: Text('No',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black)))),
        ],
      ),
    );
  }
}
