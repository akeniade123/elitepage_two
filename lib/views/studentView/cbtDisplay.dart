// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../Components/examin.dart';
import '../../../database/datafields.dart';
import '../../../models/global_strings.dart';
import '../../../models/server_response.dart';
import '../../screens/common_widget.dart';

// ignore: must_be_immutable
class CBTDisplay extends StatefulWidget {
  final Duration duration;
  final Map<String, String> contents;
  final int cog;
  final String mode;
  final TeXViewRenderingEngine renderingEngine;

  const CBTDisplay(
      {super.key,
      required this.duration,
      required this.contents,
      required this.mode,
      required this.cog,
      this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  State<CBTDisplay> createState() => _CBTDisplayState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _CBTDisplayState extends State<CBTDisplay> with TickerProviderStateMixin {
  List<Widget> tabs_ = [];
  List<CbtBody> bdd = [];

  int num = 1;

  double headsize = 290.0;
  late Column header;
  late FloatingActionButton float;
  late Widget exit;

  late CountDownController? countdown;
  late AnimationController? controller;

  Future<Widget>? cnt_;
  String stmt = "";
  String btnn = "";

  bool refresh = false;

  late String mode_;

  Future<bool> _onWillPoped() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure you are done?'),
            content: exit,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => {
                  /*
                  widget.controller!.stop,
                  widget.countdown!.isPaused,
                  */
                  Navigator.of(context).pop(true),
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();

    mode_ = widget.mode;

    switch (mode_) {
      case exmMode:
        countdown = CountDownController();
        controller = AnimationController(
          vsync: this,
          duration: widget.duration,
        );
        break;
    }

    //  cnt = dialogContent(mode_);

    header = CBTHeader(mode_);
    float = floatButton(mode_);
    exit = Exit(mode_);

    scripts = {};

    widget.contents.forEach((key, value) {
      tabs_.add(CbtTab(name: key));
      CbtBody bdy = CbtBody(
        data: value,
        qnum: num,
        course: key,
        mode: widget.mode,
      );
      bdd.add(bdy);
      Map<String, List<Map<String, Map<String, String>>>> mp = {};
      scripts.addEntries({key: mp}.entries);
    });
  }

  Future<Widget>? dialogContent(String mode) async {
    late Widget cnt_;

    switch (mode) {
      case rsltMode:
        cnt_ = resultSheet();
        break;

      case exmMode:
        stmt = "Would you like to submit this test?";
        btnn = "Submit";
        Widget cln = Column(
          children: [
            Text(stmt),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  mode_ = rsltMode;
                  header = CBTHeader(rsltMode);
                  float = floatButton(rsltMode);
                  exit = Exit(rsltMode);
                  refresh = !refresh;
                  setState(() {});
                  Modal(context, 470, resultSheet());
                },
                child: Text(btnn))
          ],
        );
        Modal(context, 70, cln);
        break;
      case prfMode:
        stmt = "";
        btnn = "";
        int cog = widget.cog;
        if (cog > 0) {
          Widget widget = SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Format Warnings",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "There are $cog warnings you need to resolve in order to upload this file, kindly attend to them for efficient upload"),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            ),
          );
          Modal(context, 200, widget);
        } else {
          Widget wdg = Column(
            children: [
              const Text("Ready to upload CBT?"),
              ElevatedButton(
                  onPressed: () async {
                    String cntt = jsonEncode(widget.contents);
                    cbtCnt = cntt;

                    Map<String, Object> tag = {
                      "Essence": "Section",
                      "State": "read_expl",
                      "Manifest": {"availability": "1"}
                    };

                    Future<List<Widget>>? futureclasses;

                    modalPane(uplCBT, tag, desig, sct, sct, prfMode, server,
                        futureclasses, true, context);
                  },
                  child: const Text("Upload"))
            ],
          );

          Modal(context, 70, wdg);
        }
        break;
    }
    cnt_ = SizedBox(
      height: 70,
      child: Column(
        children: [
          Text(stmt),
          ElevatedButton(onPressed: () {}, child: Text(btnn))
        ],
      ),
    );
    return cnt_;
  }

