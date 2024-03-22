import 'dart:convert';
import 'dart:developer';

import '../Components/loaderD.dart';
import '../Controller/navigation.dart';
import '../Controller/requester.dart';

import '../data/video.dart';
import '../models/global_strings.dart';
import 'package:flutter/material.dart';

import '../models/server_response.dart';

class VideoRow extends StatefulWidget {
  static String tag = "/VideoRow";
  final String essence;
  final Map<String, Object> data;

  const VideoRow({
    super.key,
    required this.essence,
    required this.data,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VideoRow createState() => _VideoRow();
}

GlobalKey<_VideoRow> _processKey = GlobalKey();

class _VideoRow extends State<VideoRow> {
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

      setState(() {
        thmb_cmp = true;
      });

      thumb = rssl;
    } catch (e) {}

    return rssl;
  }

  Future<List<VideoModel>>? futurefetch() async {
    List<VideoModel> rslt = [];

    nvg = Navigate();

    Map<String, Object> tag = widget.data;

    Map<String, dynamic>? ressp =
        await nvg.eliteApi(tag, desig, widget.essence, vdr, true, context);

    try {
      if (ressp!["status"]) {
        ServerResponse? svr = ServerResponse.fromJson(ressp);
        //  await nvg.getEliteApi(tag, desig, widget.essence, true, context);

        log("***Internet available");

        List data_ = svr.data;
        for (final item in data_) {
          String lnk = item["link"];
          String nm = item["name"];
          String ntt = item["note"];
          String acc = item["access_id"];
          String acs = item["access"];
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
        }
        try {
          setState(() {
            dtv = true;
          });
        } catch (e) {}
        //  castVideo();
      }
    } catch (e) {}

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

            return LoaderD(vdd: wgg);
          } else if (snapshot.hasError) {
            return LoaderD(vdd: dums(5));
            //const Text("An error occured");
          }
          return LoaderD(vdd: dums(5));
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
        borderRadius: BorderRadius.circular(10));
  }

  BoxDecoration svv(String thumbnail) {
    return BoxDecoration(
        color: const Color.fromARGB(255, 221, 221, 221),
        image: DecorationImage(image: netImg(thumbnail), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(10));
  }

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
        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        // padding: const EdgeInsets.all(5),
        width: 210,
        decoration: (!thmb_cmp) ? bxx(bgimg) : svv(thumb[thumbnail]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.green),
                      color: const Color.fromARGB(157, 158, 158, 158)),
                  padding: const EdgeInsets.all(3),
                  child: const Text(
                    'Plus Digital Note',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.play_circle_fill_outlined,
              size: 35,
              color: Color.fromARGB(181, 0, 0, 0),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(148, 0, 0, 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    width: 200,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      subj,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 1,
                    ),
                  ),
                  Row(children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundImage: AssetImage(teachpic),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        teacher,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 7),
                      ),
                    ),
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container LoadPane() {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 10),
      width: 190,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(120, 158, 158, 158),
                offset: Offset(2, 1),
                spreadRadius: 4,
                blurRadius: 2,
                blurStyle: BlurStyle.outer)
          ],
          color: const Color.fromARGB(26, 158, 158, 158),
          borderRadius: BorderRadius.circular(5)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                Container(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    height: 15,
                    width: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  color: Colors.white,
                  height: 15,
                  width: 100,
                ),
                Row(children: [
                  Container(
                    height: 15,
                    width: 20,
                    color: Colors.white,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    height: 15,
                    width: 70,
                    color: Colors.white,
                  ),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget init() {
    video = futurefetch();
    log("checking for data");
    return LoaderD(vdd: dums(5));
  }

  Future<void> _pullRefresh() async {
    log("Checkerzz");
    // List<String> freshNumbers = await NumberGenerator().slowNumbers();
    // setState(() {
    //   numbersList = freshNumbers;
    // });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        Future.sync(() {
          log("Do this");
        });

        return _pullRefresh();
        // log("Checkkerz");
        // FutureBuilder(builder: builder)
      },
      child: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: (dtv == false) ? init() : display()),
      ),
    );
  }
}

Widget videoThumnailDisplay() {
  return _processKey.currentState!.display();
}
