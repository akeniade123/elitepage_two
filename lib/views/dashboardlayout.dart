// ignore: prefer_typing_uninitialized_variables

// ignore_for_file: empty_catches, unnecessary_import

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import '../Controller/elitebasis.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/svg.dart';

import '../Components/drawerSec.dart';
import '../Components/profbtnloader.dart';
import '../Controller/fields.dart';

import '../Components/progress.dart';
import '../drawer.dart';
import 'package:flutter/material.dart';

import '../Components/dashboardpa.dart';
import '../Components/dashnotifier.dart';
import '../Components/videorow.dart';
import '../Controller/sharedpref.dart';
import '../database/datafields.dart';
import '../database/database_helper.dart';
import '../firebase_options.dart';
import '../main.dart';
import '../../models/data/user.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/widget_keys.dart';
import '../viewmodel/data.dart';
import 'login.dart';
import 'profilebtn.dart';

import 'package:firebase_core/firebase_core.dart';

//import 'package:flutter_cache_manager/flutter_cache_manager.dart';

//import 'package:flutter_native_splash/flutter_native_splash.dart';

class DashboardLayout extends StatefulWidget {
  /*
    const DashboardLayout({
      super.key,
      required this.infoPane,
      required this.boards,
      required this.proDetails,
      this.essence,
    });
  */

  const DashboardLayout({Key? key}) : super(key: RIKeys.dshlay);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

GlobalKey<_DashboardLayoutState>? _processKey =
    RIKeys.dshlay as GlobalKey<_DashboardLayoutState>?; // GlobalKey();

//GlobalKey<_DashboardLayoutState> _processKey = GlobalKey();

class _DashboardLayoutState extends State<DashboardLayout> {
  Future<ProfileButton>? usrDetails;
  bool initialized = false;
  bool videoCast = false;
  final ReceivePort _port = ReceivePort();

  final List<RemoteMessage> _messages = [];

  late SharedPref pref;

  late DashNotify broadcast;
  late List<Map> sects;

  late List<String> pane;

  @override
  void initState() {
    /*
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      debugPrint('message received');
      debugPrint(event.notification!.body);
    });
    */
    super.initState();
    pane = dpane;
    pref = SharedPref();
    usrDetails = obtainUser();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //     log("Notification permission yet to be granted***");
    //   } else {
    //     log("Notification permission allowed already...");
    //   }
    // });
    // msgg();
    //_startBackgroundTask();

    // FlutterNativeSplash.remove();
  }

  Future<void> showVideoThumbnail() async {
    videoCast = true;
    setState(() {});
  }

  Future<void> _messageHandler(RemoteMessage message) async {
    String msg = jsonEncode(message.data);
    log("Background Message Received:$msg");
    log("Msg rcpt");
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message");
  }

  void MessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("got a notification***");

