// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:developer';
import '../database/datafields.dart';
import '../models/env.dart';
import '../screens/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Controller/filehandler.dart';
import '../models/global_strings.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../Controller/navigation.dart';
import '../../models/endpoints.dart';
import '../screens/processionAccess.dart';
import '../views/studentView/cbtDisplay.dart';

class BoardTab extends StatefulWidget {
  final Map<String, Object> tagged, tagged2;
  final name,
      destination,
      subname,
      essence,
      essence2,
      essence3,
      essence4,
      essence5,
      endgoal,
      endgoal2,
      endgoal3,
      endgoal4,
      endgoal5,
      essence6,
      endgoal7,
      essence7,
      endgoal6,
      title,
      title2,
      view_,
      color,
      icon;
  const BoardTab({
    super.key,
    required this.tagged,
    this.name,
    this.destination,
    this.subname,
    this.color,
    this.icon,
    this.essence,
    this.endgoal,
    this.title,
    this.view_,
    required this.tagged2,
    this.essence2,
    this.endgoal2,
    this.title2,
    this.essence3,
    this.endgoal3,
    this.essence4,
    this.endgoal4,
    this.essence5,
    this.endgoal5,
    this.essence6,
    this.endgoal6,
    this.endgoal7,
    this.essence7,
  });

  @override
  State<BoardTab> createState() => _BoardTabState();
}

class _BoardTabState extends State<BoardTab> {
  final _decoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
          color: Color.fromARGB(106, 158, 158, 158),
          blurRadius: 3,
          offset: Offset(0, 5))
    ],
  );
  Future<List<Widget>>? _futureclasses;
  late Navigate nvg;
  late Endpoint enp;
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    nvg = Navigate();
    enp = Endpoint();

/*
    switch (widget.destination) {
      default:
        _futureclasses =
            obtainData(widget.tagged, widget.essence, widget.endgoal);
        break;
    }
    */
  }

/*
  Future<List<Widget>>? obtainData(Map<String, Object> tag, String essence,
      String endgoal, String function) async {
    List<Widget> rslts = [];
    nvg = Navigate();

    switch (function) {
      case server:
        Map<String, dynamic>? ressp =
            await nvg.eliteApi(tag, desig, "essence", true, context);

        if (ressp!["status"]) {
          ServerResponse? svr = ServerResponse.fromJson(ressp);

          if (svr.status == true) {
            List data_ = svr.data;

            for (final item in data_) {
              switch (essence) {
                case sct:
                  if (item[sct.toLowerCase()] != "Needs Validation") {
                    rslts.add(
                      ClassPane(
                        name: item[sct.toLowerCase()],
                        essence: essence,
                        identifier: item[avl],
                        endgoal: '',
                        active: active,
                        phase: '',
                      ),
                    );
                  }
                  break;
                case classes:
                  if (item[sct.toLowerCase()] != "Needs Validation") {
                    rslts.add(
                      ClassPane(
                        name: item[sct.toLowerCase()],
                        essence: essence,
                        identifier: item[avl],
                        endgoal: '',
                        phase: '',
                      ),
                    );
                  }
                  break;
                case pCbt:
                  rslts.add(ClassPane(
                    name: item[sct.toLowerCase()],
                    essence: essence,
                    identifier: item[avl],
                    endgoal: '',
                    phase: '',
                  ));

                  break;
                case classes4cur:
                  if (item[sct.toLowerCase()] != "Needs Validation") {
                    rslts.add(ClassPane(
                      name: item[sct.toLowerCase()],
                      essence: essence,
                      identifier: item[avl],
                      endgoal: '',
                      phase: '',
                    ));
                  }
                  break;
                case classes4curv:
                  if (item[sct.toLowerCase()] != "Needs Validation") {
                    rslts.add(ClassPane(
                      name: item[sct.toLowerCase()],
                      essence: essence,
                      identifier: item[avl],
                      endgoal: '',
                      phase: '',
                    ));
                  }
                  break;

                case classes4resltv:
                  if (item[sct.toLowerCase()] != "Needs Validation") {
                    rslts.add(ClassPane(
                      name: item[sct.toLowerCase()],
                      essence: essence,
                      identifier: item[avl],
                      endgoal: '',
                      phase: '',
                    ));
                  }
                  break;
              }
            }
          }
        }
        break;

      case resident:
        switch (essence) {
          case cCbt:
            rslts.add(ClassPane(
              name: "Create New CBT",
              essence: essence,
              identifier: new_,
              endgoal: '',
              phase: '',
            ));
            rslts.add(ClassPane(
              name: "Import CBT Questions",
              essence: essence,
              identifier: import,
              endgoal: '',
              phase: '',
            ));
            break;
        }
        break;
      case repository:
        switch (essence) {
          case cCbt:
            DatabaseHelper dbh = DatabaseHelper(table: endgoal);
            if (await dbh.queryRowCount() > 0) {
              List<Map<String, dynamic>> db = await dbh.queryAllRows();
              for (int i = 0; i < db.length; i++) {
                Map<String, dynamic> dbb = db[i];
                rslts.add(ClassPane(
                  name: dbb[ttl],
                  essence: essence,
                  identifier: open,
                  endgoal: dbb[flln],
                  phase: dbb[key],
                ));
              }
            } else {}
            break;
        }

        break;
    }

    return rslts;
  }

  */

  FutureBuilder<List<Widget>> classesResult() {
    return FutureBuilder(
        future: _futureclasses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget>? data_ = snapshot.data;
            int size = data_!.length;
            basedlg = context;

            if (size > 0) {
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
            } else {
              return const NoInternet();
            }
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("an error just occurred, please try again"));
          }
          return Center(
            child: LoadingAnimationWidget.flickr(
                leftDotColor: Colors.blue, rightDotColor: bgmainclr, size: 30),
          );
        });
  }

