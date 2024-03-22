import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Controller/fields.dart';
import '../controller/navigation.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../models/server_response.dart';

class SearchUser extends StatefulWidget {
  final Map<String, Object> data;
  final String essence;
  const SearchUser({super.key, required this.data, required this.essence});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  Future<List<Widget>>? _futureContent;
  late String userName;
  @override
  void initState() {
    super.initState();
    _futureContent = fetchData();
    userName = 'Loading...';
  }

  Future<List<Widget>>? fetchData() async {
    List<Widget> rslt = [];
    final nvg = Navigate();

    Map<String, Object> tag = widget.data;
    Map<String, dynamic>? hmp =
        await nvg.eliteApi(tag, desig, widget.essence, "", true, context);

    if (hmp!["status"]) {
      ServerResponse? svr = ServerResponse.fromJson(hmp);
      List data_ = svr.data;

      for (final item in data_) {
        String nmt = item["Name"];
        if (nmt != ussr_.Name) {
          rslt.add(item["Name"]);
        }
      }
    } else {
      const Text('No registered user currently');
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
    return Text(userName);
  }
}
