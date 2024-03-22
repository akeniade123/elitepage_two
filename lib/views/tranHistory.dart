import '../Components/appbar.dart';
import '../Controller/navigation.dart';
import '../components/contDisplay.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//  "Amount": "10",

//             "description": "You generated an e-voucher with Pin:8892615922 and Serial No:898375565396",
//             "log_time": "2022-12-14 11:18:39",

class TransHistory extends StatefulWidget {
  final Map<String, Object> data;
  final String essense, exec;

  const TransHistory(
      {super.key,
      required this.data,
      required this.essense,
      required this.exec});

  @override
  State<TransHistory> createState() => _TransHistoryState();
}

class _TransHistoryState extends State<TransHistory> {
  Future<List<Widget>>? _futureContent;

  @override
  void initState() {
    _futureContent = fetchData();
  }

  Future<List<Widget>>? fetchData() async {
    List<Widget> rslt = [];
    final nvg = Navigate();

    Map<String, Object> tag = widget.data;
    Map<String, dynamic>? hmp =
        await nvg.eliteApi(tag, desig, widget.essense, "", true, context);

    if (hmp!["status"]) {
      ServerResponse? svr = ServerResponse.fromJson(hmp);
      List data_ = svr.data;

      for (final item in data_) {
        rslt.add(ContentDisplay(
          image: 'assets/images/transact.png',
          imgsize: 50.0,
          mainhead: '${'₦' + item["Amount"]}',
          purp: item["log_time"],
          description: item["description"],
        ));
      }
    } else {
      const Text('you currently a transaction history');
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
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: data_!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return data_[index];
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('an error occured');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppHead(headtitle: 'History')),
      body: SingleChildScrollView(
        child: Column(
          children: [stackData()],
        ),
      ),
    );
  }
}
