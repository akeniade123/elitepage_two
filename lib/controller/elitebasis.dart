// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Components/attendee.dart';
import '../Components/classpane.dart';
import '../database/database_helper.dart';
import '../database/datafields.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';
import '../screens/common_widget.dart';
import '../screens/defaultdash.dart';
import 'fields.dart';
import 'navigation.dart';

Navigate nvg = Navigate();

Future<void> obtainDomain() async {
  Map<String, dynamic>? dtt;
  Map<String, Object> tagged = {
    "Essence": "access",
    "State": "specific_tsk",
    "Specific": "Router",
    "Table": "domains",
    "Rep":
        " d.id AS domain, name, f.pay_with_bank AS bank, f.currency AS currency, f.share AS playstore, contact, fb_sect, session, term",
    "Joint": " d INNER JOIN framework f on d.id = f.tag WHERE d.name = '$org_' "
  };
  try {
    dtt = await nvg.eliteApi(tagged, desig, sct, dmn, false, null);

    DatabaseHelper dbh = DatabaseHelper(table: appDtl);
    if (dtt!["status"]) {
      ServerResponse? svr = ServerResponse.fromJson(dtt);
      List data_ = svr.data;

      var item = data_[0];
      dbh.insertData(item);
    }
  } catch (e) {}
}

