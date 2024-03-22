// ignore_for_file: unnecessary_import, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, unused_import

import 'dart:developer';
import 'dart:io';

import '../Components/drawerSec.dart';
import '../models/env.dart';
import '../screens/common_widget.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Components/classpane.dart';
import '../../Controller/navigation.dart';
import '../../models/endpoints.dart';
import '../../models/global_strings.dart';
import '../../models/server_response.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Controller/fields.dart';
import 'Components/expandlist.dart';
import 'database/datafields.dart';

const mymss = 'gdgdgdgdgd';

class DrawerScreen extends StatefulWidget {
  final Map<String, Object> tagged;
  final List<String> pane;
  final String essence, endgoal, title, view_, destination;
  final GlobalKey<ScaffoldState> ctx_key;
  DrawerScreen(
      {Key? key,
      required this.ctx_key,
      required this.tagged,
      required this.essence,
      required this.endgoal,
      required this.title,
      required this.view_,
      required this.destination,
      required this.pane})
      : super(key: drwKey);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerScreenState createState() => _DrawerScreenState();
}

GlobalKey<_DrawerScreenState> drwKey = GlobalKey();

class _DrawerScreenState extends State<DrawerScreen> {
  Future<List<Widget>>? _futureclasses;
  late Navigate nvg;
  late Endpoint enp;

  bool usdt = false;

  @override
  void initState() {
    super.initState();
    usdt = false;

    nvg = Navigate();
    enp = Endpoint();
  }

  Future<void> setUser() async {
    setState(() {
      usdt = true;
    });
  }

  Future<List<Widget>>? obtainData(Map<String, Object> tag, String essence,
      String endgoal, bool active) async {
    List<Widget> rslts = [];

    nvg = Navigate();
    ServerResponse? svr =
        await nvg.getEliteApi(tag, desig, "essence", "", true, context);
    List data_ = svr!.data;

    for (final item in data_) {
      switch (essence) {
        case sct:
          if (item[sct.toLowerCase()] != "Needs Validation") {
            rslts.add(ClassPane(
                name: item[sct.toLowerCase()],
                essence: essence,
                identifier: item[avl],
                endgoal: widget.endgoal,
                active: active,
                phase: item[phs_]));
          }
          break;

        case sct_vs:
          rslts.add(ClassPane(
            name: item[sct.toLowerCase()],
            essence: essence,
            identifier: item[avl],
            endgoal: '',
            active: active,
            phase: '',
          ));
          break;

        case sct_e:
          rslts.add(ClassPane(
            name: item['Identity_tag'],
            essence: essence,
            identifier: item[avl],
            endgoal: widget.endgoal,
            active: active,
            phase: phase,
          ));
          break;

        case cls_tg:
          rslts.add(ClassPane(
            name: item['Identity_tag'],
            essence: essence,
            endgoal: '',
            active: active,
            phase: '',
          ));
          break;
      }
    }
    return rslts;
  }

