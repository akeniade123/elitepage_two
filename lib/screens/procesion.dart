import 'dart:developer';

import '../components/attendee.dart';
import '../screens/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../Components/appbar.dart';
import '../../Controller/elitebasis.dart';
import '../../Controller/fields.dart';
import '../../Controller/navigation.dart';
import '../../database/datafields.dart';
import '../../models/endpoints.dart';
import '../../models/global_strings.dart';

class ProcessionClassList extends StatefulWidget {
  final Map<String, Object> tagged;
  final String domain, essence, endgoal, title, view_, function;

  const ProcessionClassList(
      {super.key,
      required this.tagged,
      required this.essence,
      required this.endgoal,
      required this.title,
      required this.view_,
      required this.domain,
      required this.function});

  @override
  State<ProcessionClassList> createState() => _ProcessionClassListState();
}

class _ProcessionClassListState extends State<ProcessionClassList> {
  Future<List<Widget>>? _futureclasses;
  late Navigate nvg;
  late Endpoint enp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nvg = Navigate();
    enp = Endpoint();

    switch (widget.view_) {
      case tAttnd:
      case ttManage:
        break;
      case '2':
        break;
      case sCalendar:
        break;

      case crsTbl:
        _futureclasses = obtainData(widget.tagged, widget.domain,
            widget.essence, "", widget.endgoal, widget.function, true, context);

        break;
      case crsCnt:
        _futureclasses = obtainData(widget.tagged, widget.domain,
            widget.essence, "", widget.endgoal, widget.function, true, context);

        break;

      default:
        _futureclasses = obtainData(widget.tagged, widget.domain,
            widget.essence, "", widget.endgoal, widget.function, true, context);

        /*
        _futureclasses = obtainData(
          widget.tagged,
          widget.essence,
          widget.endgoal,
        );
        */
        break;
    }
  }

  Widget modalPane(BuildContext context, double hth, String title,
      Widget futureWidget, Future<List<Widget>>? futureclasses) {
    return Modal(
        context,
        hth,
        SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Container(
                          child: (futureclasses == null)
                              ? const Text(" No Data Yet")
                              : futureWidget),
                    ]),
              )),
        ));
  }

  @override
  build(BuildContext context) {
    switch (widget.view_) {
      case crsCnt:
      case crsTbl:
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: AppHead(
              headtitle: widget.title,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: Container(
                child: (_futureclasses == null)
                    ? const Text(" No Data Yet")
                    : castData(_futureclasses, widget.function, widget.essence,
                        endgoal)),
          ),
        );
      case tAttnd:

      /*
        DateTime now = DateTime.now();

        String formattedDate = DateFormat.yMMMMd('en_US');
        //  DateFormat("'Date:' EEEE,  MM dd yyyy").format(now);
        String formattedTime = DateFormat("'Time:' hh : mm : ss").format(now);

        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: AppHead(
              headtitle: 'Mark Attendance',
            ),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        formattedDate,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        formattedTime,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )
                  ],
                ),
                ListView(
                  children: Mockserver(),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Modal(context, 100, const Text('Successfully logged!'));
            },
            label: const Text('Submit'),
            backgroundColor: const Color.fromARGB(255, 3, 38, 66),
          ),
        );
      */

      case ussr_Category:
      case ttManage:
        List<Appointment> getAppointment() {
          List<Appointment> meetings = <Appointment>[];
          final DateTime today = DateTime.now();
          final DateTime startTime =
              DateTime(today.year, today.month, today.day, 20, 0, 0);
          final DateTime endTime = startTime.add(const Duration(hours: 1));

          final DateTime yesterday = DateTime.now();

          meetings.add(
            Appointment(
                startTime: startTime,
                endTime: endTime,
                subject: 'CAP111',
                color: Colors.green),
          );
          return meetings;
        }

        //SELECT * FROM `course` WHERE `code` IN (ELB701,ELM701);

        return Scaffold(
          floatingActionButton: Visibility(
              visible: (ussr_.Category == "2") ? true : false,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 3, 38, 66),
                foregroundColor: Colors.white,
                onPressed: () {
                  (ussr_.Category == "2")
                      ? log("You pressed fab hust now...")
                      : {};
                  // Navigator.of(context).push(Btns as Route<Object?>);
                },
                child: const Icon(
                  Icons.add,
                ),
              )),
          appBar: const PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: AppHead(headtitle: 'Time Table')),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ongoing',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enterpreneurship in culinary Arts',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text('08:00pm - 09:00pm')
                  ],
                ),
                const SizedBox(
                  height: 39,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next lecture',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Drinks, Wine and Spirit',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text('08:00pm - 09:00pm'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        SfCalendar(
                            view: CalendarView.week,
                            firstDayOfWeek: 7,
                            dataSource: MeetingDataSource(getAppointment())),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );

      default:
        return SizedBox(
          height: 300,

          /*
            child: modalPane(
                context, 350, widget.title, classesResult(), _futureclasses)
*/
          child: AlertDialog(
              content: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title),
                        Container(
                            child: (_futureclasses == null)
                                ? const Text(" No Data Yet")
                                : castData(_futureclasses, widget.function,
                                    widget.essence, endgoal)),
                      ]),
                )),
          )),
        );
    }
  }

  Text pagePreload(String presTatus) {
    return Text(presTatus);
  }

  Widget _UserItem() {
    return Column(
      children: [
        Attendee(
          name: 'Aloba Samson',
          matricNo: '233443',
          gender: 'Male',
          presence: false,
          matric_no: '',
        )
      ],
    );
  }

  List<Widget> Mockserver() {
    List<Widget> users = [];
    for (var i = 0; i < 1000; i++) {
      users.add(_UserItem());
    }
    return users;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