      String msg = jsonEncode(message.data);
      log("User Received:$msg");

/*
      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) isAllowed = await displayNotificationRationale();
      if (!isAllowed) return;

      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: -1,
              channelKey: Org,
              title: "Testing",
              body: "Awesome",
              criticalAlert: true));

      setState(() {
        _messages = [..._messages, message];
      });
    });

    */
    });
  }

  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Get Notified!',
              style: Theme.of(context).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/animated-bell.gif',
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                  'Allowing notifications enable you to get access to real time messages and correspondences on the app for best user experence'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Deny',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.red),
                )),
            TextButton(
                onPressed: () async {
                  userAuthorized = true;
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Allow',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.deepPurple),
                )),
          ],
        );
      },
    );
    return userAuthorized;
    //  &&
    //     await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Future<void> Notify() async {
  //   await NotificationController.initializeLocalNotifications();
  //   await NotificationController.initializeIsolateReceivePort();
  // }

  List<Map<dynamic, dynamic>> reOrient(List<Map<dynamic, dynamic>> parent,
      List<Map<dynamic, dynamic>> subtract) {
    List<Map<dynamic, dynamic>> rslt = [];
    for (int i = 0; i < parent.length; i++) {
      Map<dynamic, dynamic> sbc = parent[i];
      if (!subtract.contains(sbc)) {
        rslt.add(sbc);
      }
    }

    return rslt;
  }

  Future<ProfileButton>? obtainUser() async {
    late DatabaseHelper dbh;
    dbh = DatabaseHelper(table: usrTbl);

    ProfileButton prfl = const ProfileButton(
        accNm: "",
        accAss: "Unverified User",
        accPic: 'assets/images/user.png',
        dest: pDt);

    int qq = await dbh.queryRowCount();
    if (qq > 0) {
      List<Map<String, dynamic>> user = await dbh.queryAllRows();
      String str = jsonEncode(user);
      log("User:$str");
      ussr_ = User.fromData(user[0]);

      String mode_ = "";

      switch (appStatus) {
        case prod:
          mode_ = ussr_.Category;
          break;
        case dev:
          mode_ = caller;
          break;
      }

      log("logged as $mode_");

      switch (mode_) {
        case "1":
          broadcast = ddInfo2;
          sects = ddBoards2;
          pane = dpane;
          break;
        case "2":
          broadcast = aInfo;
          sects = aBoards;
          pane = paneStack(mode_);
          if (lone) {
            switch (lonephase) {
              case 1:
                sects = aBoards_1;
                log("Removed a sect");
                break;
            }
          }
          break;
        case "3":
          broadcast = mInfo;
          sects = mBoards;
          pane = dpane;
          if (lone) {
            switch (lonephase) {
              case 1:
                sects = mBoards_1;
                break;
            }
          }
          break;

        //check

        case "5":
          try {
            broadcast = pInfo;
            sects = pBoards;
          } catch (e) {
            log('log successful');
          }
          break;
        case "4":
          broadcast = tInfo;
          sects = tBoards;
          pane = paneStack(mode_);
          break;
        case "6":
          broadcast = sInfo;
          sects = sBoards;
          break;
      }

      /*

      if (ussr_.Name == "Adeyinka" ||
          ussr_.Name == "Túndé Blades" ||
          ussr_.Name == "oxide") {
        pane = tpane_;
        log('UserID: ${ussr_.Unique_ID}');
      }

      */

      /*
      {
            "ID": "9",
            "Domain": "107",
            "User_ID": "3599585",
            "Balance": "1000",
            "Bonus": "0",
            "Quotidian": "0",
            "Voucher": "0",
            "Last_Transaction": "2022-07-30 11:52:14"
        }
      */

      userprofile.addEntries({
        nmm: ussr_.Name,
        cls: "",
        wltTbl: "",
        eml: ussr_.Email,
        gnd: ussr_.Gender,
        ass_tbl: "",
        phn: ussr_.Phone
      }.entries);

      SharedPref pref = SharedPref();
      await pref.setPrefString(fln, ussr_.Name);

      prfl = ProfileButton(
          accNm: ussr_.Name,
          accAss: "Unverified User",
          accPic: 'assets/images/user.png',
          dest: pDt);

      log("chkk***${prfl.accNm}");

/*
      if (lone) {
        pane.remove(bbst);
      }
      */

      dbh = DatabaseHelper(table: pndTbl);
      int qd = await dbh.queryRowCount();
      if (qd > 0) {
        pnd = true;
      }

      await drwUser();
      await usrUpdate();
    } else {
      // Navigate().transit(context, const Login());
      const Login();
    }

    dbh = DatabaseHelper(table: appDtl);
    if (await dbh.queryRowCount() > 0) {
      List<Map<String, dynamic>> user = await dbh.queryAllRows();
      String str = jsonEncode(user);
      log("Domainzz:$str");
      ussr_dmn = UserDomain.fromData(user[0]);
    } else {
      await obtainDomain();
    }

    initialized = true;
    try {
      setState(() {});
    } catch (e) {}

    return prfl;
  }

  final ppr = Container(
    margin: const EdgeInsets.only(right: 20),
    child: const Column(
      children: [
        ProfileButton(
            accNm: 'Unkown User',
            accAss: 'Unverified',
            accPic: 'accPic',
            dest: '')
      ],
    ),
  );

  FutureBuilder<ProfileButton> castData() {
    return FutureBuilder(
        future: usrDetails,
        builder: (context, snapshot) {
          ProfileButton? data_ = snapshot.data;
          if (snapshot.hasData) {
            return ProfileButton(
                accNm: data_!.accNm,
                accAss: data_.accAss,
                accPic: data_.accPic,
                dest: dest);
          } else if (snapshot.hasError) {
            return SizedBox(width: 220, child: ppr);
          }

          return const ProfLoader();
        });
  }

  /*

  void _prep()
  {
    final myIsolate = Isolate.spawn(computeFactorial, 5);
    myIsolate.then((isolate) => print('Factorial result: ${isolate.result}'));
  }

  void computeFactorial(int n) {
    int factorial(int n) => (n == 0) ? 1 : n * factorial(n - 1);
    final result = factorial(n);
    SendPort? sendPort = IsolateNameServer.lookupPortByName('main');
    sendPort!.send(result);
  }


   Future<Person> fetchUser() async {
    ReceivePort port = ReceivePort();
    String userData = await Api.getUser();
    final isolate = await Isolate.spawn<List<dynamic>>(
        deserializePerson, [port.sendPort, userData]);
    final person = await port.first;
    isolate.kill(priority: Isolate.immediate);
    return person;
  }

  void deserializePerson(List<dynamic> values) {
    SendPort sendPort = values[0];
    String data = values[1];
    Map<String, dynamic> dataMap = jsonDecode(data);
    sendPort.send(Person(dataMap["name"]));
  }

  */

  // ignore: unused_element
  void _startBackgroundTask() async {
    try {
      await Isolate.spawn(_backgroundTask, _port.sendPort);
      _port.listen((message) async {
        log("got a notification**");

        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      });
    } catch (e) {
      log("check error: $e");
    }

    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      fbId = fcmToken!;
      log("UserToken:$fbId");
      pref.setPrefString(tk_id, fcmToken);
      pref.setPrefBool(token, true);
    } catch (e) {}

    //  await FirebaseMessaging.instance.getToken();

    //  await Firebase.initializeApp();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ignore: avoid_print
      print('Got a message whilst in the foreground!');
      if (message.notification != null) {
        // print('Notification Title: ${message.notification.title}');
        // print('Notification Body: ${message.notification.body}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessage.listen((event) {
      log("Fore");
      // do something
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("Fore OPen");
      // do something
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   /*
    //   setState(() {
    //     _messages = [..._messages, message];
    //   });

    //   */
    //   log("CheckMsg***$message");
    // });
  }

  static void _backgroundTask(SendPort sendPort) {
    // Perform time-consuming operation here
    // ...

    // Send result back to the main UI isolate
    sendPort.send('Task completed successfully!');
  }

  VideoRow vdr() {
    return const VideoRow(
      essence: videos,
      data: {
        "Essence": "course_content",
        "State": "read_expl",
        "Manifest": {"pub": "1"}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          iconTheme: const IconThemeData(size: 30, color: Colors.white),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tab(
                height: 85,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        (initialized == false) ? const ProfLoader() : castData()

                        // widget.proDetails,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: bgmainclr,
        ),
      ),
      drawer: Drawer(
          child: DrawerScreen(
        ctx_key: scaffoldKey,
        tagged: const {
          "Essence": "section",
          "State": "read_expl",
          "Manifest": {"availability": "1"}
        },
        essence: sct,
        endgoal: '',
        title: org_,
        view_: '',
        destination: banky,
        pane: pane,
      )),
      // drawer: DrawerScreen(),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const DashboardLayout(),
            ),
          );
        },
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    // height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(106, 158, 158, 158),
                            blurRadius: 3,
                            offset: Offset(0, 5))
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: (initialized == false) ? ddInfo2 : broadcast,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 5, right: 5),
                        padding: const EdgeInsets.only(left: 10),
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'General Lectures',
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(videos);
                                },
                                child: const Text(
                                  'See all',
                                  style: TextStyle(color: accentclr),
                                ))
                          ],
                        ),
                      ),
                      //  vdr()
                      (videoCast == false) ? vdr() : videoThumnailDisplay()
                    ],
                  ),
                  (initialized == false)
                      ? ProgressLevel(prg_message: "Loading...")
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 3 / 3.5,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: sects.length,
                          itemBuilder: (BuildContext ctx, index) {
                            Map board = sects[index];
                            return BoardTab(
                              tagged: const {
                                "Essence": "Section",
                                "State": "read",
                              },
                              tagged2: const {
                                "Essence": "Section",
                                "State": "read_expl",
                                "Manifest": {"availability": "1"}
                              },
                              essence: sct,
                              endgoal: banks,
                              essence2: classes,
                              endgoal2: classes,
                              essence3: classes4cur,
                              endgoal3: classes4cur,
                              essence4: classes4curv,
                              endgoal4: classes4curv,
                              essence5: classes4resltv,
                              endgoal5: classes4resltv,
                              essence6: classesv,
                              endgoal6: classesv,
                              essence7: crsubj,
                              endgoal7: crsubj,
                              title2: 'Class List',
                              title: board[nm],
                              view_: '',
                              subname: board[subnm],
                              name: board[nm],
                              destination: board[dest],
                              color: board[clr],
                              icon: board[icn],
                            );
                          })
                ],
              )),
        ),
      ),

      floatingActionButton: Visibility(
        visible: (appStatus == dev) ? true : false,
        child: FloatingActionButton.extended(
            onPressed: () {
              (appStatus == dev) ? Navigator.of(context).pushNamed(chatr) : {};
            },
            elevation: 0,
            label: SvgPicture.asset('assets/svg/chat.svg', width: 40),
            backgroundColor: const Color.fromARGB(0, 255, 255, 255)),
      ),
    );
  }
}

void castVideo() {
  _processKey!.currentState!.showVideoThumbnail();
}