Future<List<Widget>>? obtainData(
    Map<String, Object> tag,
    String domain,
    String essence,
    String designation,
    String endgoal,
    String function,
    bool active,
    BuildContext context) async {
  List<Widget> rslts = [];
  nvg = Navigate();

  switch (function) {
    case server:
      Map<String, dynamic>? ressp = await nvg.eliteApi(
          tag, domain, "essence", designation, true, context);

      if (ressp!["status"]) {
        ServerResponse? svr = ServerResponse.fromJson(ressp);

        if (svr.status == true) {
          List data_ = svr.data;
          List dtt = [];

          switch (essence) {
            case subscr:
              TextEditingController itm_ = TextEditingController();
              TextEditingController dte_ = TextEditingController();
              TextEditingController des_ = TextEditingController();
              TextEditingController prc_ = TextEditingController();

              Map<Map<String, String>, TextEditingController> fields = {
                {txtEdt: itm}: itm_,
                {txtEdt: dte}: dte_,
                {txtEdt: des}: des_,
                {drpDwn: prc}: prc_
              };

              final GlobalKey<ScaffoldState> _scaffoldKey =
                  GlobalKey<ScaffoldState>();

              Modal(
                  context,
                  350,
                  formContent("Select a plan***", fields, prcTbl, "Subscribe",
                      context, _scaffoldKey));

              break;
            case aid:
              if (data_.isNotEmpty) {
                final now = DateTime.now();
                logger("The Time: $now");
              }

              break;

            case tpd:
              if (data_.isNotEmpty) {
                for (final item in data_) {
                  dtt.add(item[id_]);
                }

                String vvd = "Desale:${jsonEncode(dtt)}";
                logger(vvd);

                //NB: Rep and Joint aren't essential for this Server Request

                crsContents = DefaultDash(
                  essence: videos,
                  data: {
                    "Essence": "access",
                    "State": "specific_tsk",
                    "Specific": "getCollection",
                    "Table": "course_content",
                    "Sect": dtt,
                    "Rep":
                        " d.id AS domain, name, f.pay_with_bank AS bank, f.currency AS currency, f.share AS playstore, contact, fb_sect, session, term",
                    "Joint":
                        " d INNER JOIN framework f on d.id = f.tag WHERE d.name = 'ElitePage' "
                  },
                  title: '',
                  exec: '',
                  fltclr: const Color.fromARGB(0, 255, 255, 255),
                );
                /*

                crsContents = Videos(
                  essence: videos,
                  data: {
                    "Essence": "access",
                    "State": "specific_tsk",
                    "Specific": "getCollection",
                    "Table": "course_content",
                    "Sect": dtt,
                    "Rep":
                        " d.id AS domain, name, f.pay_with_bank AS bank, f.currency AS currency, f.share AS playstore, contact, fb_sect, session, term",
                    "Joint":
                        " d INNER JOIN framework f on d.id = f.tag WHERE d.name = 'ElitePage' "
                  },
                  title: '',
                  exec: adlct,
                  fltclr: bgmainclr,
                );
                */

                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(ccnLst);
                /*
                {
   "Essence":"access",
"State":"specific_tsk","Specific":"getCollection","Table":"course_content",
"Sect":["7", "8", "9"],
      "Rep":" d.id AS domain, name, f.pay_with_bank AS bank, f.currency AS currency, f.share AS playstore, contact, fb_sect, session, term",
      "Joint":" d INNER JOIN framework f on d.id = f.tag WHERE d.name = 'ElitePage' "
}
                */
              }
              break;
            case crsLne:
              final item = data_[0];

              switch (item["manifest"]) {
                case "1":
                  List dtsrl = jsonDecode(item[cnt]);
                  log("ContentSize***${dtsrl.length}");

                  for (int i = 0; i < dtsrl.length; i++) {
                    rslts.add(Course(id: i.toString(), content: dtsrl[i]));
                  }
                  break;
                case "2":
                  final tgh = jsonDecode(item[cnt]);
                  List dtsrl = tgh["Sections"];
                  for (int i = 0; i < dtsrl.length; i++) {
                    final sctx = dtsrl[i]["tag"];
                    final cmpx = dtsrl[i]["topics"];
                    rslts.add(Sect(
                      components: cmpx,
                      content: sctx,
                      endgoal: endgoal,
                    ));
                  }
                  break;
              }
              break;
            default:
              for (final item in data_) {
                switch (essence) {
                  case fManage:
                    rslts.add(ContentDisplay(
                        image: 'assets/images/pay.png',
                        imgsize: 50.0,
                        mainhead: item["purpose"],
                        purp: item["amount"],
                        description: item["description"]));
                    break;

                  case vFees:
                    rslts.add(ContentDisplay(
                        image: 'assets/images/pay.png',
                        imgsize: 50.0,
                        mainhead: item["purpose"],
                        purp: item["amount"],
                        description: item["description"]));
                    break;
                  case lectr:
                    rslts.add(ContentDisplay(
                        image: 'assets/images/sample.png',
                        imgsize: 50.0,
                        mainhead: item["keyword"],
                        purp: item["rating"],
                        description: item["note"]));
                    break;
                  case accD:
                    rslts.add(ContentDisplay(
                        image: 'assets/images/accm.png',
                        imgsize: 50.0,
                        mainhead: item["bank"],
                        purp: item["bank"],
                        description: item["account_no"]));
                    break;
                  case evnt:
                    rslts.add(ContentDisplay(
                        image: 'assets/images/event1.png',
                        imgsize: 50.0,
                        mainhead: item["bank"],
                        purp: item["bank"],
                        description: item["account_no"]));
                    break;
                  case prcTbl:
                    rslts.add(
                      ContentDisplay(
                        image: 'assets/images/expense1.png',
                        imgsize: 50.0,
                        mainhead: item["purpose"],
                        purp: item["amount"],
                        description: item["description"],
                      ),
                    );
                    break;

                  case dNote:
                    rslts.add(
                      const ContentDisplay(
                        image: 'assets/images/note.png',
                        imgsize: 50,
                        mainhead: 'Integration',
                        description:
                            'Definition, objectives, types, advantages and disadvantages',
                        purp: 'week 4',
                        dest: '',
                      ),
                    );
                    break;

                  case addcurr:
                    rslts.add(CurrViews(
                        topic: item["purpose"],
                        duration: item["amount"],
                        objective: item["description"]));
                    break;

                  case 'Attendance':
                    rslts.add(Attendee(
                        name: item['Candidate'],
                        matricNo: item['Matric_No'],
                        gender: item['Gender'],
                        presence: false,
                        matric_no: item['Subject']));
                    break;

                  //
                  //
                  //view profiles for teachers/students/parents
                  //
                  //

                  case 'StudentMt':
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Candidate"],
                        gender: item["Gender"],
                        phone: item['Contact'],
                        email: item['Email'],
                        essbtn: 'update result',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  case 'StudentVt':
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Candidate"],
                        gender: item["Gender"],
                        phone: item['Contact'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;
                  case vTeachers:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  case vChildren:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Candidate"],
                        gender: item["Gender"],
                        phone: item['Contact'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  case 'view children result':
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Candidate"],
                        gender: item["Gender"],
                        phone: item['Contact'],
                        email: item['Email'],
                        essbtn: 'view result',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  case parents:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: 'Tag child/ward',
                        addpurp: 'Children/Wards',
                        addedid: '6353636',
                        addednm: 'adigun dolapo',
                        addpic: 'assets/images/blades.jpg',
                      ),
                    );
                    break;

                  case vParent:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: 'Tag child/ward',
                        addpurp: 'Children/Wards',
                        addedid: '6353636',
                        addednm: 'adigun dolapo',
                        addpic: 'assets/images/blades.jpg',
                      ),
                    );
                    break;
                  case sManage:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;
                  case vStudent:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;
                  case tManage:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'View Profile',
                        essdest: prof,
                        addnm: 'Assign course',
                        addpurp: 'Course',
                        addedid: 'FED112',
                        addednm: 'educational studies',
                        addpic: 'assets/images/course.png',
                      ),
                    );
                    break;

                  case cNewUsr:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'Select',
                        essdest: '',
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  //
                  //
                  //result management
                  //

                  case rManage:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'update result',
                        essdest: '/updateresult',
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  case vResult:
                    rslts.add(
                      IndividualList(
                        sClass: '',
                        image: 'assets/images/blades.jpg',
                        name: item["Name"],
                        gender: item["Gender"],
                        phone: item['Phone'],
                        email: item['Email'],
                        essbtn: 'view result',
                        essdest: '',
                        addnm: '',
                        addpurp: '',
                        addedid: '',
                        addednm: '',
                        addpic: 'assets/images/line.png',
                      ),
                    );
                    break;

                  case clsmgt:
                    rslts.add(
                        BigButton(lcname: item['Identity_tag'], lcn: stds));
                    break;
                  case clsvw:
                    rslts.add(
                        BigButton(lcname: item['Identity_tag'], lcn: stdsv));
                    break;

                  case prtcCbt:
                    rslts.add(
                        BigButton(lcname: item['Identity_tag'], lcn: pCbt));
                    break;

                  case crrMgt:
                    rslts.add(
                        BigButton(lcname: item['Identity_tag'], lcn: addcurr));
                    break;
                  case crlmVw:
                    rslts.add(
                        BigButton(lcname: item['Identity_tag'], lcn: addcurrv));
                    break;

                  case clsRslt:
                    rslts.add(
                        BigButton(lcname: item['Identity_tag'], lcn: vrResult));
                    break;
                  case sct:
                    if (item[sct.toLowerCase()] != "Needs Validation") {
                      rslts.add(
                        ClassPane(
                          name: item[sct.toLowerCase()],
                          essence: essence,
                          identifier: item[avl],
                          endgoal: endgoal,
                          active: active,
                          phase: item[phs_],
                        ),
                      );
                    }
                    break;

                  case sct_e:
                    rslts.add(ClassPane(
                      name: item['Identity_tag'],
                      essence: essence,
                      identifier: item[avl],
                      endgoal: endgoal,
                      active: active,
                      phase: phs_,
                    ));
                    break;

                  case bds:
                    rslts.add(
                      ClassPane(
                        name: item[nmm.toLowerCase()],
                        essence: essence,
                        identifier: item[id_],
                        endgoal: "",
                        active: active,
                        phase: "",
                      ),
                    );

                    break;

                  case facI:
                    rslts.add(
                      ClassPane(
                        name: item[nm],
                        essence: essence,
                        identifier: item[id_],
                        endgoal: "",
                        active: active,
                        phase: "",
                      ),
                    );

                    break;

                  case assc:
                    rslts.add(
                      ClassPane(
                        name: item["tag"],
                        essence: essence,
                        identifier: item[id_],
                        endgoal: "",
                        active: active,
                        phase: "",
                      ),
                    );
                    break;
                  case crsTbl:
                    rslts.add(Decker(
                        code: item[cdd],
                        lcname: item[ttl],
                        lcn: essence,
                        identity: item[id_]));
                    break;
                  case classes:
                    if (item[sct.toLowerCase()] != "Needs Validation") {
                      rslts.add(
                        ClassPane(
                          name: item[sct.toLowerCase()],
                          essence: essence,
                          identifier: item[avl],
                          endgoal: '',
                          phase: phs_,
                          active: active,
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
                      phase: phs_,
                      active: active,
                    ));
                    break;
                  case sct_vs:
                    rslts.add(ClassPane(
                      name: item[sct.toLowerCase()],
                      essence: essence,
                      identifier: item[avl],
                      endgoal: '',
                      active: active,
                      phase: phs_,
                    ));
                    break;

                  case cls_tg:
                    rslts.add(ClassPane(
                      name: item['Identity_tag'],
                      essence: essence,
                      endgoal: '',
                      active: active,
                      phase: phs_,
                    ));
                    break;
                  case classes4cur:
                    if (item[sct.toLowerCase()] != "Needs Validation") {
                      rslts.add(ClassPane(
                        name: item[sct.toLowerCase()],
                        essence: essence,
                        identifier: item[avl],
                        endgoal: '',
                        active: active,
                        phase: phs_,
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
                        active: active,
                        phase: phs_,
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
                        active: active,
                        phase: phs_,
                      ));
                    }
                    break;
                }
              }
              break;
          }
        }
      } else {
        try {
          String mf = ressp["message"];

          if (mf.contains("data at the moment")) {
            switch (essence) {
              case aid:
                Navigator.of(context).pop();
                dialogResponse(
                    context,
                    "You currently don't have an active subscription to this content, kindly subscribe",
                    subscr,
                    subscr);

                break;
              case tpd:
                customSnackBar(context,
                    "Oops... Your requested content is currently unavailable");

                Navigator.of(context).pop();

                break;
            }
          } else {
            switch (mf) {
              case "408":
                statusCode = true;
                break;
            }
          }
          if (mf.isNotEmpty) {
            switch (essence) {
              case mycl:
                dialogResponse(
                    context,
                    "You've not been assigened any class as a class teacher yet",
                    "Go back",
                    essence);
                break;
              default:
                rslts.add(Text(mf));
                break;
            }
          }
        } catch (e) {}
      }
      break;

    case resident:
      switch (essence) {
        case stRsM:
          rslts.add(ClassPane(
              name: mycl,
              essence: mycl,
              endgoal: endgoal,
              phase: phase,
              active: active));

          rslts.add(ClassPane(
              name: mysb,
              essence: mysb,
              endgoal: endgoal,
              phase: phase,
              active: active));

          break;

        case cCbt:
          rslts.add(ClassPane(
            name: "Create New CBT",
            essence: essence,
            identifier: new_,
            endgoal: '',
            active: active,
            phase: phs_,
          ));
          rslts.add(ClassPane(
            name: "Import CBT Questions",
            essence: essence,
            identifier: import,
            endgoal: '',
            active: active,
            phase: phs_,
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
                active: active,
                phase: dbb[key],
              ));
            }
          } else {}
          break;
      }

      break;
  }

  switch (endgoal) {
    case crtSct:
    case crtSct_1:
      TextEditingController ttl_ = TextEditingController();
      rslts.add(TextField(
        controller: ttl_,
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        textCapitalization: TextCapitalization.sentences,
        textAlignVertical: const TextAlignVertical(y: 1),
        decoration: InputDecoration(
          hintText: sct,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: bgmainclr),
          ),
        ),
      ));

      rslts.add(ElevatedButton(
          onPressed: () async {
            Map<String, dynamic> mnfst = {"section": ttl_.text};
            Map<String, dynamic> entries = {
              "phase": "1",
              "availability": "1",
              "created_at": "",
              "update_time": ""
            };

            Map<String, dynamic>? ressp = await nvg.entry("section", mnfst,
                entries, mnfst, communal, essence, "", true, crt_, context);

            if (ressp!["status"]) {
              ServerResponse? svr = ServerResponse.fromJson(ressp);
              Object obj = svr.msg;

              Map<String, dynamic> msg_ = obj as Map<String, dynamic>;

              customSnackBar(context, msg_['message']!);

              Navigator.of(context).pop();
            }
          },
          child: const Text("Add Section")));
      break;
    case crSess:
    case crSess_1:
      /*
        Session_ID	
        Session	
        session_starts	
        session_end	
        created_at	
        update_time	
    */
      final now = DateTime.now();
      var selectedDate;
      var initialDate = DateTime.now();
      final pickDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(now.year, now.month, now.day),
        lastDate: DateTime(2050),
      );
      if (pickDate == null) {
        //return;
      }
      // initialDate = _pickDate!;

      /*
        setState(() {
          selectedDate = _pickDate;
          
        });
        */
      break;
  }
  return rslts;
}

