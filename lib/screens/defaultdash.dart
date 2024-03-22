import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import '../Components/LoaderV.dart';
import '../Controller/navigation.dart';
import '../Controller/requester.dart';
import '../data/video.dart';
import '../models/env.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../database/datafields.dart';
import '../models/global_strings.dart';
import 'package:flutter/material.dart';
import '../models/server_response.dart';

class DefaultDash extends StatefulWidget {
  static String tag = "/DefaultDash";
  final essence, exec, fltclr, shdbg;
  final Map<String, Object> data;

  const DefaultDash({
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
  _DefaultDash createState() => _DefaultDash();
}

class _DefaultDash extends State<DefaultDash> {
  @override
  void initState() {
    super.initState();
    thumb = [];
    owner = [];
    titles = [];
    video = futurefetch();
  }

  late Navigate nvg;
  bool dtv = false;

  Future<List<VideoModel>>? video;

  Future<List<String>>? thumbnails;

  late List<String> thumbsTags;

  late List<String> thumb;
  late List<String> owner;
  late List<String> titles;

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

                  if (key == "title") {
                    titles.add(value);
                  }
                  if (key == "channelTitle") {
                    owner.add(value);
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
        await nvg.getEliteApi(tag, desig, widget.essence, "", true, context);

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
      image: DecorationImage(image: AssetImage(bgimg), fit: BoxFit.fill),
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
            access: owner[thumbnail],
            topic: topic,
            id: titles[thumbnail],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 220,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    (!thmb_cmp) ? "" : titles[thumbnail],
                                    maxLines: 2,
                                    style: const TextStyle(
                                        overflow: TextOverflow.clip,
                                        fontSize: 13,
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
                                color: Colors.grey,
                                fontSize: 10),
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    const video = 'videos';
    String? pdfpath;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 140),
        child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Container(
              height: 70,
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      textAlignVertical: const TextAlignVertical(y: 1),
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(maxHeight: 40),
                        focusColor: accentclr,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: accentclr,
                          size: 13,
                        ),
                        hintText: 'Search videos',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  profPic != null
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(prof);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  FileImage(File(profPic!.path), scale: 50),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(prof);
                          },
                          child: SvgPicture.asset(
                            'assets/svg/user1.svg',
                            height: 35,
                          ),
                        ),
                ],
              ),
            ),
            bottom: Tab(
              height: 70,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/home.svg',
                            color: bgmainclr,
                            width: 25,
                          ),
                          const Text(
                            'Home',
                            style: TextStyle(color: bgmainclr),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            constraints: const BoxConstraints(minHeight: 400),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    TextField(
                                      textAlignVertical:
                                          const TextAlignVertical(y: 1),
                                      decoration: InputDecoration(
                                        constraints:
                                            const BoxConstraints(maxHeight: 40),
                                        focusColor: accentclr,
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color: accentclr,
                                          size: 13,
                                        ),
                                        hintText: 'Search channels',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    const SingleChildScrollView(
                                      child: Column(
                                        children: [Text('hello')],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/channel.svg',
                            width: 25,
                          ),
                          const Text('Channels')
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            constraints: const BoxConstraints(minHeight: 400),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    TextField(
                                      textAlignVertical:
                                          const TextAlignVertical(y: 1),
                                      decoration: InputDecoration(
                                        constraints:
                                            const BoxConstraints(maxHeight: 40),
                                        focusColor: accentclr,
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color: accentclr,
                                          size: 13,
                                        ),
                                        hintText: 'Search courses',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/qst.svg',
                            width: 25,
                          ),
                          const Text('Questions Bank')
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            constraints: const BoxConstraints(minHeight: 400),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            builder: (context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    TextField(
                                      textAlignVertical:
                                          const TextAlignVertical(y: 1),
                                      decoration: InputDecoration(
                                        constraints:
                                            const BoxConstraints(maxHeight: 40),
                                        focusColor: accentclr,
                                        suffixIcon: const Icon(
                                          Icons.search,
                                          color: accentclr,
                                          size: 13,
                                        ),
                                        hintText: 'Search contents',
                                        hintStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/saved.svg',
                            width: 25,
                          ),
                          const Text('Saved')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      // drawer: Drawer(
      //     child: DrawerScreen(
      //   ctx_key: scaffoldKey,
      //   tagged: const {
      //     "Essence": "section",
      //     "State": "read_expl",
      //     "Manifest": {"availability": "1"}
      //   },
      //   essence: sct,
      //   endgoal: '',
      //   title: org_,
      //   view_: '',
      //   destination: banky,
      //   pane: pane,
      // )),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const DefaultDash(
                essence: videos,
                data: {
                  "Essence": crsCnt,
                  "State": "read_expl",
                  "Manifest": {"pub": "1"}
                },
                title: '',
                exec: '',
                fltclr: Color.fromARGB(0, 255, 255, 255),
              ),
            ),
          );
          // Future.sync(() {
          //   log("Do this");
          // });

          // return _pullRefresh();
          // log("Checkkerz");
          // FutureBuilder(builder: builder)
        },
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              // margin: const EdgeInsets.only(left: 5, right: 5),
              child: (!dtv) ? init() : display()),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
          onPressed: () {},
          label: TextButton(
              onPressed: () {
                launch('whatsapp://send?phone=234.text+8132547993.text');
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      'assets/svg/whatsapp.svg',
                      width: 20,
                    ),
                  ),
                  const Text(
                    'Feedback',
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ))),
    );
  }
}