  FutureBuilder<List<Widget>> classesResult() {
    return FutureBuilder(
        future: _futureclasses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget>? data_ = snapshot.data;
            int size = data_!.length;

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: size,
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return data_[index];
                      })
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return NoInternet();
          }

          return Center(
            child: LoadingAnimationWidget.flickr(
                leftDotColor: Colors.blue, rightDotColor: bgmainclr, size: 30),
          );
        });
  }

  TextStyle boldTextStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 24);

  late int isSelected = 0;
  int index = 0;

  ElevatedButton home() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/');
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 6, 43, 73)),
      child: const Icon(
        Icons.home,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // const String logout = 'context';

    drwdlg = context;

    try {
      if (ussr_.Unique_ID.isNotEmpty) {
        usdt = true;
      }
      // ignore: empty_catches
    } catch (e) {}

    // switch (ussr_.Category) {
    //   case '1':
    //     return ElevatedButton(onPressed: () {}, child: Text('data'));   b
    // }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 0),
          child: Container(
            height: 40,
            color: bgmainclr,
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    profPic != null
                                        ? Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: FileImage(
                                                  File(profPic!.path),
                                                  scale: 80),
                                            ),
                                          )
                                        : SvgPicture.asset(
                                            'assets/svg/user1.svg',
                                            height: 85,
                                          ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    (!usdt)
                                        ? Text("")
                                        : Text(ussr_.Name,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 6, 43, 73),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                    (!usdt)
                                        ? Text("")
                                        : Text(ussr_.Unique_ID,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ))
                                  ]),
                              onTap: () {
                                Navigator.of(context).pushNamed(prof);
                              },
                            ),
                            Row(
                              children: [
                                (appStatus == prod) ? Text("") : home(),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/notification');
                                  },
                                  iconSize: 30,
                                  icon: SvgPicture.asset(
                                      'assets/svg/notification.svg'),
                                  color: Colors.black,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 130, child: Divider()),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            switch (widget.destination) {
                              case banky:
                                Navigator.of(context).pop();
                                modalPane(
                                    widget.title,
                                    widget.tagged,
                                    desig,
                                    widget.essence,
                                    sct,
                                    accStore,
                                    server,
                                    _futureclasses,
                                    true,
                                    context);

                              /*
                                Modal(
                                    context,
                                    300,
                                    SingleChildScrollView(
                                      child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 5, 0),
                                          child: SizedBox(
                                            width: 350,
                                            child: Column(
                                                mainAxisAlignment:›ﬁ›
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(widget.title),
                                                  Container(
                                                      child:
                                                          (_futureclasses == null)
                                                              ? const Text(
                                                                  " No Data Yet")
                                                              : classesResult()),
                                                ]),
                                          )),
                                    ));
                            
                            */
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      'assets/svg/qsbank.svg',
                                      // ignore: deprecated_member_use
                                      color: const Color.fromARGB(
                                          255, 6, 43, 73))),
                              const Text(
                                accStore,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 6, 43, 73)),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(sTodo);
                          },
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      'assets/svg/todo1.svg',
                                      height: 32,
                                      // ignore: deprecated_member_use
                                      color: const Color.fromARGB(
                                          255, 6, 43, 73))),
                              const Text(
                                "Todo List",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 6, 43, 73)),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),

                      /*
                 
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(sCalendar);
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  'assets/svg/organiser.svg',
                                  height: 25,
                                  color:
                                      const Color.fromARGB(255, 6, 43, 73))),
                          const Text(
                            "Calendar",
                            style: TextStyle(
                                color: Color.fromARGB(255, 6, 43, 73)),
                          ),
                        ],
                      )),
                  
                  */

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(pndng);
                          },
                          child: Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      'assets/svg/pending.svg',
                                      height: 30,
                                      color: const Color.fromARGB(
                                          255, 6, 43, 73))),
                              const Text(
                                "Pendings",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 6, 43, 73)),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),

                      /*
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(videos);
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset('assets/svg/video.svg',
                                  width: 30,
                                  color:
                                      const Color.fromARGB(255, 6, 43, 73))),
                          const Text(
                            "General Lectures",
                            style: TextStyle(
                                color: Color.fromARGB(255, 6, 43, 73)),
                          ),
                        ],
                      )),
                  */

                      const SizedBox(
                        height: 20,
                      ),
                      (!lone)
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                TextEditingController pin_ =
                                    TextEditingController();
                                Map<Map<String, String>, TextEditingController>
                                    txt = {
                                  {txtEdt: pin}: pin_
                                };
                                serverEntry(prm, txt, prm, sbm, context,
                                    widget.ctx_key);
                              },
                              child: Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                          'assets/svg/promo.svg',
                                          width: 30,
                                          // ignore: deprecated_member_use
                                          color: const Color.fromARGB(
                                              255, 6, 43, 73))),
                                  const Text(
                                    "Promo Voucher",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 6, 43, 73)),
                                  ),
                                ],
                              ))
                          : const SizedBox(width: 10),
                      DrawerSection(),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(width: 130, child: Divider()),
                      const SizedBox(
                        height: 10,
                      ),
                      (usdt)
                          ? SingleChildScrollView(
                              child: ExpansionPanelList(
                                expansionCallback: (i, isOpen) {
                                  setState(() {
                                    if (index == 0) {
                                      index = -1;
                                    } else {
                                      index = 0;
                                    }
                                  });
                                },
                                animationDuration: const Duration(seconds: 1),
                                elevation: 2,
                                children: [
                                  ExpansionPanel(
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                        leading: SvgPicture.asset(
                                          'assets/svg/business.svg',
                                          height: 30,
                                          // ignore: deprecated_member_use
                                          color: const Color.fromARGB(
                                              255, 6, 43, 73),
                                        ),
                                        title: const Text(
                                          'Academics',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 6, 43, 73)),
                                        ),
                                      );
                                    },
                                    canTapOnHeader: true,
                                    body: ExpandList(
                                      array: widget.pane,
                                    ),
                                    isExpanded: index == -1,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(width: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(width: 130, child: Divider()),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TextButton(
                              //   onPressed: () {
                              //     Navigator.of(context).pushNamed(fbMsg);
                              //   },
                              //   child: const Row(
                              //     children: [
                              //       Icon(Icons.settings_outlined,
                              //           color: Color.fromARGB(255, 6, 43, 73)),
                              //       Text(
                              //         ' Settings',
                              //         style: TextStyle(
                              //             color: Color.fromARGB(255, 6, 43, 73)),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // (!lone)
                              //     ? TextButton(
                              //         onPressed: () {
                              //           Navigator.of(context).pop();
                              //           Modal(
                              //               context,
                              //               300,
                              //               Column(
                              //                 children: const [
                              //                   BigButton(
                              //                     lcname: 'Faculty',
                              //                     lcn: fac,
                              //                   ),
                              //                   BigButton(
                              //                     lcname: 'Body',
                              //                     lcn: bdy_,
                              //                   ),
                              //                   BigButton(
                              //                     lcname: 'Favourites',
                              //                     lcn: fav,
                              //                   )
                              //                 ],
                              //               ));
                              //         },
                              //         child: Row(
                              //           children: [
                              //             SvgPicture.asset(
                              //                 'assets/svg/create.svg',
                              //                 // ignore: deprecated_member_use
                              //                 color: Color.fromARGB(
                              //                     255, 6, 43, 73)),
                              //             Text(
                              //               'Preferences',
                              //               style: TextStyle(
                              //                   color: Color.fromARGB(
                              //                       255, 6, 43, 73)),
                              //             )
                              //           ],
                              //         ),
                              //       )
                              //     : Text(""),
                              (!lone)
                                  ? TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(creatorReq);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/virtual.svg',
                                              // ignore: deprecated_member_use
                                              color: Color.fromARGB(
                                                  255, 6, 43, 73)),
                                          Text(
                                            ' Become a tutor',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 6, 43, 73)),
                                          )
                                        ],
                                      ),
                                    )
                                  : Text(""),

                              TextButton(
                                onPressed: () {
                                  if (Platform.isAndroid || Platform.isIOS) {
                                    final appId = Platform.isAndroid
                                        ? 'YOUR_ANDROID_PACKAGE_ID'
                                        : 'YOUR_IOS_APP_ID';
                                    final url = Uri.parse(
                                      Platform.isAndroid
                                          ? "market://details?id=$appId"
                                          : "https://apps.apple.com/app/id$appId",
                                    );
                                    launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/svg/upd.svg',
                                        // ignore: deprecated_member_use
                                        color: Color.fromARGB(255, 6, 43, 73)),
                                    Text(
                                      'Check for update',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 6, 43, 73)),
                                    )
                                  ],
                                ),
                              ),

                              (!lone)
                                  ? TextButton(
                                      onPressed: () {
                                        var tagged = const {
                                          "Essence": "Section",
                                          "State": "read_expl",
                                          "Manifest": {avl: "1"}
                                        };
                                        Navigator.of(context).pop();
                                        modalPane(
                                            pref,
                                            tagged,
                                            desig,
                                            widget.essence,
                                            sct,
                                            pref,
                                            server,
                                            _futureclasses,
                                            true,
                                            context);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/create.svg',
                                              // ignore: deprecated_member_use
                                              color: Color.fromARGB(
                                                  255, 6, 43, 73)),
                                          Text(
                                            pref,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 6, 43, 73)),
                                          )
                                        ],
                                      ),
                                    )
                                  : Text(""),

                              (!lone)
                                  ? TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Modal(
                                            context,
                                            170,
                                            Column(
                                              children: const [
                                                BigButton(
                                                  lcname: 'Contents',
                                                  lcn: lectrr,
                                                ),
                                                BigButton(
                                                  lcname: 'Questions',
                                                  lcn: cCbt,
                                                )
                                              ],
                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svg/create.svg',
                                              // ignore: deprecated_member_use
                                              color: Color.fromARGB(
                                                  255, 6, 43, 73)),
                                          Text(
                                            'My Channel',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 6, 43, 73)),
                                          )
                                        ],
                                      ),
                                    )
                                  : Text(""),

                              TextButton(
                                onPressed: () {
                                  elucidate = const LearnMore(
                                    image: 'assets/images/learnmore.png',
                                    click: 'Leaderboard',
                                    faqQst: 'Our Core Value:',
                                    faqAns:
                                        'ElitePage as a multimedia learning platform raise geniuses through mastery with comprehensive video lessons by scholars, Computer based test for learners with over 50,000 Questions in bank on UTME, WASSCE, JSCE, Basic Education Contents,  Undergraduate Courses, Professional Courses and lots more... \nContent tool for tutors and Educationists to implement real time CBT for anticipated audience... \n \n   ElitePage for schools is 100% free of charge to manage daily routines ranging from Result collation, Inventory management, Student Academic Records, Parental feedback and lots more.... \n No hidden charges, \nkindly visit www.elitepage.ng/schoools to get the app customised specifically for your school within 72hours.... \n\n    Are you competent enough to monetise your intellectual constructs as a teacher? If yes? you can earn big monthly with royalty by producing intellectual content as a teacher ElitePage is hinged upon raising geniuses through mastery thereby organises weekly national contest with great prizes being won on weekly bases worth ood fortune',
                                    heading: 'About US',
                                  );

                                  Navigator.of(context).pushNamed(learnmore);
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.read_more_rounded,
                                        color: Color.fromARGB(255, 6, 43, 73)),
                                    Text(
                                      ' About us',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 6, 43, 73)),
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  dialogResponse(
                                      context,
                                      'Are you sure you want to log out?',
                                      'Logout',
                                      logout);

                                  // Navigate().LogOut(context);
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.logout_rounded,
                                        color: Colors.red),
                                    Text(
                                      ' Log out',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          )
        ]),
      ),
    );
  }
}

Future<void> drwUser() async {
  try {
    await drwKey.currentState!.setUser();
  } catch (e) {
    log("message: $e");
  }
}

class SampleListModel {
  Widget? leading;
  String? title;
  String? subTitle;
  Widget? trailing;
  IconData? icon;
  IconData? alternateIcon;
  Function? onTap;
  Color? colors;
  Widget? launchWidget;

  SampleListModel(
      {this.leading,
      this.title,
      this.subTitle,
      this.colors,
      this.icon,
      this.alternateIcon,
      this.trailing,
      this.onTap,
      this.launchWidget});
}
