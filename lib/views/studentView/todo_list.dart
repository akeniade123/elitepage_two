import 'dart:developer';

import 'package:flutter/material.dart';
import '../../Components/appbar.dart';
import '../../Components/Todo.dart';
import '../../components/progress.dart';
import '../../database/database_helper.dart';
import '../../database/datafields.dart';
import '../../screens/common_widget.dart';

void main() {
//  runApp(const ToDo_Screen());
}

class ToDo_Screen extends StatefulWidget {
  ToDo_Screen({Key? key}) : super(key: _processKey);

  // const MyWidget ({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ToDoPageState();
}

GlobalKey<_ToDoPageState> _processKey = GlobalKey();

class _ToDoPageState extends State<ToDo_Screen> {
  final List<Map<String, dynamic>> _todos = [];

  Future<List<Widget>>? myData;

  final GlobalKey<_ToDoPageState> _stateKey = GlobalKey();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    myData = _obtainData();
  }

  bool _isLoading = true;

  Future<List<Widget>>? _obtainData() async {
    List<Widget> rslts = [];

    DatabaseHelper dbh = DatabaseHelper(table: todoTbl);
    try {
      if (await dbh.queryRowCount() > 0) {
        List<Map<String, dynamic>> dtt = await dbh.queryAllRows();
        for (int i = 0; i < dtt.length; i++) {
          Map<String, dynamic> dtt_ = dtt[i];
          rslts.add(todo(dtt_[ttl], dtt_[note], dtt_[deadline]));
        }
      } else {}
      _isLoading = false;
      setIt();
    } catch (e) {
      log("Bolu error: ${e.toString()}");
    }
    _isLoading = false;
    return rslts;
  }

  void setIt() {
    log("Awesome");
    setState(() {});
  }

  Future<void> RefreshIt() async {
    myData = _obtainData();
    log("Refeshed...");
    setState(() {});
  }

  FutureBuilder<List<Widget>> castData() {
    return FutureBuilder(
        future: myData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget>? data_ = snapshot.data;
            int size = data_!.length;

            if (size > 0) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: size,
                        padding: const EdgeInsets.all(8),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return data_[index];
                        })
                  ],
                ),
              );
            } else {
              return noEntry();
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return ProgressLevel(prg_message: "loading data");
        });
  }

  Column todo(String title, String body, String time) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(61, 158, 158, 158),
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.article,
                  color: Color.fromARGB(255, 3, 38, 66),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Todolist(
                        txt1: title,
                        txt2: body,
                        txt3: 'Deadline: ',
                        dtym: time)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        )
      ],
    );
  }

  Container todos() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
              'Today',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Center noEntry() {
    return const Center(
      child: Text(
        'You have not created any todo yet...',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Center loaData() {
    return Center(
      child: ProgressLevel(prg_message: "Loading..."),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppHead(headtitle: 'To Do'),
      ),
      body: (_isLoading == true) ? loaData() : castData(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 3, 38, 66),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            TextEditingController ttl_ = TextEditingController();
            TextEditingController note_ = TextEditingController();
            TextEditingController deadline_ = TextEditingController();

            Map<Map<String, String>, TextEditingController> fields = {
              {txtEdt: ttl}: ttl_,
              {txtEdt: note}: note_,
              {txtEdt: schedule}: deadline_
            };

            Modal(
                context,
                300,
                formContent("Todo List", fields, todoTbl, "Add", context,
                    _scaffoldKey));
          }),
    );
  }
}

typedef VoidCallback = void Function(Color color);

Future<void> refeshData() async {
  log("Refresh this");
  await _processKey.currentState!.RefreshIt();
}