/*
  void modalPane(String title, Map<String, Object> tag, String essence,
      String endgoal, String function) {
    _futureclasses = obtainData(tag, essence, endgoal, function);
    drwdlg = context;
    Modal(
        context,
        320,
        SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: SizedBox(
                width: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Container(
                          child: (_futureclasses == null)
                              ? const Text(" No Data Yet")
                              : classesResult()),
                    ]),
              )),
        ));
  }
*/

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: _decoration,
        child: TextButton(
          onPressed: () async {
            switch (widget.destination) {
              case qrBks:
                String hm = await loadAssetString("assets/content/home.json");
                String mth =
                    await loadAssetString("assets/content/indices.json");
                String cm =
                    await loadAssetString("assets/content/commerce.json");
                String ag =
                    await loadAssetString("assets/content/agric_sc_26.json");
                cbtStack = {
                  "Home Economics": hm,
                  "Mathematics": mth,
                  "Commerce": cm,
                  "Agricultural Science": ag
                };

                cbtcontent = CBTDisplay(
                    duration: const Duration(hours: 1, minutes: 27),
                    contents: cbtStack,
                    mode: exmMode,
                    cog: 0);

                Navigator.of(context).pushNamed(cbtRoute);
                break;
              case stRsM:
                log("We are writing this code");
                navEss = widget.destination;
                modalPane(widget.title, widget.tagged2, desig, stRsM, stRsM,
                    widget.endgoal, resident, _futureclasses, true, context);

                break;
              case banky:
              case archv:
              case pCbt:
                navEss = widget.destination;
                modalPane(widget.title, widget.tagged2, desig, widget.essence,
                    sct, widget.endgoal, server, _futureclasses, true, context);
                break;

              case srmanageclist:
                modalPane(
                    "Sections",
                    widget.tagged2,
                    desig,
                    widget.essence2,
                    sct,
                    widget.endgoal2,
                    server,
                    _futureclasses,
                    true,
                    context);
                break;

              case vrResult:
                modalPane(
                    "Sections",
                    widget.tagged2,
                    desig,
                    widget.essence5,
                    sct,
                    widget.endgoal5,
                    server,
                    _futureclasses,
                    true,
                    context);

                break;

              case crmanagec:
                modalPane(
                    "Sections",
                    widget.tagged2,
                    desig,
                    widget.essence3,
                    sct,
                    widget.endgoal3,
                    server,
                    _futureclasses,
                    true,
                    context);

                break;
              case crmanagecv:
                modalPane(
                    widget.title,
                    widget.tagged2,
                    desig,
                    widget.essence4,
                    sct,
                    widget.endgoal4,
                    server,
                    _futureclasses,
                    true,
                    context);
                break;
              case crsubj:
                modalPane(
                    widget.title,
                    widget.tagged2,
                    desig,
                    widget.essence7,
                    sct,
                    widget.endgoal7,
                    server,
                    _futureclasses,
                    true,
                    context);
                break;

              case lectr:
                courseReview = const ProcessionAccess(
                  essence: lectr,
                  data: {
                    "Essence": "course_content",
                    "State": "read_expl",
                    "Manifest": {"access_id": "2"}
                  },
                  title: 'My Channel',
                  exec: 'Add Content',
                  endgoal: '',
                );
                Navigator.of(context).pushNamed(widget.destination);
                break;
              case qstbnk:
                modalPane("My question bank", widget.tagged2, desig, cCbt, sct,
                    ttcnt, repository, _futureclasses, true, context);
                break;
              case cCbt:
                log("This is where I am...");
                modalPane(cbtq, widget.tagged2, desig, cCbt, sct, ttcnt,
                    resident, _futureclasses, true, context);
                break;
              default:
                Navigator.of(context).pushNamed(widget.destination);
                break;
            }
            //
          },
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: SvgPicture.asset(
                      widget.icon,
                      width: 45,
                      // ignore: deprecated_member_use
                      color: widget.color,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: widget.color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 2),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.subname,
                      style: const TextStyle(
                        // overflow: TextOverflow.ellipsis,
                        color: Colors.grey, overflow: TextOverflow.fade,
                        fontSize: 12,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
