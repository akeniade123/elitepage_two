// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import '../Controller/requester.dart';
import '../models/endpoints.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';
import '../models/service_protocols.dart';
import '../screens/common_widget.dart';
import '../views/login.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool Passwordinvisible = true;
  bool checkbox = true;
  bool male = true;
  bool female = false;
  bool passwordinvisible = true;

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pswconfirm = TextEditingController();
  final TextEditingController _email = TextEditingController();

  late Widget btnn;

  @override
  initState() {
    super.initState();
  }

  String cCode = "";

  String gnd = "Female";

  Future<String>? _register;

  Future<String>? Registrar() async {
    reg = true;
    String msg = "Sign Up error";
    Map<String, String> tag = {};
    tag.addEntries({
      "regId": "prelim",
      "Full_Name": _userName.text,
      "Essence": "Register",
      "Password": _password.text,
      "Phone_Number": "$cCode ${_phone.text}",
      "Gender": gnd,
      "DEVICE_ID": fbId,
      "Email_Address": _email.text,
      "Designation": "NA",
      "Manifest": "Community"
    }.entries);

    Endpoint enp = Endpoint();
    String url = enp.getEndpoint(login, communal, true);

    Map<String, dynamic>? data_ =
        await postReq(url, tag, rqstElite, login, "", urlEnc, context, true);

    if (data_ != null) {
      String dtt = jsonEncode(data_);
      ServerPrelim svp = ServerPrelim.fromJson(jsonDecode(dtt));
      Object obj = svp.msg;
      if (svp.status) {
        ServerResponse svr = ServerResponse.fromJson(jsonDecode(dtt));
        LoginUser(context, obj, svr, login);
      } else {
        customSnackBar(context, obj.toString());
      }
    }
    reg == false;
    log("Done with sign in procession");
    setState(() {});
    return msg;
  }

  bool reg = false;

  @override
  Widget build(BuildContext context) {
    reg == false
        ? btnn = const Text("Sign up")
        : btnn = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sigining Up   '),
              LoadingAnimationWidget.flickr(
                  size: 20,
                  leftDotColor: Colors.white,
                  rightDotColor: Colors.blue)
            ],
          );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 19, 70, 104)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Now',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Full Name'),
                        const SizedBox(
                          height: 13,
                        ),
                        TextField(
                          controller: _userName,
                          decoration: const InputDecoration(
                              hintText: 'Full Name',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Email'),
                        const SizedBox(
                          height: 13,
                        ),
                        TextField(
                          controller: _email,
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Phone'),
                        const SizedBox(
                          height: 13,
                        ),
                        IntlPhoneField(
                          controller: _phone,
                          decoration: const InputDecoration(
                              hintText: 'phone number',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                          onCountryChanged: (country) {
                            log('Country changed to: ${country.name}');
                            cCode = country.dialCode;
                          },
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Gender'),
                        const SizedBox(
                          width: 79,
                        ),
                        const Text('Male'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                male = !male;
                                female = !female;
                                //  circleoutline = !circleoutline;
                                if (!male) {
                                  gnd = "Male";
                                } else {
                                  gnd = "Female";
                                }
                                log(gnd);
                              });
                            },
                            icon: Icon(male
                                ? Icons.circle_outlined
                                : Icons.circle_sharp)),
                        const SizedBox(
                          width: 30,
                        ),
                        const Text('Female'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                male = !male;
                                female = !female;
                                if (!female) {
                                  gnd = "Female";
                                } else {
                                  gnd = "Male";
                                }
                                log(gnd);
                              });
                            },
                            icon: Icon(female
                                ? Icons.circle_outlined
                                : Icons.circle_sharp)),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          obscureText: Passwordinvisible,
                          controller: _password,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              helperText:
                                  "Password must contain upper and lowercase",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      Passwordinvisible = !Passwordinvisible;
                                    });
                                  },
                                  icon: Icon(Passwordinvisible
                                      ? Icons.visibility
                                      : Icons.visibility_off_sharp)),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        const Text('Confirm Password'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          obscureText: passwordinvisible,
                          controller: _pswconfirm,
                          decoration: InputDecoration(
                              hintText: 'Retype Password',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () async {
                                log(_password.text);
                                if (_password.text == _pswconfirm.text) {
                                  if (_userName.text.isEmpty ||
                                      _password.text.isEmpty ||
                                      _phone.text.isEmpty ||
                                      _email.text.isEmpty) {
                                    reg = false;
                                    setState(() {});
                                    customSnackBar(
                                        context, "Some fields are empty");
                                  } else {
                                    reg = true;
                                    log("Done with sign in procession");
                                    _register = Registrar();
                                  }
                                } else {
                                  log("Password Mismatch");
                                  setState(() {});
                                  reg = false;
                                  customSnackBar(context,
                                      "Password Mismatch, kindly check and make correct entry...");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 19, 70, 104)),
                              child: btnn),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Registered?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Login(),
                              ));
                            },
                            child: const Text(
                              'Login now',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 70, 104)),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       IconButton(
                    //           onPressed: () {
                    //             setState(() {
                    //               checkbox = !checkbox;
                    //             });
                    //           },
                    //           icon: Icon(checkbox
                    //               ? Icons.check_box_sharp
                    //               : Icons.check_box_outline_blank_sharp)),
                    //       const Text(
                    //         'I accept the terms and conditions of this organization.',
                    //         style: TextStyle(fontSize: 12),
                    //       )
                    //     ],
                    //   )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Country Code"), //appbar title
        backgroundColor: Colors.redAccent, //appbar color
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                  child: IntlPhoneField(
                decoration: const InputDecoration(
                  //decoration for Input Field
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'NP', //default contry code, NP for Nepal
                onChanged: (phone) {
                  //when phone number country code is changed
                  print(phone.completeNumber); //get complete number
                  print(phone.countryCode); // get country code only
                  print(phone.number); // only phone number
                },
              )),
              Container(
                margin: const EdgeInsets.only(
                    top: 20), //make submit button 100% width
                // child: SizedBox(
                //   width: double.infinity,
                //   child: RaisedButton(
                //     onPressed: () {
                //       //action for button
                //     },
                //     color: Colors.redAccent,
                //     child: Text("Submit"),
                //     colorBrightness: Brightness.dark,
                //     //backgroud color is darker so its birghtness
                //   ),
                // ),
              )
            ],
          )),
    );
  }
}
