import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import '../Components/LoaderV.dart';
import '../Components/headers.dart';
import '../Controller/navigation.dart';
import '../Controller/requester.dart';
import '../data/video.dart';
import '../models/env.dart';
import 'package:file_picker/file_picker.dart';
import '../Controller/elitebasis.dart';
import '../Controller/fields.dart';
import '../database/datafields.dart';
import '../models/global_strings.dart';
import 'package:flutter/material.dart';
import '../models/server_response.dart';

class Videos extends StatefulWidget {
  static String tag = "/Videos";
  final essence, exec, fltclr, shdbg;
  final Map<String, Object> data;

  const Videos({
    super.key,
    required this.essence,
    required this.data,
    required String title,
    required this.exec,
    required this.fltclr,
    this.shdbg,
  });

  @override
  // ignore: library_private_types_in_public_api
  _Videos createState() => _Videos();
}

class _Videos extends State<Videos> {
  @override
  void initState() {
    super.initState();
    thumb = [];
    video = futurefetch();
  }

  late Navigate nvg;
  bool dtv = false;

  Future<List<VideoModel>>? video;

  Future<List<String>>? thumbnails;

  late List<String> thumbsTags;

  late List<String> thumb;

  bool thmb_cmp = false;
  //late Uint8List pdfNote;

  late List<int> pdfNote;
  late String fileName;

  late String pdfString;

