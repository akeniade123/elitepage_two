// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../Components/dashnotifier.dart';
import '../Controller/fields.dart';
import '../Controller/filehandler.dart';
import '../Controller/sharedpref.dart';
import '../data/curriculum.dart';
import '../database/tbl_stack.dart';
import '../models/global_strings.dart';
import '../views/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../database/database_helper.dart';
import '../database/datafields.dart';
import '../main.dart';
import 'notificationcontroller.dart';

@pragma('vm:entry-point')
void isolate2(String arg) {
  getTemporaryDirectory().then((dir) async {
    print("isolate2 temporary directory: $dir");

    /*

    await FlutterDownloader.initialize(debug: true);
    FlutterDownloader.registerCallback(downloaderCallback as DownloadCallback);

    */

    final taskId = await FlutterDownloader.enqueue(
        url:
            "https://raw.githubusercontent.com/rmawatson/flutter_isolate/master/README.md",
        savedDir: dir.path);
  });
  Timer.periodic(
      Duration(seconds: 1), (timer) => print("Timer Running From Isolate 2"));
}

void downloaderCallback(String id, DownloadTaskStatus status, int progress) {
  print("progress: $progress");
}

@pragma('vm:entry-point')
void isolate1(String arg) async {
  await FlutterIsolate.spawn(isolate2, "hello2");

  getTemporaryDirectory().then((dir) {
    print("isolate1 temporary directory: $dir");
  });
  Timer.periodic(
      Duration(seconds: 1), (timer) => print("Timer Running From Isolate 1"));
}

@pragma('vm:entry-point')
void computeFunction(String arg) async {
  getTemporaryDirectory().then((dir) {
    print("Temporary directory in compute function : $dir with arg $arg");
  });
}

Future<void> _run(String content, String id, String data,
    Map<String, dynamic> essence) async {
  print(
      "Temp directory in main isolate : ${(await getTemporaryDirectory()).path}");

  logger("Tentaclez: $content");

  try {
    SharedPref pref = SharedPref();
    await pref.setPrefString(paystruct, content);
    logger("Tentaclezer:: $payload");
    logger("Current Data retrieved: ${await pref.getPrefString(paystruct)} ");

    DatabaseHelper dbh = DatabaseHelper(table: paystruct);

    int ipp = await dbh.queryRowCount();
    //  logger("Queued: ${await dbh.queryRowCount()}");

    Map<String, dynamic> row = {id_: id, payload: data};

    dbh.insertData(row);

    firebaseProcession(essence[ess], essence);

    //  dbh.insertData(row);
  } catch (e) {
    logger("Tentaclez error***: $e");
  }

  logger("Tentaclezed: $content");

//  FlutterBackgroundService().invoke("setAsForeground");

  // FlutterBackgroundService().invoke(fgrnd);

  //   FlutterBackgroundService().invoke(msg);

  /*

  final isolate = await FlutterIsolate.spawn(isolate1, content);

  Timer(Duration(seconds: 5), () {
    print("Pausing Isolate 1");
    isolate.pause();
  });
  Timer(Duration(seconds: 10), () {
    print("Resuming Isolate 1");
    isolate.resume();
  });
  Timer(Duration(seconds: 20), () {
    print("Killing Isolate 1");
    isolate.kill();
  });


  */
}

Future<String> handleUpdates(
    RemoteMessage remoteMessage, bool foreground) async {
  String response = "";
  if (remoteMessage.notification != null) {
    try {
      String msg = jsonEncode(remoteMessage.notification!.body);
      logger("Notification:$msg");

      Map<String, dynamic> json = jsonDecode(jsonDecode(msg));
      logger("The Title${json['title']}");

      if (json['notify']) {
        NotificationController.createNewNotification(
            json['title'], json['content']);
      }

      Map<String, dynamic> dtt = remoteMessage.data;
      String parse = jsonEncode(dtt);
      logger("The Data: $parse");

      _run(json['content'], json[unq], parse, dtt);

      //  FlutterBackgroundService().invoke("firebaseNotify", mpp);

      // FlutterBackgroundService().invoke("setAsBackground");

/*
      SharedPref pref = SharedPref();
      pref.setPrefString(notifyer, msg);

      */

      /*

      if (json['notify']) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: json['title'],
                body: json['content']));
      }

      */
    } catch (e) {
      logger("handler error: $e");
    }
  }
  try {
    late DatabaseHelper dbh;
    SharedPref pref = SharedPref();
    Map<String, dynamic> dtt = remoteMessage.data;
    logger(dtt["Essence"]);
    Map<String, dynamic> rsp = {ess: dtt};
    response = jsonEncode(rsp);
  } catch (e) {
    logger("Error***$e");
  }
  return response;
}

