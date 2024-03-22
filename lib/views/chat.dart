import '../Components/appbar.dart';
import '../models/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatSection extends StatefulWidget {
  ChatSection({Key? key}) : super(key: chats);

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

// ignore: library_private_types_in_public_api
GlobalKey<_ChatSectionState> chats = GlobalKey();

class _ChatSectionState extends State<ChatSection> {
  String reciept = "Reading";
  String sent = "Sent";

  Future<void> updateUI(String snt, String rcp) async {
    setState(() {
      reciept = rcp;
      sent = snt;
      refresh = !refresh;
    });
  }

  bool refresh = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: AppHead(headtitle: 'Chat')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 110, left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: bgmainclr),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              (refresh) ? reciept : reciept,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Divider(
                                color: Color.fromARGB(132, 158, 158, 158)),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Mr Ajayi',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '9:44 am',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: bgmainclr),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              (refresh) ? sent : sent,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Divider(
                                color: Color.fromARGB(132, 158, 158, 158)),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Me',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '9:44 am',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {},
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 230,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, color: Colors.white),
                  ),
                  hintText: '|',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white)),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                cursorColor: Colors.grey,
                cursorWidth: 1,
              ),
            ),
            SizedBox(
              width: 40,
              child: TextButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    'assets/svg/send.svg',
                    width: 25,
                    // ignore: deprecated_member_use
                    color: bgmainclr,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Future<void> UpdateChats(String snt, String rcp) async {
  await chats.currentState!.updateUI(snt, rcp);
}
