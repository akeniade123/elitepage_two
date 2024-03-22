import 'dart:developer';

import '../database/datafields.dart';
import '../models/env.dart';
import '../views/dashboardlayout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Components/appbar.dart';
import '../../Components/headers.dart';
import '../../Controller/navigation.dart';
import '../../models/global_strings.dart';
import '../../models/server_response.dart';
import '../../screens/common_widget.dart';

class ProcessionAccess extends StatefulWidget {
  final String essence;
  final Map<String, Object> data;
  final String title;
  final exec;
  final String endgoal;
  const ProcessionAccess({
    super.key,
    required this.essence,
    required this.data,
    required this.title,
    this.exec,
    required this.endgoal,
  });

  @override
  State<ProcessionAccess> createState() => _ProcessionAccessState();
}

class _ProcessionAccessState extends State<ProcessionAccess> {
  final TextEditingController _purpose = TextEditingController();
  final _amount = TextEditingController();
  final _description = TextEditingController();

  Future<List<Widget>>? _futureContent;

  late Color bgclr;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureContent = fetchData();

    if (widget.exec == "") {
      bgclr = const Color.fromARGB(0, 255, 255, 255);
    } else {
      bgclr = bgmainclr;
    }
  }

  Future<List<Widget>>? fetchData() async {
    List<Widget> rslt = [];

    nvg = Navigate();

    Map<String, Object> tag = widget.data;
    Map<String, dynamic>? hmp =
        await nvg.eliteApi(tag, desig, widget.essence, "", true, context);

    if (hmp!["status"]) {
      ServerResponse? svr = ServerResponse.fromJson(hmp);
      //  await nvg.getEliteApi(tag, desig, widget.essence, true, context);
      List data_ = svr.data;

      for (final item in data_) {
        switch (widget.essence) {}
      }
    }

    return rslt;
  }

  FutureBuilder<List<Widget>> stackData() {
    return FutureBuilder(
        future: _futureContent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget>? data_ = snapshot.data;

            return SingleChildScrollView(
              child: Column(children: [
                ListView.builder(
                    itemCount: data_!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return data_[index];
                    })
              ]),
            );
            // return cast(essence, data_!);
          } else if (snapshot.hasError) {
            return const NoInternet();
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingAnimationWidget.flickr(
                  leftDotColor: accentclr, rightDotColor: bgmainclr, size: 30),
            ),
          );
        });
  }

  late Navigate nvg;
  String? pdfpath;
  // ignore: non_constant_identifier_names
  Container FormFill(
      String purpose, String description, String amount, String buttons) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Headers(headings: widget.exec),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                height: 40,
                width: 200,
                child: TextField(
                  controller: _purpose,
                  cursorColor: accentclr,
                  textAlign: TextAlign.start,
                  textCapitalization: TextCapitalization.sentences,
                  textAlignVertical: const TextAlignVertical(y: 1),
                  decoration: InputDecoration(
                    hintText: purpose,
                    hintStyle: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: accentclr),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                cursorColor: accentclr,
                controller: _description,
                textAlign: TextAlign.start,
                // textAlignVertical: TextAlignVertical(y: .1),
                decoration: InputDecoration(
                    hintText: description,
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      overflow: TextOverflow.clip,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: accentclr,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    )),
                maxLines: 5, minLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                controller: _amount,
                cursorColor: accentclr,
                textAlign: TextAlign.start,
                textCapitalization: TextCapitalization.sentences,
                // textAlignVertical: TextAlignVertical(y: .1),
                decoration: InputDecoration(
                    hintText: amount,
                    hintStyle: const TextStyle(
                        color: Colors.grey, overflow: TextOverflow.clip),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: accentclr),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    )),
                maxLines: 10,
                minLines: 1,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, Object> tag = {
                    pup: _purpose,
                    des: _description,
                    prc: _amount
                  };

                  tag.addEntries({
                    "Essence": "fees",
                    "State": "create",
                    "Manifest": {
                      "purpose": _purpose.text,
                      "description": _description.text,
                      "amount": _amount.text
                    },
                    "Entries": {},
                    "Constraint": {
                      "purpose": _purpose.text,
                      "description": _description.text
                    }
                  }.entries);

                  // ignore: unused_local_variable
                  ServerResponse? svr = await nvg.getEliteApi(
                      tag, desig, "essence", "", true, context);
                },
                child: Text(buttons))
          ],
        ),
      ),
    );
  }

  DropdownButton drpp(List<String> contents, String dropdownValue) {
    return DropdownButton<String>(
      value: dropdownValue,
      items: contents.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        dropdownValue = newValue!;

        setState(() {});
      },
    );
  }

  Autocomplete autocmp(List<String> kOptions) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }

  Container? form() {
    try {
      late Container frm;

      switch (widget.essence) {
        case fManage:
          frm = FormFill(
              'Fee Purpose', 'Description....', 'N 4,000.00', 'Submit');
          break;
        case lectr:
          frm = FormFill('Topic', 'Video Description', 'Video Link', 'Submit');
          break;
        case accD:
          frm =
              FormFill('bank name', 'Account Name', 'Account Number', 'Submit');
          break;
        case addcurr:
          frm = FormFill('Topic', 'week', 'Objectives', 'Submit');
          break;
      }
      return frm;
    } catch (e) {
      log("Form error:$e");
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  FloatingActionButton Btns(String tag) {
    nvg = Navigate();
    return FloatingActionButton.extended(
      onPressed: () async {
        try {
          switch (widget.exec) {
            case 'Add Event':
              Modal(context, 400,
                  FormFill('Purpose', ' Contents', 'Description', 'Add Event'));
              break;
            case addBank:
              Modal(context, 400,
                  FormFill('Bank name', 'Account number', '', 'Add account'));

            case expPro:
              Modal(
                  context,
                  400,
                  FormFill('Entered in Numbers', 'description', 'amount',
                      'Submit Expenses'));
              break;

            case setFee:
              Modal(context, 400,
                  FormFill('purpose', 'description', 'amount', 'Submit Fee'));
              break;

            // case 'Add Curriculum':
            //   form();
            //   break;
            case 'Add Teachers':
              Navigator.of(context).pushNamed(allusersT);
              break;
            case 'Add Students':
              Navigator.of(context).pushNamed(allusersS);
              break;
            case 'Add Parents':
              Navigator.of(context).pushNamed(allusersP);
              break;
            case 'Add as Teachers':
              Modal(
                  context,
                  100,
                  Center(
                    child: Column(children: [
                      const Text('successfully add as Teachers'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => DashboardLayout(),
                              ),
                            );
                          },
                          child: const Text('Return to dashboard'))
                    ]),
                  ));
              break;
            case 'Add as Students':
              Modal(
                  context,
                  100,
                  Center(
                    child: Column(children: [
                      const Text('successfully add as Students'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => DashboardLayout(),
                              ),
                            );
                          },
                          child: const Text('Return to dashboard'))
                    ]),
                  ));
              break;
            case 'Add as Parents':
              Modal(
                  context,
                  100,
                  Center(
                    child: Column(children: [
                      const Text('successfully add as Parents'),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => DashboardLayout(),
                              ),
                            );
                          },
                          child: const Text('Return to dashboard'))
                    ]),
                  ));
              break;
            case '+':
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
                      padding: const EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Headers(headings: 'Set Lesson Note'),
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                width: double.infinity,
                                height: 60,
                                child: TextField(
                                  minLines: 30,
                                  maxLines: 35,
                                  textAlignVertical:
                                      const TextAlignVertical(y: 1),
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hintText: ' Week',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 216, 216, 216)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue),
                                    ),
                                  ),
                                )),
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                width: double.infinity,
                                height: 60,
                                child: TextField(
                                  minLines: 30,
                                  maxLines: 35,
                                  textAlignVertical:
                                      const TextAlignVertical(y: 1),
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hintText: ' Topic',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 216, 216, 216)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue),
                                    ),
                                  ),
                                )),
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                width: double.infinity,
                                height: 120,
                                child: TextField(
                                  minLines: 30,
                                  maxLines: 35,
                                  cursorColor: Colors.grey,
                                  textAlignVertical:
                                      const TextAlignVertical(y: 1),
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hintText: ' Description',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 216, 216, 216)),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue),
                                    ),
                                  ),
                                )),
                            Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                width: 200,
                                height: 60,
                                child: TextField(
                                  onTap: () async {
                                    FilePickerResult? pdfFile =
                                        await FilePicker.platform.pickFiles();

                                    if (pdfFile != null) {
                                      PlatformFile file = pdfFile.files.first;

                                      pdfpath = file.path;
                                      print(pdfFile);
                                    }
                                  },
                                  cursorColor:
                                      const Color.fromARGB(0, 255, 193, 7),
                                  textAlignVertical:
                                      const TextAlignVertical(y: 1),
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hintText: pdfpath ?? 'Pick PDF File',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    suffixIcon:
                                        const Icon(Icons.file_copy_sharp),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                255, 216, 216, 216)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.blue),
                                    ),
                                  ),
                                )),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: bgmainclr),
                                child: const Text('Upload Digital Note'))
                          ],
                        ),
                      ),
                    );
                  });
              break;
          }
        } catch (e) {
          log("Button Error$e");
        }
      },
      elevation: 0,

      backgroundColor: bgclr,
      label: Text(tag),
      //  icon: SvgPicture.asset('/assets/svg/addstudent.svg', color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: AppHead(
          headtitle: widget.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(5),
            child:
                (_futureContent == null) ? const Text("No data") : stackData()),
      ),
      floatingActionButton: Btns(
        widget.exec,
      ),
    );
  }
}