  Future<List<String>>? fetchThumbnail_() async {
    List<String> rssl = [];

    String url =
        "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&part=id&part=status&part=contentDetails&id=";

    "bc8eWbABMSM,nS2-3xB4Qmc,AKthtzsDhUw,QYbTwe7yOSQ,cJ8qy4yHG3g";
    String urlEnd =
        "&maxHeight=320&key=AIzaSyD1R8qeD6RrEi9rRlN-LefAqAsjmlHNxx4";

    int size = thumbsTags.length;

    for (int i = 0; i < size; i++) {
      url += thumbsTags[i];
      if (i < size - 1) {
        url += ",";
      }
    }
    url += urlEnd;

    log("Check this out: $url");

    try {
      Map<String, dynamic>? ytb = await getReq(url, "", "", context, true);

      ytb!.forEach((key, value) {
        if (key == "items") {
          List vdprop = value;
          for (int i = 0; i < vdprop.length; i++) {
            Map<String, dynamic> tth = vdprop[i];
            //tth.containsKey("snippet");
            tth.forEach((key, value) {
              if (key == "snippet") {
                Map<String, dynamic> dmm = value;

                dmm.forEach((key, value) {
                  if (key == "thumbnails") {
                    Map<String, dynamic> vdt = value;
                    vdt.forEach((key, value) {
                      if (key == "standard") {
                        Map<String, dynamic> stnd = value;
                        stnd.forEach((key, value) {
                          if (key == "url") {
                            rssl.add(value);
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        }
      });

      String stt = jsonEncode(rssl);
      log("Video Thumbs: $stt");
      thmb_cmp = true;
      setState(() {});

      thumb = rssl;
    } catch (e) {}

    return rssl;
  }

  Future<List<VideoModel>>? futurefetch() async {
    List<VideoModel> rslt = [];
    nvg = Navigate();

    Map<String, Object> tag = widget.data;
    ServerResponse? svr =
        await nvg.getEliteApi(tag, desig, widget.essence, vdd, true, context);

    if (svr != null) {
      log("***Internet available");

      List data_ = svr.data;
      for (final item in data_) {
        String lnk = item["link"];
        String nm = item["name"];
        String ntt = item["note"];
        String acc = item["access_id"];
        String stn = item["study_note"];

        String text = item["keyword"];
        List<String> result = text.split('#');

        String tpc = result[0]; // item["topic_id"];
        log("***$lnk***$nm***");

        rslt.add(VideoModel(
            link: lnk,
            name: nm,
            note: ntt,
            access: acc,
            topic: tpc,
            id: '',
            material: stn,
            essence: sdyMode));
        dtv = true;
        setState(() {});
      }
    }

    return rslt;
  }

  NetworkImage netImg(String url) {
    return NetworkImage(url);
  }

  FutureBuilder<List<VideoModel>> display() {
    return FutureBuilder(
        future: video,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<VideoModel>? data_ = snapshot.data;
            int size = data_!.length;

            List<Widget> wgg = [];
            thumbsTags = [];

            for (int i = 0; i < size; i++) {
              wgg.add(VideoPane(
                  data_[i].name,
                  'assets/images/sample.png',
                  i,
                  data_[i].access,
                  data_[i].topic,
                  'assets/images/blades.jpg',
                  data_[i].name,
                  data_[i].link,
                  data_[i].note,
                  data_[i].topic,
                  data_[i].material));
              thumbsTags.add(data_[i].link);

              // wgg.add(DashVideo(
              //   bgimg: 'assets/images/sample.png',
              //   header: data_[i].name,
              //   teacher: data_[i].name,
              //   price: data_[i].access,
              //   subj: data_[i].topic,
              //   teachpic: 'assets/images/blades.jpg',
              //   link: data_[i].link,
              // ));
            }

            if (thumb.length < size) {
              thumbnails = fetchThumbnail_();
            } else if (thumb.length == size) {
              thmb_cmp = true;
            }

            return LoaderV(vdd: wgg);
          } else if (snapshot.hasError) {
            return LoaderV(vdd: dums(10));
            //const Text("An error occured");
          }
          return LoaderV(vdd: dums(10));
        });
  }

  List<Widget> dums(int showMag) {
    List<Container> cntt = [];
    for (int i = 0; i < showMag; i++) {
      cntt.add(LoadPane());
    }
    return cntt;
  }

  BoxDecoration bxx(String bgimg) {
    return BoxDecoration(
      color: const Color.fromARGB(255, 221, 221, 221),
      image: DecorationImage(image: AssetImage(bgimg)),
    );
  }

  BoxDecoration svv(String thumbnail) {
    return BoxDecoration(
      color: const Color.fromARGB(255, 221, 221, 221),
      image: DecorationImage(image: netImg(thumbnail), fit: BoxFit.fill),
    );
  }

  // ignore: non_constant_identifier_names
  InkWell VideoPane(
      String header,
      String bgimg,
      int thumbnail,
      String price,
      String subj,
      String teachpic,
      String teacher,
      String link,
      String note,
      String topic,
      String material_) {
    return InkWell(
      onTap: () {
        curr_vid = VideoModel(
            link: link,
            name: teacher,
            note: note,
            access: "",
            topic: topic,
            id: '',
            material: material_,
            essence: sdyMode);
        //  curr_vid = link;
        Navigator.of(context).pushNamed(nowplaying);
      },
      child: Container(
        width: double.infinity,
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //     color: Colors.white,
        //     boxShadow: const [
        //       BoxShadow(
        //           blurStyle: BlurStyle.inner,
        //           blurRadius: 2,
        //           color: Color.fromARGB(26, 158, 158, 158),
        //           offset: Offset(2, 2),
        //           spreadRadius: 2)
        //     ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Stack(alignment: Alignment.center, children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: (!thmb_cmp)
                        ? bxx('assets/images/sample.png')
                        : svv(thumb[thumbnail]),
                  ),
                  const Icon(
                    Icons.play_circle_fill_outlined,
                    size: 35,
                    color: Color.fromARGB(181, 0, 0, 0),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 220,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    topic,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        overflow: TextOverflow.clip,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(
                          width: 220,
                          child: Text(
                            note,
                            maxLines: 2,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: 70,
                      child: Text(
                        teacher,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container LoadPane() {
    const color = Color.fromARGB(38, 158, 158, 158);
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 10),
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(5),
      //     boxShadow: const [
      //       BoxShadow(
      //           blurStyle: BlurStyle.inner,
      //           offset: Offset(1, 2),
      //           color: Color.fromARGB(110, 158, 158, 158))
      //     ]),
      width: double.infinity,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: color)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5),
                          width: 150,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: color)),
                      Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: color)),
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: color)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget init() {
    video = futurefetch();
    log("checking for data");
    return LoaderV(vdd: dums(10));
  }

  Future<void> _pullRefresh() async {
    log("Checkerzz");
    // List<String> freshNumbers = await NumberGenerator().slowNumbers();
    // setState(() {
    //   numbersList = freshNumbers;
    // });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }

  TextEditingController lnk_ = TextEditingController();
  TextEditingController dsc_ = TextEditingController();
  TextEditingController kwd_ = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const video = 'videos';
    String? pdfpath;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: bgmainclr,
            title: const Text(
              'channel',
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                    child: Text(
                  'Videos',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                  child: Text(
                    'Questions',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RefreshIndicator(
                onRefresh: () {
                  Future.sync(() {
                    log("Do this");
                  });

                  return _pullRefresh();
                  // log("Checkkerz");
                  // FutureBuilder(builder: builder)
                },
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            // margin: const EdgeInsets.only(left: 5, right: 5),
                            child: (!dtv) ? init() : display()),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    onPressed: () {
                      switch (widget.exec) {
                        case adlct:
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              constraints: BoxConstraints(
                                  maxHeight: 500,
                                  minWidth: MediaQuery.of(context).size.width),
                              shape: const ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50))),
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Headers(
                                              headings: 'Upload Video Lecture'),
                                          // DropdownSearch<String>(
                                          //   popupProps: const PopupProps.menu(
                                          //     showSelectedItems: true,

                                          //     /*
                                          //     disabledItemFn: (String s) =>
                                          //         s.startsWith('I'),
                                          //         */
                                          //   ),
                                          //   items: const [
                                          //     "Brazil",
                                          //     "Italia",
                                          //     "Tunisia",
                                          //     'Canada'
                                          //   ],
                                          //   dropdownDecoratorProps:
                                          //       const DropDownDecoratorProps(
                                          //     dropdownSearchDecoration: InputDecoration(
                                          //       labelText: "Topic",
                                          //       hintText: "country in menu mode",
                                          //     ),
                                          //   ),
                                          //   onChanged: (value) {},
                                          //   //selectedItem: "Brazil",
                                          // ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              width: double.infinity,
                                              height: 60,
                                              child: TextField(
                                                minLines: 30,
                                                maxLines: 35,
                                                textAlignVertical:
                                                    const TextAlignVertical(
                                                        y: 1),
                                                cursorColor: Colors.grey,
                                                decoration: InputDecoration(
                                                  focusColor: Colors.white,
                                                  hintText: ' Topic',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      216,
                                                                      216,
                                                                      216)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              width: double.infinity,
                                              height: 120,
                                              child: TextField(
                                                minLines: 30,
                                                maxLines: 35,
                                                cursorColor: Colors.grey,
                                                controller: dsc_,
                                                textAlignVertical:
                                                    const TextAlignVertical(
                                                        y: 1),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.white,
                                                  hintText: ' Description',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      211,
                                                                      154,
                                                                      154)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              width: double.infinity,
                                              height: 60,
                                              child: TextField(
                                                minLines: 30,
                                                maxLines: 35,
                                                controller: lnk_,
                                                textAlignVertical:
                                                    const TextAlignVertical(
                                                        y: 1),
                                                cursorColor: Colors.grey,
                                                decoration: InputDecoration(
                                                  focusColor: Colors.white,
                                                  hintText:
                                                      ' Youtube video link',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      216,
                                                                      216,
                                                                      216)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              width: double.infinity,
                                              height: 60,
                                              child: TextField(
                                                minLines: 30,
                                                maxLines: 35,
                                                controller: kwd_,
                                                textAlignVertical:
                                                    const TextAlignVertical(
                                                        y: 1),
                                                cursorColor: Colors.grey,
                                                decoration: InputDecoration(
                                                  focusColor: Colors.white,
                                                  hintText: ' Keyword',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      216,
                                                                      216,
                                                                      216)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              width: 200,
                                              height: 60,
                                              child: TextField(
                                                onTap: () async {
                                                  try {
                                                    FilePickerResult? pdfFile =
                                                        await FilePicker.platform.pickFiles(
                                                            type:
                                                                FileType.custom,
                                                            allowMultiple:
                                                                false,
                                                            onFileLoading:
                                                                (FilePickerStatus
                                                                        status) =>
                                                                    log("$status"),
                                                            allowedExtensions: [
                                                          'pdf'
                                                        ]);

                                                    if (pdfFile != null) {
                                                      PlatformFile file =
                                                          pdfFile.files.first;

                                                      pdfpath = pdfFile
                                                          .files.single.path;

                                                      log(pdfpath!);

                                                      final File file_ = File(
                                                          pdfpath!); //File('${directory.path}/my_file.txt');

                                                      pdfNote = await file_
                                                          .readAsBytes();

                                                      fileName = pdfFile
                                                          .files.first.name;

                                                      pdfString = base64
                                                          .encode(pdfNote);

                                                      log("Uploading Logically ***Done");
                                                    }
                                                  } catch (e) {
                                                    log("Error: $e");
                                                  }
                                                },
                                                cursorColor:
                                                    const Color.fromARGB(
                                                        0, 255, 193, 7),
                                                textAlignVertical:
                                                    const TextAlignVertical(
                                                        y: 1),
                                                decoration: InputDecoration(
                                                  focusColor: Colors.white,
                                                  hintText: pdfpath ??
                                                      'Pick Pdf Note',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey),
                                                  suffixIcon: const Icon(Icons
                                                      .picture_as_pdf_rounded),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      216,
                                                                      216,
                                                                      216)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              )),
                                          ElevatedButton(
                                              onPressed: () {
                                                Map<String, Object> tag = {
                                                  "Essence": "access",
                                                  "State": "specific_tsk",
                                                  "Specific": "Content_Upload",
                                                  "name": ussr_.Name,
                                                  unq: ussr_.Unique_ID,
                                                  "domain": "107",
                                                  "topic_id": "28",
                                                  "pub": "1",
                                                  "access_id": "14",
                                                  "rating": 5,
                                                  "link": lnk_.text,
                                                  "note": dsc_.text,
                                                  "keyword": kwd_.text,
                                                  "access": 1,
                                                  "studynote":
                                                      "EliteContent/${ussr_.Unique_ID}$fileName",
                                                  "File": pdfString,
                                                  "FileName":
                                                      "${ussr_.Unique_ID}$fileName",
                                                  "FileType": "Pdf",
                                                  "Folder": "EliteContent",
                                                  "Manifest": {
                                                    "user": "5943074",
                                                    "domain": "107"
                                                  }
                                                };
                                                svrRequest(tag, "essence",
                                                    endgoal, context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: bgmainclr),
                                              child:
                                                  const Text('Upload Content'))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                          break;
                        case '':
                          break;
                      }
                    },
                    elevation: 0,
                    backgroundColor: widget.fltclr,
                    label: Text(
                      widget.exec,
                      style: const TextStyle(color: accentclr),
                    ),
                  ),
                ),
              ),
              Scaffold(
                body: const Column(),
                floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: bgmainclr,
                    onPressed: () {
                      Navigator.of(context).pushNamed(cCbt);
                    },
                    label: const Text(
                      'Add File',
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          )),
    );
  }
}