  FutureBuilder<Widget> dialogCast() {
    return FutureBuilder(
        future: cnt_,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Widget? data = snapshot.data;
            return Container(
              child: data,
            );
          } else {}
          return Center(
            child: LoadingAnimationWidget.flickr(
                leftDotColor: Colors.blue, rightDotColor: Colors.red, size: 30),
          );
        });
  }

  Column CBTHeader(String mode) {
    List<Widget> cbthead = [];

    switch (mode) {
      case exmMode:
        CBTtimer cbTtimer = CBTtimer(
          duration: widget.duration,
          cd_controller: countdown,
          controller: controller,
        );
        headsize = 290.0;
        cbthead.add(cbTtimer);
        break;
      case prfMode:
      case rsltMode:
        headsize = 150.0;
        break;
    }
    return Column(children: cbthead);
  }

  Widget Exit(String mode) {
    late Widget widget;
    switch (mode) {
      case exmMode:
        widget = const Text('This automatically submits your test');
        break;
      case rsltMode:
        widget = const Text(
            'It\'s awesome testing your capacity, would you like to go to the home page now?');
        break;
      case prfMode:
        widget = const Text('Kindly ensure you\'re done before you exit');

        break;
    }
    return widget;
  }

  TableRow resultcolumn(
      String subject, String score, String total, String percent) {
    return TableRow(children: [
      Text(
        subject,
        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      Text(
        score,
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        total,
        style: const TextStyle(fontSize: 15.0),
      ),
      Text(
        percent,
        style: const TextStyle(fontSize: 15.0),
      ),
    ]);
  }

  Widget resultSheet() {
    List<TableRow> lsr = [];
    TableRow rslt = resultcolumn("Test", "Score", "Total", "Percentage");
    lsr.add(rslt);
    List<double> pieData = [];

    scripts.forEach((key, value) {
      String sbj = key;
      int score = 0;
      int total = 0;
      value.forEach((key, value) {
        for (int i = 0; i < value.length; i++) {
          Map<String, Map<String, String>> sct = value[i];
          sct.forEach((key, value) {
            value.forEach((key, value) {
              if (key == value) {
                score++;
              }
            });
          });
        }
      });
      widget.contents.forEach((key, value) {
        if (key == sbj) {
          List<dynamic> qstn = jsonDecode(value);
          total = qstn.length;
        }
      });
      double pcnt = score / total;
      TableRow rslt = resultcolumn(
          sbj, score.toString(), total.toString(), pcnt.toString());
      lsr.add(rslt);
    });

    PieChart pie = PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, color: Colors.red),
          PieChartSectionData(value: 30, color: Colors.green),
          PieChartSectionData(value: 20, color: Colors.blue),
          PieChartSectionData(value: 10, color: Colors.yellow),
          PieChartSectionData(value: 10, color: Colors.orange),
          // Add more sections for more slices
        ],
      ),
    );

    Container prr = Container(
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(3)),
      child: pie,
    );

    Table tbl = Table(
        border: TableBorder.all(color: Colors.green, width: 1.5),
        columnWidths: const {
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.5),
          3: FlexColumnWidth(1.5),
          4: FlexColumnWidth(2),
        },
        children: lsr);

    return Column(
      children: [tbl, prr],
    );
  }

  FloatingActionButton floatButton(String mode) {
    Icon icn = const Icon(Icons.reset_tv_outlined);
    switch (mode) {
      case rsltMode:
        icn = const Icon(Icons.school);
        break;
      case prfMode:
        icn = const Icon(Icons.add_chart_rounded);
        break;
    }

    return FloatingActionButton(
      // isExtended: true,
      backgroundColor: Colors.green,
      onPressed: () async {
        switch (mode_) {
          case prfMode:
            await dialogContent(mode_);
            break;
          case rsltMode:
            Modal(context, 470, resultSheet());
            break;
          case exmMode:
            await dialogContent(mode_);

            /*

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      content: Container(
                          child: (refresh)
                              ? dialogCast()
                              : dialogCast()) // (cnt == null)? {} : dialogContent(mode),
                      );
                });
                */

            break;
        }
      },
      // isExtended: true,
      child: icn,
    );
  }

  @override
  Widget build(BuildContext context) {
    TabBar tbb = TabBar(
        padding: const EdgeInsets.all(2),
        isScrollable: true,
        indicator: BoxDecoration(
            color: const Color.fromARGB(255, 250, 250, 250),
            borderRadius: BorderRadius.circular(5)),
        tabs: tabs_);

    TabBarView tbv = TabBarView(children: bdd);

    return WillPopScope(
      onWillPop: _onWillPoped,
      child: DefaultTabController(
        length: widget.contents.length,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(headsize),
              child: AppBar(
                toolbarHeight: 50,
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: const Color.fromARGB(255, 3, 38, 66),
                centerTitle: true,
                elevation: 0,
                title: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: []),
                // flexibleSpace: Container(
                //   margin: const EdgeInsets.only(top: 50),
                //   child: header,
                // ),
                bottom: Tab(
                  height: headsize - 50,
                  child: Column(
                    children: [
                      header,
                      const SizedBox(
                        height: 40,
                      ),
                      tbb
                    ],
                  ),
                ),
              )),
          body: tbv,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: float,
        ),
      ),
    );
  }

  @override
  dispose() {
    try {
      switch (widget.mode) {
        case exmMode:
          controller!.dispose();
          break;
      }

      super.dispose();
    } catch (e) {}
  }
}

