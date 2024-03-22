import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tex/flutter_tex.dart';

class Exam extends StatelessWidget {
  final String qstTag, qst;
  final TeXViewRenderingEngine renderingEngine;
  const Exam(
      {super.key,
      required this.qstTag,
      required this.qst,
      this.renderingEngine = const TeXViewRenderingEngine.katex()});

/*

NinePatchImage( imageProvider: AssetImage("assets/orange.9.png"),
 child: Text( "Lorem Ipsum is simply dummy text of the printing "))
*/

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(qstTag),
        // const SizedBox(
        //   height: 20,
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                child: TeXView(
                    child: TeXViewDocument(qst,
                        style: const TeXViewStyle(
                            margin: TeXViewMargin.only(top: 10))))

                /*
               Html(
                data: qst,
              ),
              */
                )
          ],

          /*
            child: Html(
                data: """
                <div>Follow<a class='sup'><sup>pl</sup></a> 
                  Below hr
                    <b>Bold</b>
                <h1>what was sent down to you from your Lord</h1>, 
                and do not follow other guardians apart from Him. Little do 
                <span class='h'>you remind yourselves</span><a class='f'><sup f=2437>1</sup></a></div>
                """,
              )

          */
        )
      ],
    );
  }
}

TeXViewWidget _teXViewWidget(String body) {
  return TeXViewColumn(
      style: const TeXViewStyle(
          margin: TeXViewMargin.all(10),
          padding: TeXViewPadding.all(10),
          borderRadius: TeXViewBorderRadius.all(10),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderWidth: 2,
              borderStyle: TeXViewBorderStyle.groove,
              borderColor: Colors.green))),
      children: [
        TeXViewDocument(body,
            style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
      ]);
}

class Explanation extends StatelessWidget {
  final String explanation;

  final TeXViewRenderingEngine renderingEngine;
  const Explanation(
      {super.key,
      required this.explanation,
      this.renderingEngine = const TeXViewRenderingEngine.katex()});

  @override
  Widget build(BuildContext context) {
    return TeXView(
        renderingEngine: renderingEngine,
        child: TeXViewColumn(
            style: const TeXViewStyle(
                margin: TeXViewMargin.all(10),
                padding: TeXViewPadding.all(10),
                borderRadius: TeXViewBorderRadius.all(10),
                border: TeXViewBorder.all(TeXViewBorderDecoration(
                    borderWidth: 2,
                    borderStyle: TeXViewBorderStyle.groove,
                    borderColor: Colors.green))),
            children: [
              TeXViewDocument(explanation,
                  style:
                      const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
            ]));

    /*
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Explanation"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: _teXViewWidget(explanation),
            )
          ],
        )
      ],
    );
    */
  }
}

class CBTtimer extends StatefulWidget {
  final Duration duration;
  CountDownController? cd_controller;
  AnimationController? controller;

  CBTtimer(
      {super.key,
      required this.duration,
      required this.controller,
      required this.cd_controller});

  @override
  State<CBTtimer> createState() => _CBTtimerState();
}

class _CBTtimerState extends State<CBTtimer> with TickerProviderStateMixin {
  String get timerString {
    Duration duration = widget.duration * widget.controller!.value;
    return '${duration.inHours % 24}: ${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    widget.cd_controller = CountDownController();

    widget.controller!.reverse(
        from: widget.controller!.value == 0.0 ? 1.0 : widget.controller!.value);
  } //

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: widget.duration.inSeconds,

      // Countdown initial elapsed Duration in Seconds.
      initialDuration: 0,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: widget.cd_controller,

      // Width of the Countdown Widget.
      width: 130, //MediaQuery.of(context).size.width / 16,

      // Height of the Countdown Widget.
      height: 130, //MediaQuery.of(context).size.height / 16,

      // Ring Color for Countdown Widget.
      ringColor: Colors.green,

      // Ring Gradient for Countdown Widget.
      ringGradient: null,

      // Filling Color for Countdown Widget.
      fillColor: Colors.grey[100]!,

      // Filling Gradient for Countdown Widget.
      fillGradient: null,

      // Background Color for Countdown Widget.
      backgroundColor: const Color.fromARGB(255, 3, 38, 66),

      // Background Gradient for Countdown Widget.
      backgroundGradient: null,

      // Border Thickness of the Countdown Ring.
      strokeWidth: 40.0,
      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.butt,

      // Text Style for Countdown Text.
      textStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),

      // Format for the Countdown Text.
      textFormat: CountdownTextFormat.S,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: true,

      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: false,

      // Handles visibility of the Countdown Text.
      isTimerTextShown: true,

      // Handles the timer start.
      autoStart: true,

      // This Callback will execute when the Countdown Starts.
      onStart: () {
        // Here, do whatever you want
        debugPrint('Countdown Started');
      },

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        // Here, do whatever you want
        debugPrint('Countdown Ended');
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {
        timerString;
        // Here, do whatever you want
        // debugPrint('Countdown Changed $timeStamp');
      },

      /* 
            * Function to format the text.
            * Allows you to format the current duration to any String.
            * It also provides the default function in case you want to format specific moments
              as in reverse when reaching '0' show 'GO', and for the rest of the instances follow 
              the default behavior.
          */
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "0:00:00";
        } else {
          // other durations by it's default format
          return timerString; //Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}

// class Question extends StatefulWidget {
//   const Question({super.key});

//   @override
//   State<Question> createState() => _QuestionState();
// }

// class _QuestionState extends State<Question> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [
//               BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(0, 1))
//             ]),
//         width: double.infinity,
//         height: 150,
//         child: Container(
//           padding: EdgeInsets.all(15),
//           child: Exam(
//               qstTag: '1/50',
//               qst:
//                   'What is the the title of Fela Anikulapo Kuti most populous’ song tagged S&S, released in the year 1981, and performed 21 times by seun Kuti ?'),
//         ));
//   }
// }

/*


      
      tabs: const [
      Text("Mathematics"),
      Text("Physics"),
      Text("Chemistry"),
      Text("Biology"),
      Text("Use of English"),
    ]);

    TabBarView tbv = const TabBarView(children: [
      Text("This is Mathematics"),
      Text("This is Physics"),
      Text("This is Chemistry"),
      Text("This is Biology"),
      Text("This is Use of English"),
    ]);

*/

class Options extends StatefulWidget {
  final Map<String, String> options;

  const Options({
    super.key,
    required this.options,
  });

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}

class Option extends StatefulWidget {
  final String opt;

  const Option({
    super.key,
    required this.opt,
  });

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(40, 10, 40, 0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurStyle: BlurStyle.normal,
                blurRadius: 2,
                color: const Color.fromARGB(99, 158, 158, 158),
                offset: Offset.fromDirection(-1))
          ],
          color: Colors.white,
          // border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          setState(() {});
        },
        child: Html(
          data: widget.opt,
        ),
      ),
    );
  }
}

/*

Row(children: <Widget>[
          Expanded(
            child: Text(widget.optTag),
          ),
          Html(
            data: widget.opt,
          ),
        ])


        */

class QNavs extends StatefulWidget {
  const QNavs({super.key});

  @override
  State<QNavs> createState() => _QNavsState();
}

class _QNavsState extends State<QNavs> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 70, 104),
              borderRadius: BorderRadius.circular(5)),
          height: 40,
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Column(
                    children: [
                      Icon(Icons.keyboard_arrow_right),
                      Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
        )
      ],
    );
  }
}