Future<void> firebaseProcession(
    String essence, Map<String, dynamic> dtt) async {
  SharedPref pref = SharedPref();
  logger("Capital: $essence");
  switch (essence) {
    case bbst:
      String dtd = jsonEncode(dtt);
      await pref.setPrefString(bbst, dtt[cnt]);
      logger("essenceData: $dtd");
      break;

    case brdCast:
      try {
        Map<String, dynamic> mpp = {
          ttl: dtt["title"],
          cnt: dtt["Content"],
          syp: dtt["Suffix"],
          sbj: dtt["Info"],
          dtl: dtt["Details"]
        };
        pref.setPrefString(brdCast, jsonEncode(mpp));
        dashNote dnn_ = dashNote(
            title: dtt["title"],
            content: dtt["Content"],
            end: dtt["Suffix"],
            info: dtt["Info"],
            details: dtt["Details"]);
        dshCtx.read<FirebaseNotifier>().dashNotice(dnn_);
      } catch (e) {
        logger("CastError:$e");
      }
      break;

    case bbl:
      try {
        logger("$bbl casted ${dtt[cnt]}");
        String dtn = dtt[cnt];
        Map<String, dynamic> cct = jsonDecode(dtn);
        String ntt = cct[note];
        String bdd = cct[bdy];
        logger("$bbl casts $dtn **** $ntt");
        liveNote lntt = liveNote(note: ntt, body: bdd);
        bbCtx.read<FirebaseNotifier>().liveNotice(lntt);
      } catch (e) {
        logger("$bbl cast error: ${e.toString()}");
      }
      break;

    case notifi:
      Map<String, dynamic> ddd = jsonDecode(dtt[cnt]);

      String ntfCln =
          "$id_ INTEGER PRIMARY KEY NOT NULL,$cnt TEXT, $cpt TEXT, $ttl TEXT, $dtl TEXT, $createdAt TIMESTAMP NOT NULL ";

      /*


  "id":764677,
            "created_at":1701177520,
            "caption":"Best Brain",
            "title": "Seyi is on the call",
        "content": "Seyi is on the call",
        "Detail": "Best brain contest begins in January with exciting prices to be won, you can't afford to be left out of this great terrain as it promises to be great and interesting..."

*/

      DatabaseHelper dbh = DatabaseHelper(table: notificationTbl);
      await dbh.insertData(ddd);

      if (isAppActive == true) {
        try {
          if (lntc.isEmpty) {
            lntc = [];
          }
        } catch (e) {
          logger("e1:$e");
          lntc = [];
        }

        try {
          lntc.add(Notice.fromJson(ddd));
          dshCtx.read<FirebaseNotifier>().listNotify(lntc);
        } catch (e) {
          logger("e2:$e");
        }
      }
      break;
    case cht:
      String mmm = dtt["sent"];
      logger("test****$mmm");
      await UpdateChats(dtt["sent"], dtt["response"]);
      break;
  }
}

Future<void> subscribeToTopic(String topic) async {
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic(topic);
}

Future<void> unsubscribeFromTopic(String topic) async {
  await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
}

class FirebaseNotifier extends ChangeNotifier {
  final _randomGenerator = Random();
  int? _generatedNumber;
  int? get generatedNumber => _generatedNumber;

  int min = 0, max = 0;
  void generateRandomNumber() {
    _generatedNumber = min + _randomGenerator.nextInt(max + 1 - min);
    notifyListeners();
  }

  void dashNotice(dashNote dnn_) {
    dnn = dnn_;
    notifyListeners();
  }

  void liveNotice(liveNote lnv) {
    lnt = lnv;
    notifyListeners();
  }

  void fileObtained(serverFile svr) {
    svrf = svr;
    notifyListeners();
  }

  void listNotify(List<Notice> ntcc) {
    lntc = ntcc;
    notifyListeners();
  }
}

final _storage = FirebaseStorage.instance;
final _firestore = FirebaseFirestore.instance;