class CbtBody extends StatefulWidget {
  final int qnum;
  final String data;
  final String course;
  final String mode;

  const CbtBody(
      {super.key,
      required this.qnum,
      required this.data,
      required this.course,
      required this.mode});

  @override
  State<CbtBody> createState() => _CbtBodyState();
}

class _CbtBodyState extends State<CbtBody> {
  Future<String>? qstn;

  late ContentData q_stack;

  int qmag = 0;
  int qnum_ = 1;
  int curr_qst = 0;
  List<Container> qnmbb = [];

  List<Container> optn = [];

  @override
  void initState() {
    super.initState();
    qnum_ = widget.qnum;
    q_stack = cbtQuestion();

    for (int i = 0; i < qmag; i++) {
      qnmbb.add(Qnum(i + 1, "", "", Colors.white));
    }
  }

  ContentData cbtQuestion() {
    List tlist = jsonDecode(widget.data);
    qmag = tlist.length;
    return ContentData.fromJson(tlist[qnum_ - 1]);
  }

  static const String nxt = "Next";
  static const String prv = "Previous";
  static const String btn = "Button";

  Container Qnum(int ques, String qstate, String mode, Color clr_) {
    switch (qstate) {
      /*
        case exm:
          break;
      */
    }

    return Container(
      key: Key("pp$ques"),
      decoration: BoxDecoration(
          color: clr_,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(3)),
      child: TextButton(
          onPressed: () {
            /*
            Container activeWidget =
                qnmbb.firstWhere((x) => x.key == "pp$ques");
            // activeWidget.color = Colors.yellow;

            */

            //expect(find.byWidget(childWidget), findsOneWidget);
            btnPress(btn, ques);
          },
          child: Text(
            ques.toString(),
            style: const TextStyle(
              fontSize: 10,
            ),
          )),
    );
  }

  static const String optna = "option_a";
  static const String optnb = "option_b";
  static const String optnc = "option_c";
  static const String optnd = "option_d";
  static const String optne = "option_e";

  // Container OptionCreed()
  // {
  //   return
  // }

