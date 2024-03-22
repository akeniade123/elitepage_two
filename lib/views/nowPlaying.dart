import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../Controller/fields.dart';
import '../controller/firebasehandler.dart';
import '../data/curriculum.dart';
import '../data/video.dart';
import '../models/env.dart';
import '../screens/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../Controller/filehandler.dart';
import '../Controller/navigation.dart';
import '../database/datafields.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';

class NowPlaying extends StatefulWidget {
  //final String link;
  VideoModel vmd;

  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); // -->[1]

  // final link, desp, title, name;
  NowPlaying({
    super.key,
    required this.vmd,
  });

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final GlobalKey<SfPdfViewerState> _transcript = GlobalKey();

  FlutterTts _flutterTts = FlutterTts();
  List<Map> _voices = [];
  Map? _currentVoice;

  int? _currentWordStart, _currentWordEnd;

  bool init = true;
  bool mtrlLoad = false;
  bool mySubs = false;
  late String cntMtrl;

  bool _showLoading = true;
  bool _showComments = true;

  Future<Widget>? futuredata;
  late SfPdfViewer pdfview;

  late PdfDocument doc;

  @override
  void initState() {
    super.initState();
    svrf = serverFile(filePath: "filePath", status: false);
    logger("Modelled: ${widget.vmd.essence}");
    initTTS();
    broadcast();
    //  castData(wdd);
    futuredata = _fetchData();
  }

  void initTTS() {
    _flutterTts.setProgressHandler((text, start, end, word) {
      setState(() {
        _currentWordStart = start;
        _currentWordEnd = end;
      });
    });

    _flutterTts.getVoices.then((data) {
      try {
        _voices = List<Map>.from(data);

        setState(() {
          _voices =
              _voices.where((_voice) => _voice["name"].contains("en")).toList();

          _currentVoice = _voices.first;
          // await _flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});

          setVoice(_currentVoice!);
        });
        logger("TheVoices: $_voices");
      } catch (e) {
        print("TheVoiced_error: $e");
      }
    });
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  Future<void> broadcast() async {
    if (widget.vmd.essence == sdyMode || widget.vmd.essence == bbst) {
      lss = liveSession(link: widget.vmd.link);
    }

    if (widget.vmd.material == '') {
      _showLoading = false;
    }

    // logger("Modelled_Url: ${cntMtrl}");

    if (init) {
      lnt = liveNote(note: widget.vmd.note, body: "");
      init = false;
    }
  }

  Consumer getPdf() {
    return Consumer<FirebaseNotifier>(builder: (context, notifier, child) {
      return castPdf();
    });
  }

  FutureBuilder<Widget> castPdf() {
    return FutureBuilder(
        future: futuredata,
        builder: (context, snapshot) {
          return Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SfPdfViewer.file(File(svrf.filePath)));
        });
  }

  Future<void> castData(String path) async {
    String dir = await fileDir();
    File fll = File("$dir/$path");

    String flp = "$dir/$path";

    svrf = serverFile(filePath: flp, status: false);

    switch (widget.vmd.essence) {
      case sdyMode:
        cntMtrl = widget.vmd.material;
        mtrlLoad = true;
        break;
      case bbst:
        mtrlLoad = false;
        break;
      case explMode:
        logger("Modelled: Preload");
        if (await fileExists(path)) {
          logger("Modelled: Init");
          setState(() {
            mtrlLoad = true;
          });
          svrf = serverFile(filePath: flp, status: true);
        } else {
          logger("Modelled:: Dld");
          // ignore: use_build_context_synchronously
          // await downloadFile(context, path, path);

          /*
          if (await downloadFile(context, path, path)) {
            // return _fetchData();
          }

          */

          break;
        }
    }
  }

  Future<Widget> _fetchData() async {
    Widget wdg = const Text("No Data");
    logger("Modelled: #1");

    String wdd = "contents/robotics/sevensegment_display.pdf";

    String pth = "contents/robotics";
    // pth = "contents/biology";

    String fll_ = "sevensegment_display.pdf";
    // fll_ = "livingorganisms.pdf";

    //  downloadFile(context, "$pth/$fll", pth, fll);

    //serverPrelim(context, pth, fll_, "$pth/$fll_");

    // wdd = "contents/biology/livingorganisms.pdf";

    svrf = serverFile(filePath: wdd, status: false);

    switch (widget.vmd.essence) {
      case bbst:
        // widget.vmd.material;
        Navigate nvg = Navigate();
        sct_var = {"exam": widget.vmd.topic, "user": ussr_.Unique_ID};

        Map<String, Object> tag = {
          "Essence": "subscription",
          "State": rd_e,
          "Manifest": sct_var
        };

        Map<String, dynamic>? obj =
            await nvg.eliteApi(tag, desig, "essence", "", true, context);

        ServerPrelim? svp = ServerPrelim.fromJson(obj!); // as ServerPrelim?;
        if (svp.status) {
        } else {
          wdg = Column(children: [
            const Text("You Currently don't have any content subscription"),
            ElevatedButton(
              onPressed: () {
                //  String cntt = jsonEncode(widget.contents);
                //  cbtCnt = cntt;

                Map<String, Object> tag = {
                  "Essence": "Section",
                  "State": "read_expl",
                  "Manifest": {"availability": "1"}
                };

                Future<List<Widget>>? futureclasses;

                modalPane("Content Subscription", tag, desig, sct, sct, bbst,
                    server, futureclasses, true, context);
              },
              child: const Text("Subscribe"),
            )
          ]);
        }

        setState(() {
          mySubs = true;
        });
        break;

      case exmMode:
        mtrlLoad = false;
        break;
      case sdyMode:
      case explMode:
        logger("Modelled: Preload");

        if (await fileExists("$pth/$fll_")) {
          logger("Modelled: Init");

          String dir = await fileDir();
          File fll = await getFile("$pth/$fll_"); // File("$dir/$pth/$fll_");
          wdg = SfPdfViewer.file(
            fll,
            onPageChanged: (details) {
              /*
              PdfTextExtractor extractor = PdfTextExtractor(doc);
              String text = extractor.extractText(startPageIndex: 0);
              ttsCheck = text;
              */

              logger("Current Page: ${details.newPageNumber}");

              print(details.newPageNumber);
              print(details.isFirstPage);
            },
            onDocumentLoaded: (details) {
              try {
                _flutterTts
                    .setVoice({"name": "en-gb-x-rjs-local", "locale": "en-GB"});

                doc = details.document;

                PdfTextExtractor extractor = PdfTextExtractor(details.document);
                String text = extractor.extractText(startPageIndex: 0);
                ttsCheck = text;

                logger("The text: $text");

                int pgs = details.document.pages.count;
                logger("Modelled: ##2 $pgs");
                print(details.document.pages.count);
                logger("Modelled: #3");
                setState(() {
                  _showLoading = false;
                });
              } catch (e) {
                logger("Modelled Error: $e");
              }
            },
          );

          setState(() {
            mtrlLoad = true;
          });
        } else {
          logger("Modelled: Dld");

          //  await downloadFile(context, wdd, wdd);

          // ignore: use_build_context_synchronously
          // if (await downloadFile(context, wdd, wdd)) {
          //   // return _fetchData();
          // }

          cntMtrl = await downloadFromUrl(wdd);
          logger("Modelled: ##1 - $cntMtrl");
          _showLoading = false;
          setState(() {
            mtrlLoad = true;
          });
          logger("Modelled: #2");
          wdg = SfPdfViewer.network(cntMtrl, key: _transcript,
              onPageChanged: (PdfPageChangedDetails details) {
            PdfTextExtractor extractor = PdfTextExtractor(doc);
            String text = extractor.extractText(startPageIndex: 0);
            ttsCheck = text;

            print(details.newPageNumber);
            print(details.isFirstPage);
            if (widget.vmd.essence == lstMode) {}
          }, onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            try {
              _flutterTts
                  .setVoice({"name": "en-gb-x-rjs-local", "locale": "en-GB"});

              doc = details.document;

              PdfTextExtractor extractor = PdfTextExtractor(details.document);
              String text = extractor.extractText(startPageIndex: 0);
              ttsCheck = text;

              // _showResult(text);

              int pgs = details.document.pages.count;
              logger("Modelled: ##2 $pgs");
              print(details.document.pages.count);
              logger("Modelled: #3");
              setState(() {
                _showLoading = false;
              });
            } catch (e) {
              logger("Modelled Error: $e");
            }
          });

          // setState(() {
          //   post = json.decode(results[0].body);
          //   comments = json.decode(results[1].body);
          //   _showLoading = false;
          // });
        }

        break;
    }

    logger("Modelled: 4");

    return wdg;
  }

  FutureBuilder<Widget> stackData() {
    return FutureBuilder(
        future: futuredata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return const Text('an error occured');
          }

          logger("Modelled: 6");
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingAnimationWidget.flickr(
                  leftDotColor: accentclr, rightDotColor: bgmainclr, size: 30),
            ),
          );
        });
  }
  // late YoutubePlayerController _controller;

  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.vmd.link,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  late Column header;

  Widget videoContent(String mode) {
    late Widget screen;

    switch (mode) {
      case explMode:
        screen = const SizedBox(
          width: double.infinity,
          height: 10,
        );
        break;
      case lstMode:
        screen = TtsUI();
        break;
      case bbst:
      case exmMode:
      case sdyMode:
        screen = Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  aspectRatio: 19 / 10,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {
                    _controller.addListener(() {});
                  },
                ),
                builder: (context, player) => player,
              ),
            ),
          ],
        );

        break;
    }

    return screen;
  }

  Widget pdfContent(String mode) {
    late Widget screen;
    switch (mode) {
      case explMode:
        try {
          screen = SfPdfViewer.network(cntMtrl, key: _transcript,
              onPageChanged: (PdfPageChangedDetails details) {
            print(details.newPageNumber);
            print(details.isFirstPage);
            if (widget.vmd.essence == lstMode) {}
          }, onDocumentLoaded: (PdfDocumentLoadedDetails details) {
            try {
              _flutterTts
                  .setVoice({"name": "en-gb-x-rjs-local", "locale": "en-GB"});

              /*

              PdfTextExtractor extractor = PdfTextExtractor(details.document);

              String text = extractor.extractText(startPageIndex: 0);

              ttsCheck = text;

              */

              // _showResult(text);

              int pgs = details.document.pages.count;
              logger("Nice Page tag: $pgs");
              print(details.document.pages.count);
            } catch (e) {
              logger("Pdf Error: $e");
            }
          });
        } catch (e) {}

        break;
    }

    return screen;
  }

  Future<Column>? _futureCln;

  Column liveContent() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              aspectRatio: 19 / 10,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(() {});
              },
            ),
            builder: (context, player) => player,
          ),
        ),
      ],
    );
  }

  Consumer notice() {
    return Consumer<FirebaseNotifier>(builder: (context, notifier, child) {
      return castPdf();
    });
  }

  Consumer videoCast() {
    return Consumer<FirebaseNotifier>(builder: (context, notifier, child) {
      return castPdf();
    });
  }

  Column clmn() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 10),
            height: 70,
            child: (init == false) ? notice() : const Text(""),
          ),

          /*

          Expanded(
            child: (init == false) ? notice() : const Text("")
          ),

          */
        ]);
  }

  Widget _buildMarquee(String scrollText) {
    return Marquee(
      text: scrollText,
      velocity: 50.0,
    );
  }

  Widget _buildComplexMarquee(String scrollText) {
    return Marquee(
      text: scrollText,
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20,
      velocity: 100,
      pauseAfterRound: const Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 3,
      startPadding: 10,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      // textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  /*

  FutureBuilder<Column> castData(
      Future<Column>? futureclasses, String essence) {
    return FutureBuilder(
        future: futureclasses,
        builder: (context, snapshot) {
          switch (essence) {
            case note:
              break;
          }

          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Note(lnt
                        .note)) // mqq(lnt.note)) // _buildComplexMarquee(lnt.note)) // Text(lnt.note))
              ]);
        });
  }

  */

  ListView mqq(String txt) {
    return ListView(
      padding: const EdgeInsets.only(top: 50),
      children: [
        _buildMarquee(txt),
        _buildComplexMarquee(txt),
      ].map(_wrapWithStuff).toList(),
    );
  }

  Widget Note(String entry) {
    return SizedBox(
      width: 350,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 14.0,
          color: accentclr,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TyperAnimatedText(
              speed: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              entry,
              textStyle: const TextStyle(
                  color: accentclr, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(height: 50, color: Colors.white, child: child),
    );
  }

  Widget TtsUI() {
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _speakerSelector(),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: ttsCheck.substring(0, _currentWordStart),
                  ),
                  if (_currentWordStart != null)
                    TextSpan(
                        text: ttsCheck.substring(
                            _currentWordStart!, _currentWordEnd),
                        style: const TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.purpleAccent)),
                  if (_currentWordEnd != null)
                    TextSpan(
                      text: ttsCheck.substring(_currentWordEnd!),
                    )
                ])),
      ],
    ));
  }

  Future<List<int>> _readDocumentData(String name) async {
    final ByteData data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> _textDialog() async {
    PdfDocument document = PdfDocument(
        inputBytes:
            await _readDocumentData('content/sevensegment_display.pdf'));

//Create a new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

//Extract all the text from the first page of the PDF document.
    String text = extractor.extractText(startPageIndex: 0);

//Display the text.
    _showResult(text);
  }

  void _showResult(String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Extracted text'),
            content: Scrollbar(
              child: SingleChildScrollView(
                child: Text(text),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
              ),
            ),
            actions: [
              InkWell(
                child: const Text('Close'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _speakerSelector() {
    return DropdownButton(
        items: _voices
            .map((_voice) => DropdownMenuItem(
                value: _voice,
                child: Text(_voice[
                    "name"]) //customUI(cedar, [_voice["name"], _voice["locale"]])
                ))
            .toList(),
        value: _currentVoice,
        onChanged: (newvalue) {
          setState(() {
            _currentVoice = newvalue;
            setVoice(_currentVoice!);
          });
        });
  }

/*
  Widget _materialDisplay(String essence){
    switch(essence)
    {
      case explMode:

                                  _flutterTts.setVoice({"name": "en-gb-x-rjs-local", "locale": "en-GB"});

        PdfTextExtractor extractor = PdfTextExtractor(details.document);

        String text = extractor.extractText(startPageIndex: 0);

        ttsCheck = text;

        // _showResult(text);

        print(details.document.pages.count);
      break;
    }
  } 

  */

  _showCommentsToggle() {
    return Row(
      children: [
        const Text(
          'Show comments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: CupertinoSwitch(
            value: _showComments,
            onChanged: (bool value) {
              setState(() {
                _showComments = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _showComments = !_showComments;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bbCtx = context;
    return Scaffold(
        floatingActionButton: Visibility(
            visible: (widget.vmd.essence == lstMode ||
                    widget.vmd.essence == explMode)
                ? true
                : false,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 3, 38, 66),
              foregroundColor: Colors.white,
              onPressed: () {
                switch (widget.vmd.essence) {
                  case lstMode:
                  case explMode:
                    //_textDialog();
                    _flutterTts.speak(ttsCheck);
                    break;
                }
                // Navigator.of(context).push(Btns as Route<Object?>);
              },
              child: const Icon(
                Icons.speaker_phone,
              ),
            )),

        /*
         FloatingActionButton(
          onPressed: () {
            _flutterTts.speak(ttsCheck);
          },
          child: const Icon(Icons.speaker_phone),
        ),
        */

        appBar: PreferredSize(
          preferredSize:
              const Size(double.infinity, 50), // Size(double.infinity, 50),
          child: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: bgmainclr,
              centerTitle: false,
              elevation: 0,
              title:
                  (widget.vmd.essence == sdyMode || widget.vmd.essence == bbst)
                      ? const Text(
                          'Now playing',
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          widget.vmd.access,
                          style: const TextStyle(color: Colors.white),
                        )),
          //AppHead(headtitle: 'Now Playing'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(child: videoContent(widget.vmd.essence)),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    widget.vmd.id,
                                    style: TextStyle(
                                      fontSize: 18,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 6
                                        ..color = accentclr,
                                    ),
                                  ),
                                  // Solid text as fill.
                                  Text(
                                    widget.vmd.id,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),

/*
                              Text(widget.vmd.id,
                                  //  style: const TextStyle(fontSize: 19),
                                  style: TextStyle(
                                    fontSize: 25,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = Colors.blue[700]!,
                                  )),

                                  */

                              (widget.vmd.essence == exmMode)
                                  ? clmn()
                                  : Text(widget.vmd.note),
                            ],
                          )),
                      (widget.vmd.essence == exmMode)
                          ? const Text("")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "~ ${widget.vmd.name}",
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${widget.vmd.access}",

                                  // "#This video credit goes to ${widget.vmd.access} whose content is referenced as a resource material, the metrics on Youtube counts for the user on his/her referenced channel#",
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),

                                /*
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromARGB(
                                              102, 158, 158, 158)),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 220,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0,
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 0,
                                                    color: Colors.white)),
                                            hintText: 'write a feedback',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          cursorColor: Colors.grey,
                                          cursorWidth: 1,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: bgmainclr),
                                        child: const Text('Submit'),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),

                                */
                              ],
                            ),
                    ],
                  ),
                ),
              ),

              /*
              (svrf.status)
                  ? (widget.vmd.essence == exmMode)
                      ? const Flexible(child: Text(""))
                      : Flexible(
                          flex: 3,
                          fit: FlexFit.loose,
                          child: (widget.vmd.material == '')
                              ? const Text("No study note for this content yet")
                              : getPdf())
                  : const Text("")
                  */

              (mtrlLoad)
                  ? (widget.vmd.essence == exmMode)
                      ? const Flexible(child: Text(""))
                      : Flexible(
                          flex: 3,
                          fit: FlexFit.loose,
                          child: (widget.vmd.material == '')
                              ? const Text("No study note for this content yet")
                              : stackData())
                  : const Text(""),
              (widget.vmd.essence == bbst)
                  ? (mySubs)
                      ? stackData()
                      : const Text("My Subscription")
                  : const Text("")

              /*
              if (_showLoading)
                Center(child: CupertinoActivityIndicator(animating: true)),
              if (!_showLoading) ...[

              ],

              */
            ],
          ),
        )

        /*
        child: SingleChildScrollView(
                    child: SfPdfViewer.network(
                      'https://www.elitepage.com.ng/elitepage/GPC_Robotics.pdf',
                      key: _transcript,
                    ),
                  ),
        */

        // Flexible(flex: 1, child: videoContent())

        );
  }
}