Future<String> uploadFileToStorage(String childName, Uint8List file) async {
  final ref = _storage.ref().child(childName);
  UploadTask uploadTask = ref.putData(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  logger("TheUrl: $downloadUrl");

  return downloadUrl;
}

Future<String> downloadFromUrl(String filePath) async {
  final storageRef = _storage.ref();
  return await storageRef.child(filePath).getDownloadURL();
}

Future<void> fileSize(String filepath) async {
  final appDocPath = await fileDir();
//  await createDir("$appDocPath/$filepath");
  String size = await getFileSize("$appDocPath/$filepath", 1);
  logger("File Details: ***$size");
}

Future<void> serverPrelim(
    BuildContext context, String dir, String filename, String fbPath) async {
  try {
    final appDocPath = await fileDir();
    await createDir("$appDocPath/$dir");
    logger("Modelled: Directory Created -- $appDocPath");
    final tempFile = await getFile(
        "$dir/$filename"); // await getfilePath(fileName); //  await locateFile("$destPath");
    logger("Modelled File Name: ${tempFile.absolute}");

    final ref = _storage.ref().child(fbPath);

    final downloadTask = ref.writeToFile(tempFile);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      logger("Modelled: ${taskSnapshot.state}");
      switch (taskSnapshot.state) {
        case TaskState.running:
          break;
        case TaskState.paused:
          // TODO: Handle this case.
          break;
        case TaskState.success:
          logger("Modelled: Downloaded***");

          /*
          serverFile svrr =
              serverFile(filePath: tempFile.absolute.toString(), status: true);
          bbCtx.read<FirebaseNotifier>().fileObtained(svrr);
          */

          // TODO: Handle this case.
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          break;
        case TaskState.error:
          // TODO: Handle this case.
          break;
      }
    });
  } catch (e) {
    logger("Modelled error: $e");
  }
}

Future<void> downloadFile(BuildContext context, String fbPath, String destPath,
    String fileName) async {
  final ref = _storage.ref().child(fbPath);

  try {
    // final Directory appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = await fileDir();

    //  String dst = await getfilePath(fileName);

    await createDir("$appDocPath+/$destPath");
    logger("Modelled: Directory Created");

    final tempFile = await getFile(
        "$destPath/$fileName"); // await getfilePath(fileName); //  await locateFile("$destPath");
    //createDir(path)
    // await tempFile.create();

    logger("Modelled: File Obtained***");

    logger("File Pth: ${tempFile.absolute}");

    logger("Modelled: Downloading Session Starts");

    final downloadTask = ref.writeToFile(tempFile);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      logger("Modelled: ${taskSnapshot.state}");
      switch (taskSnapshot.state) {
        case TaskState.running:

          // TODO: Handle this case.
          break;
        case TaskState.paused:

          // TODO: Handle this case.
          break;
        case TaskState.success:

          /*
          serverFile svrr =
              serverFile(filePath: tempFile.absolute.toString(), status: true);
          bbCtx.read<FirebaseNotifier>().fileObtained(svrr);
          */

          // TODO: Handle this case.
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          break;
        case TaskState.error:
          // TODO: Handle this case.
          break;
      }
    });

    // await ref.writeToFile(tempFile);
    // return true;
    // await tempFile.create();
    // await OpenFile.open(tempFile.path);
  } catch (e) {
    logger("Modelled error: $e");
    // customSnackBar(context, e.toString());
    // return false;
  }
}

Future<String> saveDataToFbStorage(
    {required String name,
    required String bio,
    required Uint8List file,
    required String essence}) async {
  SharedPref pref = SharedPref();
  String resp = " Some error occured... ";
  try {
    resp = await uploadFileToStorage(name, file);

    //  await _firestore.collection('userProfile');
    switch (essence) {
      case usrPrf:
        await pref.setPrefString(essence, essence);
        break;
    }

    print("$usrPrf: AdexIndexed profile... procession");
  } catch (err) {
    resp = err.toString();

    print("$usrPrf: AdexIndexed error... procession");
  }
  return resp;
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    print('state >>>>>>>>>>>>>>>>>>>>>> : ${state}');
    SharedPref pref = SharedPref();
    String? string = await (pref.getPrefString(notifyer));
    logger("NtfChk:$string");

    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallBack != null) {
          isAppActive = true;
          logger("Foreground_Engagement");
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          isAppActive = false;
          logger("Background_Engagement");

          await suspendingCallBack();
        } else {}
        break;
      case AppLifecycleState.hidden:
        logger("Hidden_Engagement");
        break;
      // TODO: Handle this case.
    }
  }
}
