import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Controller/fields.dart';
import '../controller/firebasehandler.dart';
import '../controller/sharedpref.dart';
import '../data/curriculum.dart';

import '../database/datafields.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/widget_keys.dart';
import '../screens/common_widget.dart';

class DashNotify extends StatefulWidget {
  final String advertsvg, advertTtl, ttlCont, ttlEnd, info, advEssence;
  final Color ttlclr;

  const DashNotify(
      {Key? key,
      required this.advertsvg,
      required this.advertTtl,
      required this.ttlCont,
      required this.ttlEnd,
      required this.info,
      required this.advEssence,
      required this.ttlclr})
      //   : super(key: _scaffoldkey);
      : super(key: key);

  // const DashNotify(
  //     {super.key,
  //     required this.advertsvg,
  //     required this.advertTtl,
  //     required this.ttlclr,
  //     required this.ttlCont,
  //     required this.ttlEnd,
  //     required this.info,
  //     required this.advEssence});

  @override
  State<DashNotify> createState() => DashNotifyState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();

GlobalKey<DashNotifyState>? _dashKey =
    RIKeys.riKey2 as GlobalKey<DashNotifyState>?; // GlobalKey();

GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//const riKey2 = _dashKey;

final keydash = RIKeys.riKey2 as GlobalKey<DashNotifyState>;
Future<Column>? _futureCln;

GlobalKey<DashNotifyState> keyNav = GlobalKey<DashNotifyState>();

var _key = GlobalKey();

String ttl = "";
String cnnt = "";
String end = "";
String info = "";
String details = "";
// bool refresh = false;
bool init = true;

class DashNotifyState extends State<DashNotify> {
  @override
  void initState() {
    super.initState();
    broadcast();
    notifyDash = false;
  }

  Future<void> updateView(String title, String content, String end_,
      String info_, String details) async {
    log("Awesome ******* $content");
    //  ttl = title;

    setState(() {
      ttl_nw = title;
      cnt_nw = content;
      end_nw = end_;
      info_nw = info_;
      notifyDash = !notifyDash;
    });

    log("A rebuild is essential...");
  }

  FutureBuilder<Column> castData(Future<Column>? futureclasses) {
    return FutureBuilder(
        future: futureclasses,
        builder: (context, snapshot) {
          log("I'm here");
          if (notifyDash == true) {
            updateView(ttl_nw, cnt_nw, end_nw, info_nw, dtls_nw);
          }

          elucidate = LearnMore(
            image: 'assets/images/learnmore.png',
            click: 'Leaderboard',
            faqQst: dnn.content,
            faqAns: dnn.details,
            heading: dnn.title,
          );
          //
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 210,
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      totalRepeatCount: 1000,
                      animatedTexts: [
                        TyperAnimatedText(
                          speed: const Duration(milliseconds: 250),
                          curve: Curves.linear,
                          (notifyDash) ? dnn.title : dnn.title,
                          textStyle: TextStyle(
                              color: widget.ttlclr,
                              fontWeight: FontWeight.bold,
                              fontSize: 35),
                        ),
                      ],
                    ),
                    Stack(children: [
                      Text(
                        (notifyDash) ? dnn.content : dnn.content,
                        style: TextStyle(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.white,
                        ),
                      ),
                      Text(
                        (notifyDash) ? dnn.content : dnn.content,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    Text(
                      (notifyDash) ? dnn.end : dnn.end,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              const Divider(
                endIndent: 120,
                height: 4,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                width: 190,
                child: Stack(children: [
                  Text(
                    (notifyDash) ? dnn.info : dnn.info,
                    style: TextStyle(
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.white,
                    ),
                  ),
                  Text(
                    (notifyDash) ? dnn.info : dnn.info,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
            ],
          );
        });
  }

/*

  Future<void> updateView(String title, String content, String end_,
      String info_, String details) async {
    log("Awesome ******* $content");
    //  ttl = title;

    setState(() {
      ttl = title;
      cnnt = content;
      end = end_;
      info = info_;
      refresh = !refresh;
    });

    log("A rebuild is essential...");
  }

  */

  Consumer dshnote() {
    return Consumer<FirebaseNotifier>(builder: (context, notifier, child) {
      return castData(_futureCln);
    });
  }

  Future<void> broadcast() async {
    if (init) {
      SharedPref pref = SharedPref();
      String? brdd = await pref.getPrefString(brdCast);

      try {
        if (brdd!.isNotEmpty) {
          dnn = dashNote.fromJson(jsonDecode(brdd));
          elucidate = LearnMore(
            image: 'assets/images/learnmore.png',
            click: 'Leaderboard',
            faqQst: dnn.content,
            faqAns: dnn.details,
            heading: dnn.title,
          );

          init = false;
        } else {
          dash();
        }
      } catch (e) {
        dash();
      }
    } else {}
  }

  void dash() {
    dnn = dashNote(
        title: widget.advertTtl,
        content: widget.ttlCont,
        end: widget.ttlEnd,
        info: widget.info,
        details: "");

    elucidate = const LearnMore(
      image: 'assets/images/learnmore.png',
      click: 'Leaderboard',
      faqQst: 'Our Core Value:',
      faqAns:
          'ElitePage as a multimedia learning platform raise geniuses through mastery with comprehensive video lessons by scholars, Computer based test for learners with over 50,000 Questions in bank on UTME, WASSCE, JSCE, Basic Education Contents,  Undergraduate Courses, Professional Courses and lots more... \nContent tool for tutors and Educationists to implement real time CBT for anticipated audience... \n \n   ElitePage for schools is 100% free of charge to manage daily routines ranging from Result collation, Inventory management, Student Academic Records, Parental feedback and lots more.... \n No hidden charges, \nkindly visit www.elitepage.ng/schoools to get the app customised specifically for your school within 72hours.... \n\n    Are you competent enough to monetise your intellectual constructs as a teacher? If yes? you can earn big monthly with royalty by producing intellectual content as a teacher ElitePage is hinged upon raising geniuses through mastery thereby organises weekly national contest with great prizes being won on weekly bases worth ood fortune',
      heading: 'Notifications',
    );

    ttl_nw = widget.advertTtl;
    cnt_nw = widget.ttlCont;
    end_nw = widget.ttlEnd;
    if (!lone) {
      info_nw = widget.info;
    } else {
      info_nw = "";
    }
    dtls_nw = "";
    init = false;
  }

  @override
  Widget build(BuildContext context) {
    dshCtx = context;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            widget.advertsvg,
            width: 200,
            alignment: Alignment.centerRight,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (init == false) ? dshnote() : const Text(""),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(learnmore);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: bgmainclr),
                  child: Text(
                    widget.advEssence,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

/*

void UpdateInfo(
    String title, String content, String end, String info, String details) {
  keydash.currentState!.updateView(title, content, end, info, details);
}

*/

Future<void> UpdateInfo(String title, String content, String end, String info,
    String details) async {
  log("Pre processsor");
  final state = keyNav.currentState!;
  log("Post processsor");
  //final ctx = _key.currentContext;
  await state.updateView(title, content, end, info, details);
  log("processs implemented");
}
