// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import '../Components/classpane.dart';
import '../Components/progress.dart';
import '../Controller/requester.dart';
import '../database/datafields.dart';
import '../database/database_helper.dart';
import '../models/data/user.dart';
import '../models/endpoints.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';
import '../models/service_protocols.dart';
import '../screens/common_widget.dart';
import 'dashboardlayout.dart';
import 'enter_otp.dart';
import 'register.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordinvisible = true;
  bool checkbox = true;

  late Widget btnn, btnn_;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userNamed = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<Map<String, dynamic>>? _futureData;

  bool prelim = false;

  String mssg = "";

  @override
  void initState() {
    super.initState();
    prelim = false;
    //  FlutterNativeSplash.remove();
  }

  Future<Map<String, dynamic>>? FetchData(String essence) async {
    log("Current State: $prelim");

    Map<String, dynamic> txt = {}; // Text("Sign in");
    Map<String, String> tag = {};

    switch (essence) {
      case login:
        tag.addEntries({
          "regId": "prelim",
          "Full_Name": _userName.text,
          "Essence": "Profile",
          "Password": _password.text
        }.entries);
        break;
      case pswOTP:
        tag.addEntries({
          "regId": "prelim",
          "Full_Name": _userNamed.text,
          "Essence": "Profile",
          "domain": "PasswordOTP"
        }.entries);
        break;
    }

    Endpoint enp = Endpoint();
    String url = enp.getEndpoint(login, communal, true);

    Map<String, dynamic>? data_ = await postReq(
        enp.getEndpoint(login, communal, true),
        tag,
        rqstElite,
        login,
        urlEnc,
        "",
        context,
        true);

    if (data_ != null) {
      txt = data_;
      String dtt = jsonEncode(data_);
      ServerPrelim svp = ServerPrelim.fromJson(jsonDecode(dtt));
      Object obj = svp.msg;
      if (svp.status) {
        ServerResponse svr = ServerResponse.fromJson(jsonDecode(dtt));
        LoginUser(context, obj, svr, essence);
      } else {
        customSnackBar(context, obj.toString());
      }
    }

    signin = false;
    otp = false;
    log("Done with sign in procession");
    setState(() {});
    return txt;
  }

  FutureBuilder<Map<String, dynamic>> btnState() {
    bool transit = false;

    log("Implementing builder logic");
    //  prelim = true;
    return FutureBuilder(
        future: _futureData,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            //  prelim = false;
            signin = true;
            Map<String, dynamic>? mpp = snapshot.data;
            if (mpp!.isNotEmpty) {
              mpp.forEach((key, value) async {
                if (key == "message") {
                  mssg = value;
                } else if (key == "status") {
                  if (value == true) {
                    transit = true;
                    String dtt = jsonEncode(mpp);

                    ServerResponse svr =
                        ServerResponse.fromJson(jsonDecode(dtt));
                    List usrLogin = svr.data;
                    User ussr_ = User.fromData(usrLogin[0]);

                    log("Hello: ${ussr_.Device_ID}");
                    Map<String, dynamic> row = usrLogin[0];
                    DatabaseHelper dbh = DatabaseHelper(table: usrTbl);
                    await dbh.insertData(row);
                  }
                }
              });
            }

            if (transit) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DashboardLayout(),
                ),
              );
            }

            //SnackBar(content: Text(mssg));
            log("***No error***");
            return const Text("Sign in");
          } else if (snapshot.hasError) {
            // signin = false;
            log("error exists***");
            return const Text("Sign in");
          }

          return ProgressLevel(prg_message: "Processing");
        }));
  }

  bool signin = false;
  bool otp = false;

  @override
  Widget build(BuildContext context) {
    // btnchk();
    signin == false
        ? btnn = const Text("Sign in")
        : btnn = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sigining in   '),
              LoadingAnimationWidget.flickr(
                  size: 20,
                  leftDotColor: Colors.white,
                  rightDotColor: Colors.blue)
            ],
          );

    otp == false
        ? btnn_ = const Text("Change Password")
        : btnn_ = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Requesting...'),
              LoadingAnimationWidget.flickr(
                  size: 20,
                  leftDotColor: Colors.white,
                  rightDotColor: Colors.blue)
            ],
          );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(fontSize: 30, color: bgmainclr),
                          ),
                          Text('Back!',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Row(children: [
                        const Text(
                          'Log in into your account',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Image.asset('assets/images/svg.png')
                      ]),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Full Name'),
                          const SizedBox(
                            height: 13,
                          ),
                          TextField(
                            controller: _userName,
                            decoration: InputDecoration(
                                hintText: 'Full Name',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text('Password'),
                          const SizedBox(
                            height: 13,
                          ),
                          TextField(
                            controller: _password,
                            obscureText: passwordinvisible,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                helperText:
                                    "Password must contain upper and lowercase",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordinvisible = !passwordinvisible;
                                      });
                                    },
                                    icon: Icon(passwordinvisible
                                        ? Icons.visibility
                                        : Icons.visibility_off_sharp)),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(
                                            255, 249, 249, 249))),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 249, 249, 249)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             checkbox = !checkbox;
                          //           });
                          //         },
                          //         icon: Icon(checkbox
                          //             ? Icons.check_box_sharp
                          //             : Icons.check_box_outline_blank_sharp)),
                          //     Text('Remember me')
                          //   ],
                          // ),
                          const SizedBox(
                            height: 24,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_userName.text.isEmpty ||
                                            _password.text.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(DisplaySnackBar(
                                                  "empty required field"));
                                        } else {
                                          signin = true;
                                          setState(() {});
                                          _futureData = FetchData(login);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: bgmainclr),
                                      child: btnn)
                                  //(prelim == false) ? btnn : btnState()),
                                  ),
                              const SizedBox(height: 30),
                              TextButton(
                                  onPressed: () {
                                    Widget wdg = Column(
                                      children: [
                                        const Center(
                                          child: Text("User Verification"),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        TextField(
                                          controller: _userNamed,
                                          decoration: InputDecoration(
                                              hintText: 'Full Name',
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                              filled: true,
                                              fillColor: Colors.white
                                                  .withOpacity(0.5)),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                if (_userNamed.text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(DisplaySnackBar(
                                                          "empty required field"));
                                                } else {
                                                  otp = true;
                                                  setState(() {});
                                                  _futureData =
                                                      FetchData(pswOTP);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: bgmainclr),
                                              child: btnn_),
                                        )
                                      ],
                                    );
                                    Modal(context, 200, wdg);
                                  },
                                  child: const Text(
                                    'Forgot your password?',
                                    style: TextStyle(color: Colors.red),
                                  )),
                              const SizedBox(),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don’t have an account?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const Registration();
                                            },
                                          ));
                                        },
                                        child: const Text(
                                          'Sign up',
                                          style: TextStyle(color: Colors.green),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// void btnchk(Widget btnn, bool status) {
//   if (status == false) {
//     btnn = const Text("Sign in");
//   } else {
//     btnn = Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Text('Signing you in'),
//         LoadingAnimationWidget.beat(color: Colors.white, size: 20)
//       ],
//     );
//   }
// }

Future<void> LoginUser(BuildContext context, Object obj, ServerResponse svr,
    String essence) async {
  log("User Logger $obj");
  try {
    Map<String, dynamic> otp_ = obj as Map<String, dynamic>;

    customSnackBar(context, otp_['message']!);

    List usrLogin = svr.data;
    User ussr_ = User.fromData(usrLogin[0]);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return otp(
            value: otp_['code']!.toString(),
            recipient: otp_["Email"],
            essence: essence,
            user: ussr_,
          );
        },
      ),
    );
  } catch (e) {
    customSnackBar(context, svr.msg.toString());

    List usrLogin = svr.data;
    User ussr_ = User.fromData(usrLogin[0]);

    DatabaseHelper dbh = DatabaseHelper(table: usrTbl);
    await dbh.insertData(User.toMap(ussr_));

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DashboardLayout(),
      ),
    );
  }
}