  Column OptnStk(Map<String, String> data, String ans, String expl) {
    //List<Container> optnz = [];
    optn = [];

    String response = "";

    scripts.forEach((key, value) {
      if (key == widget.course) {
        value.forEach((key, value) {
          for (int i = 0; i < value.length; i++) {
            Map<String, Map<String, String>> cnnt = value[i];
            cnnt.forEach((key, value) {
              if (qnum_.toString() == key) {
                value.forEach((key, value) {
                  response = key;
                });
              }
            });
          }
        });
      }
    });

    log("My prior response $response");

    data.forEach((key, value) {
      String prefix = "";
      switch (key) {
        case optna:
          prefix = "A";
          break;
        case optnb:
          prefix = "B";
          break;
        case optnc:
          prefix = "C";
          break;
        case optnd:
          prefix = "D";
          break;
        case optne:
          prefix = "E";
          break;
      }
      if (prefix.isNotEmpty) {
        if (response == prefix) {
          optn.add(Opttn('$prefix. $value', prefix, ans, expl, Colors.yellow));
        } else {
          optn.add(Opttn('$prefix. $value', prefix, ans, expl, Colors.white));
        }
      }
    });

    return Column(
      children: [
        ListView.builder(
            itemCount: optn.length,
            padding: const EdgeInsets.all(8),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return optn[index];
            })
      ],
    );
  }

  Container Opttn(
      String optt, String choice, String ans, String expl, Color clr) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurStyle: BlurStyle.normal,
                blurRadius: 2,
                color: const Color.fromARGB(99, 158, 158, 158),
                offset: Offset.fromDirection(-1))
          ],
          color: clr,
          // border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(5),
      child: InkWell(
          onTap: () {
            scripts.forEach(
              (key, value) {
                if (key == widget.course) {
                  (value.isEmpty)
                      ? stackNewScript(
                          widget.course, qnum_.toString(), choice, ans, true)
                      : {
                          stackNewScript(widget.course, qnum_.toString(),
                              choice, ans, false)
                        };
                  String scr = jsonEncode(scripts);
                  log("prior:###$scr");
                }
              },
            );

            Container opt = Opttn(optt, choice, ans, expl, Colors.yellow);
            switch (choice) {
              case 'A':
                optn[0] = opt;
                break;
              case 'B':
                optn[1] = opt;
                break;
              case 'C':
                optn[2] = opt;
                break;
              case 'D':
                optn[3] = opt;
                break;
              case 'E':
                optn[4] = opt;
                break;
            }
            setState(() {});
          },
          child: TeXView(
              child: TeXViewDocument(optt,
                  style:
                      const TeXViewStyle(margin: TeXViewMargin.only(top: 5))))

          /*
        
        Html(
          data: optt,
        ),
        */

          ),
    );
  }

  Map<String, Map<String, String>> cnt(String choice, String correct) {
    Map<String, String> stkq = {choice: correct};
    return {qnum_.toString(): stkq};
  }

  void stackNewScript(
      String course, String qstno, String choice, String correct, bool new_) {
    //  course      curr_no     quest            option   correct
    Map<String, Map<String, List<Map<String, Map<String, String>>>>> scr = {};
    log("$qstno***$choice***$correct");
    (new_ == true) ? {log("A new map")} : {log("An existing map")};

    Map<String, Map<String, String>> stkq = cnt(choice, correct);

    String fgh = jsonEncode(stkq);
    log("loop stack:$fgh");

    List<Map<String, Map<String, String>>> currStt = [];
    Map<String, List<Map<String, Map<String, String>>>> crStk = {};

    scripts.forEach((key, value) {
      if (key == course) {
        if (value.isEmpty) {
          currStt.add(stkq);
          crStk.addEntries({qstno: currStt}.entries);
        } else {
          bool prz = false;
          int pos = -1;
          List<Map<String, Map<String, String>>> cr1 = [];
          value.forEach((key, value) {
            currStt = value;
            for (int i = 0; i < value.length; i++) {
              Map<String, Map<String, String>> cr2_ = value[i];
              cr2_.forEach((key, value) {
                if (key == qstno) {
                  log("Pres***$stkq");
                  prz = true;
                  pos = i;
                }
              });
            }
          });
          if (!prz) {
            currStt.add(stkq);
            crStk.addEntries({qstno: currStt}.entries);
            //  log("***append1$stt");
          } else {
            for (int i = 0; i < currStt.length; i++) {
              if (pos != i) {
                cr1.add(currStt[i]);
              } else {
                cr1.add(stkq);
              }
            }
            crStk.addEntries({qstno: cr1}.entries);
            String stt = jsonEncode(crStk);
            log("***append2$stt");
          }
        }

        scr.addEntries({course: crStk}.entries);
        String hhh = jsonEncode(scr);
        log("Iterate through:$hhh");
      } else {
        scr.addEntries({key: value}.entries);
      }
    });
    scripts = scr;

    bool stkkd = false;

    log("final stack:$scr");
  }

  Container Optionz(String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurStyle: BlurStyle.normal,
            blurRadius: 2,
            color: const Color.fromARGB(99, 158, 158, 158),
            offset: Offset.fromDirection(-1))
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {},
        child: Html(
          data: content,
        ),
      ),
    );
  }

  void btnPress(String task, int btnNo) {
    log("Tagged:  $btnNo");

    switch (task) {
      case nxt:
        qnum_ += 1;
        break;
      case prv:
        qnum_ -= 1;
        break;
      case btn:
        qnum_ = btnNo;
        break;
    }

    log("Prior: $curr_qst***");

    if (curr_qst != 0) {
      Container qn_ = Qnum(curr_qst, "qstate", "mode", Colors.white);
      qnmbb[curr_qst - 1] = qn_;
    }

    shade();
    //shdd();

    Container qn = Qnum(btnNo, "qstate", "mode", Colors.yellow);
    curr_qst = btnNo;

    log("final -- $btnNo # $btnNo");

    qnmbb[btnNo - 1] = qn;
    q_stack = cbtQuestion();

    setState(() {});
  }

  void shade() {
    try {
      scripts.forEach((key, value) {
        if (key == widget.course) {
          value.forEach((key, value) {
            for (int i = 0; i < value.length; i++) {
              Map<String, Map<String, String>> pr = value[i];
              String pp = "";
              pr.forEach((key, value) {
                if (key.isNotEmpty) {
                  pp += key;
                }
                //pp = int.tryParse(key) ?? 0;
                //
              });
              if (pp.isNotEmpty) {
                int qd = int.parse(pp);

                qnmbb[qd - 1] = Qnum(qd, "qstate", "mode",
                    const Color.fromARGB(255, 225, 239, 145));
                //  setState(() {});
              }
            }
          });
          //  Container qn = Qnum(int.parse(curr), "qstate", "mode", Colors.yellow);
        }
      });
    } catch (e) {
      log("Shade error:$e");
    }
  }

  // Container option_base()
  // {
  //   return Container(
  //               child: OptnStk(qst_data.optns, qst_data.ans, qst_data.ansmt)),
  // }

  Column castQuestion() {
    ContentData qstData = cbtQuestion();

    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 40, 15, 0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4,
                            offset: Offset(0, 1))
                      ]),
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Exam(qstTag: "$qnum_/$qmag", qst: qstData.qstn),
                  )),
            ),
            Container(
                child: OptnStk(qstData.optns, qstData.ans, qstData.ansmt)),
            (widget.mode == prfMode)
                ? Explanation(explanation: qstData.ansmt)
                : const Text(""),
            Container(
              margin: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (qnum_ < 2) ? Opacity(opacity: 0.0, child: prvs()) : prvs(),
                  (qnum_ > qmag - 1)
                      ? Opacity(opacity: 0.0, child: next())
                      : next()
                ],
              ),
            ),
            Container(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 40,
                            childAspectRatio: 3 / 2.5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: qmag,
                    itemBuilder: (BuildContext ctx, index) {
                      return qnmbb[index];
                      // return Qnum(qnmbb[index], "", "");
                    }))
          ],
        ),
      ],
    );
  }

  Text pageStatus(String statusMsg) {
    return Text(statusMsg);
  }

  Widget prvs() {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 134, 142),
          borderRadius: BorderRadius.circular(5)),
      height: 40,
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () async {
              if (qnum_ > 1) {
                int p = (curr_qst != 0) ? qnum_ - 1 : 1;

                btnPress(prv, p);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.keyboard_arrow_left),
                Text(
                  'Previous',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row next() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 70, 104),
              borderRadius: BorderRadius.circular(5)),
          height: 40,
          width: 130,
          child: TextButton(
            onPressed: () {
              if (qnum_ < qmag) {
                int p = (curr_qst != 0) ? qnum_ + 1 : 1;
                btnPress(nxt, p);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: castQuestion(),
    );
  }
}

class CbtTab extends StatelessWidget {
  const CbtTab({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        name,
        style: const TextStyle(
            color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