FutureBuilder<List<Widget>> castData(Future<List<Widget>>? futureclasses,
    String function, String essence, String endgoal) {
  return FutureBuilder(
      future: futureclasses,
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
            Widget basic = const Text("No Data");
            switch (function) {
              case server:
                basic = const NoInternet();
                break;
            }
            return basic;
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

Future<String>? dataEntry(
    String table,
    Map<String, String> mnfst,
    Map<String, String> entr,
    Map<String, String> cnstr,
    String domain,
    String endgoal,
    BuildContext context) async {
  Navigate nvg = Navigate();

  Map<String, Object> tag = {
    "Essence": table,
    "State": "create",
    "Manifest": mnfst,
    "Entries": entr,
    "Constraint": cnstr
  };

  Map<String, dynamic>? rqst =
      await nvg.eliteApi(tag, domain, table, "", true, context);

  if (rqst!["status"]) {
    Map<String, dynamic> msgg = rqst["message"];

    customSnackBar(context, msgg["message"]!);
  } else {
    customSnackBar(context, rqst["message"]!);
  }

  return "hello";
}

Future<String>? svrRequest(Map<String, Object> tag, String essence,
    String endgoal, BuildContext context) async {
  Navigate nvg = Navigate();
  Map<String, dynamic>? rqst =
      await nvg.eliteApi(tag, desig, essence, "", true, context);

  try {
    customSnackBar(context, rqst!["message"]);
  } catch (e) {}

  return "hello";
}
