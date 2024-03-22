// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import '../Components/searchUser.dart';
import '../models/server_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:image_picker/image_picker.dart';
import '../Components/appbar.dart';
import '../Controller/elitebasis.dart';
import '../Controller/fields.dart';
import '../Controller/firebasehandler.dart';
import '../Controller/navigation.dart';
import '../database/datafields.dart';
import '../database/database_helper.dart';
import '../models/data/user.dart';
import '../models/env.dart';
import '../models/global_strings.dart';
import '../screens/common_widget.dart';
import 'tranHistory.dart';

class ProfileDetails extends StatefulWidget {
  final Map<String, Object> dataAcc;
  final String accNm, accPic, accAss, essence;

  // final Map<String, Object> data;

  const ProfileDetails({
    super.key,
    required this.accNm,
    required this.accAss,
    required this.accPic,
    required this.dataAcc,
    required this.essence,

    // required this.data,
  });

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  DatabaseHelper dbh = DatabaseHelper(table: usrTbl);
  // XFile? profPic;

  Future<List<Widget>>? futuredata;
  Future<Map<String, dynamic>>? data;
  late Navigate nvg;
  late TextEditingController _amount;
  late TextEditingController _searchedNm;
  @override
  initState() {
    super.initState();
    data = futureProfile();

    futuredata = fetchData();
    accBal = bonus = quotidian = voucher = "--";
    _searchedNm = TextEditingController();
    _amount = TextEditingController();
  }

  late String accBal;
  late String bonus;
  late String quotidian;
  late String voucher;

  Future<List<Widget>> fetchData() async {
    List<Widget> rslt = [];

    try {
      nvg = Navigate();
      late DatabaseHelper dbh;
      dbh = DatabaseHelper(table: appDtl);
      int qq = await dbh.queryRowCount();
      if (qq < 1) {
        await obtainDomain();
      } else {
        Map<String, Object> tag = widget.dataAcc;
        Map<String, dynamic>? hmp =
            await nvg.eliteApi(tag, desig, widget.essence, "", true, context);
        if (hmp!["status"]) {
          ServerResponse? svr = ServerResponse.fromJson(hmp);
          List data_ = svr.data;

          for (final item in data_) {
            accBal = item['Balance'];
            bonus = item['Bonus'];
            quotidian = item['Quotidian'];
            voucher = item['Voucher'];
          }
        } else {
          accBal = bonus = quotidian = voucher = "0.00";
        }

        setState(() {});
      }
    } catch (e) {}

    return rslt;
  }

  FutureBuilder<List<Widget>> stackData() {
    return FutureBuilder(
        future: futuredata,
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

  Future<Map<String, dynamic>>? futureProfile() async {
    Map<String, dynamic> gmm = {};

    DatabaseHelper dbh = DatabaseHelper(table: usrTbl);

    if (await dbh.queryRowCount() > 0) {
      List dtt = await dbh.queryAllRows();
      gmm = dtt[0];
    }
    return gmm;
  }

  Future<void> IndexProfile() async {
    Uint8List img = await profPic!.readAsBytes();
    // await saveData(name: ussr_.Name, bio: "bio", file: img, essence: usrPrf);
    String imgUrl = await saveDataToFbStorage(
        name: ussr_.Name.replaceAll(" ", "").toLowerCase() + ".png",
        bio: "bio",
        file: img,
        essence: usrPrf);
    logger("TheUrl: $imgUrl");
  }

  SingleChildScrollView castProfile(String stt) {
    String name = 'Aremu adebajo';
    String class_ = 'SSS 3 Student';
    String wallet = 'N 20,000.00';
    String email = 'apps@elitepage.ng';
    String gender = 'male';
    String phone = '+234 813 2547 993';
    String access = 'Student Access';

    switch (stt) {
      case dev:
        name = '';
        class_ = '';
        wallet = '';
        email = '';
        gender = '';
        phone = '';
        access = '';

        break;
      case prod:
        if (userprofile.isNotEmpty) {
          UserProfile usp = UserProfile.fromData(userprofile);
          name = usp.name;
          class_ = usp.class_;
          wallet = usp.wallet;
          email = usp.email;
          gender = usp.gender;
          phone = usp.phone;
          access = usp.access;
        }
        // userprofile

        break;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(40),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(24, 158, 158, 158),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(0, 2),
                      spreadRadius: 2)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    profPic != null
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: InkWell(
                              onTap: () {
                                Modal(
                                  context,
                                  300,
                                  Image.file(
                                    File(profPic!.path),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    FileImage(File(profPic!.path), scale: 80),
                              ),
                            ),
                          )
                        : SvgPicture.asset('assets/svg/user1.svg', width: 100),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            constraints: BoxConstraints(
                                maxHeight: 200,
                                minWidth: MediaQuery.of(context).size.width),
                            shape: const ContinuousRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50))),
                            builder: (context) {
                              return Column(children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 15, top: 20),
                                    child: const Text(
                                        'Update your profile Picture')),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          getFromgallery() async {
                                            final ImagePicker pickPic =
                                                ImagePicker();
                                            final profilePic =
                                                await pickPic.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              profPic = profilePic;
                                              IndexProfile();
                                            });
                                          }

                                          getFromgallery();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(200, 40),
                                            backgroundColor: bgmainclr),
                                        child: const Text('Gallery')),
                                    ElevatedButton(
                                        onPressed: () {
                                          getFromCamera() async {
                                            final ImagePicker pickPic =
                                                ImagePicker();
                                            final profilePic =
                                                await pickPic.pickImage(
                                                    source: ImageSource.camera);

                                            setState(() {
                                              profPic = profilePic;
                                              IndexProfile();
                                            });
                                          }

                                          getFromCamera();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(200, 40),
                                            backgroundColor: bgmainclr),
                                        child: const Text('Camera')),
                                  ],
                                ),
                              ]);
                            },
                            context: context);
                      },
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        class_ == '' ? 'Unverified' : class_,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: bgmainclr,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(24, 158, 158, 158),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(0, 2),
                      spreadRadius: 2)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.white,
                    ),
                    Text(
                      '₦ $accBal',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        constraints: const BoxConstraints(minHeight: 400),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(5))),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Container(
                                      height: 150,
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20, right: 20),
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          color: bgmainclr,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurStyle: BlurStyle.inner,
                                                blurRadius: 10,
                                                color: Color.fromARGB(
                                                    57, 46, 46, 46),
                                                offset: Offset(2, 2))
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Available Balance',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Text(
                                                    '₦ $accBal',
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        color: accentclr,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                              const Text(
                                                'Wallet',
                                                style:
                                                    TextStyle(color: accentclr),
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white),
                                                        onPressed: () {
                                                          Modal(
                                                              context,
                                                              500,
                                                              SingleChildScrollView(
                                                                child:
                                                                    Container(
                                                                  child: Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              Text('Enter Card Details'),
                                                                        ),
                                                                        Container(
                                                                            padding:
                                                                                const EdgeInsets.only(top: 5, bottom: 5),
                                                                            width: double.infinity,
                                                                            height: 60,
                                                                            child: TextField(
                                                                              readOnly: true,
                                                                              showCursor: true,
                                                                              minLines: 30,
                                                                              maxLines: 35,
                                                                              textAlignVertical: const TextAlignVertical(y: 1),
                                                                              decoration: InputDecoration(
                                                                                focusColor: Colors.white,
                                                                                hintText: 'Card Number',
                                                                                hintStyle: const TextStyle(color: Colors.grey),
                                                                                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 216, 216, 216)), borderRadius: BorderRadius.circular(5)),
                                                                                focusedBorder: const OutlineInputBorder(
                                                                                  borderSide: BorderSide(width: 1, color: Colors.blue),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                                margin: EdgeInsets.only(right: 15),
                                                                                width: 80,
                                                                                height: 60,
                                                                                child: TextField(
                                                                                  readOnly: true,
                                                                                  showCursor: true,
                                                                                  minLines: 30,
                                                                                  maxLines: 35,
                                                                                  textAlignVertical: const TextAlignVertical(y: 1),
                                                                                  decoration: InputDecoration(
                                                                                    focusColor: Colors.white,
                                                                                    hintText: 'CVV',
                                                                                    hintStyle: const TextStyle(color: Colors.grey),
                                                                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 216, 216, 216)), borderRadius: BorderRadius.circular(5)),
                                                                                    focusedBorder: const OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1, color: Colors.blue),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                            Container(
                                                                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                                width: 100,
                                                                                height: 60,
                                                                                child: TextField(
                                                                                  readOnly: true,
                                                                                  showCursor: true,
                                                                                  minLines: 30,
                                                                                  maxLines: 35,
                                                                                  textAlignVertical: const TextAlignVertical(y: 1),
                                                                                  decoration: InputDecoration(
                                                                                    focusColor: Colors.white,
                                                                                    hintText: 'Expire date',
                                                                                    hintStyle: const TextStyle(color: Colors.grey),
                                                                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 216, 216, 216)), borderRadius: BorderRadius.circular(5)),
                                                                                    focusedBorder: const OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1, color: Colors.blue),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                                width: 200,
                                                                                height: 60,
                                                                                child: TextField(
                                                                                  readOnly: true,
                                                                                  showCursor: true,
                                                                                  minLines: 30,
                                                                                  maxLines: 35,
                                                                                  textAlignVertical: const TextAlignVertical(y: 1),
                                                                                  decoration: InputDecoration(
                                                                                    focusColor: Colors.white,
                                                                                    hintText: 'Card Pin',
                                                                                    hintStyle: const TextStyle(color: Colors.grey),
                                                                                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 216, 216, 216)), borderRadius: BorderRadius.circular(5)),
                                                                                    focusedBorder: const OutlineInputBorder(
                                                                                      borderSide: BorderSide(width: 1, color: Colors.blue),
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: 30),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '1',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '2',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '3',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '4',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '5',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '6',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '7',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '8',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '9',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      '0',
                                                                                      style: TextStyle(color: Colors.black),
                                                                                    ),
                                                                                  ),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, fixedSize: Size(130, 40)),
                                                                                    onPressed: () {},
                                                                                    child: Text(
                                                                                      'Next',
                                                                                      style: TextStyle(color: Colors.green),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ),
                                                              ));
                                                        },
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/in.svg',
                                                              width: 12,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                          5.0),
                                                              child: const Text(
                                                                'Fund Wallet',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.white),
                                                      onPressed: () {
                                                        Modal(
                                                            context,
                                                            240,
                                                            Column(
                                                              children: [
                                                                Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            5),
                                                                    width: double
                                                                        .infinity,
                                                                    height: 60,
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          _searchedNm,
                                                                      minLines:
                                                                          30,
                                                                      maxLines:
                                                                          35,
                                                                      textAlignVertical:
                                                                          const TextAlignVertical(
                                                                              y: 1),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        focusColor:
                                                                            Colors.white,
                                                                        hintText:
                                                                            'Account Id',
                                                                        hintStyle:
                                                                            const TextStyle(color: Colors.grey),
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderSide:
                                                                                const BorderSide(width: 1, color: Color.fromARGB(255, 216, 216, 216)),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: Colors.blue),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              10),
                                                                  child: SearchUser(
                                                                      essence:
                                                                          '',
                                                                      data: {
                                                                        "Essence":
                                                                            "users",
                                                                        "State":
                                                                            "specific_tsk",
                                                                        "Specific":
                                                                            "Search",
                                                                        "Search":
                                                                            "oluwasheyi",
                                                                        "Column":
                                                                            "name"
                                                                      }),
                                                                ),
                                                                SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 60,
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          _amount,
                                                                      minLines:
                                                                          30,
                                                                      maxLines:
                                                                          35,
                                                                      textAlignVertical:
                                                                          const TextAlignVertical(
                                                                              y: 1),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        focusColor:
                                                                            Colors.white,
                                                                        hintText:
                                                                            'Amount',
                                                                        hintStyle:
                                                                            const TextStyle(color: Colors.grey),
                                                                        enabledBorder: OutlineInputBorder(
                                                                            borderSide:
                                                                                const BorderSide(width: 1, color: Color.fromARGB(255, 216, 216, 216)),
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        focusedBorder:
                                                                            const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: Colors.blue),
                                                                        ),
                                                                      ),
                                                                    )),
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            bgmainclr),
                                                                    onPressed:
                                                                        () {},
                                                                    child: const Text(
                                                                        'Confirm Transfer'))
                                                              ],
                                                            ));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/svg/out.svg',
                                                            width: 11,
                                                            color: Colors.red,
                                                          ),
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5.0),
                                                            child: Text(
                                                              'Transfer',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    nvg = Navigate();
                                                    late DatabaseHelper dbh;
                                                    dbh = DatabaseHelper(
                                                        table: appDtl);
                                                    int qq = await dbh
                                                        .queryRowCount();
                                                    if (qq < 1) {
                                                      customSnackBar(context,
                                                          "domain provisioning in progresss...");
                                                      await obtainDomain();
                                                    } else {
                                                      trnHistory = TransHistory(
                                                        data: {
                                                          "Essence":
                                                              "transactionary",
                                                          "State": "read_expl",
                                                          "Manifest": {
                                                            "User_ID":
                                                                ussr_.Unique_ID,
                                                            "Domain":
                                                                ussr_dmn.domain
                                                          }
                                                        },
                                                        essense: '',
                                                        exec: '',
                                                      );

                                                      Navigator.of(context)
                                                          .pushNamed(historyr);
                                                    }
                                                  },
                                                  child: const Text(
                                                    'History',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurStyle: BlurStyle.inner,
                                                blurRadius: 10,
                                                color: Color.fromARGB(
                                                    57, 46, 46, 46),
                                                offset: Offset(2, 2))
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Bonus',
                                            style: TextStyle(color: accentclr),
                                          ),
                                          Text('₦ $bonus',
                                              style: const TextStyle(
                                                  color: accentclr))
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurStyle: BlurStyle.inner,
                                                blurRadius: 10,
                                                color: Color.fromARGB(
                                                    57, 46, 46, 46),
                                                offset: Offset(2, 2))
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Voucher',
                                              style:
                                                  TextStyle(color: accentclr)),
                                          Text('₦ $voucher',
                                              style: const TextStyle(
                                                  color: accentclr))
                                        ],
                                      )),
                                  Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurStyle: BlurStyle.inner,
                                                blurRadius: 10,
                                                color: Color.fromARGB(
                                                    57, 46, 46, 46),
                                                offset: Offset(2, 2))
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Main Bal',
                                              style:
                                                  TextStyle(color: accentclr)),
                                          Text('₦ $quotidian',
                                              style: const TextStyle(
                                                  color: accentclr))
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(24, 158, 158, 158),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(0, 2),
                      spreadRadius: 2)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Email'),
                      Text(
                        email,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Gender'),
                      Text(
                        gender,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Phone'),
                      Text(
                        phone,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Access'),
                      Text(
                        access == '' ? 'Unverified' : access,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(24, 158, 158, 158),
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      offset: Offset(0, 2),
                      spreadRadius: 2)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Row(
                    //     children: [
                    //       Icon(Icons.settings_outlined, color: Colors.black),
                    //       Text(
                    //         ' Settings',
                    //         style: TextStyle(color: Colors.black),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    (!lone)
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(creatorReq);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svg/create.svg',
                                    // ignore: deprecated_member_use
                                    color:
                                        const Color.fromARGB(255, 6, 43, 73)),
                                const Text(
                                  ' Become a tutor',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 6, 43, 73)),
                                )
                              ],
                            ),
                          )
                        : const Text(""),
                    (!lone)
                        ? TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(lectrr);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svg/channel.svg',
                                    // ignore: deprecated_member_use
                                    color:
                                        const Color.fromARGB(255, 6, 43, 73)),
                                const Text(
                                  'My Channel',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 6, 43, 73)),
                                )
                              ],
                            ),
                          )
                        : const Text(""),
                    TextButton(
                      onPressed: () {
                        elucidate = const LearnMore(
                          image: 'assets/images/learnmore.png',
                          click: 'Leaderboard',
                          faqQst: 'Our Core Value:',
                          faqAns:
                              'ElitePage as a multimedia learning platform raise geniuses through mastery with comprehensive video lessons by scholars, Computer based test for learners with over 50,000 Questions in bank on UTME, WASSCE, JSCE, Basic Education Contents,  Undergraduate Courses, Professional Courses and lots more... \nContent tool for tutors and Educationists to implement real time CBT for anticipated audience... \n \n   ElitePage for schools is 100% free of charge to manage daily routines ranging from Result collation, Inventory management, Student Academic Records, Parental feedback and lots more.... \n No hidden charges, \nkindly visit www.elitepage.ng/schoools to get the app customised specifically for your school within 72hours.... \n\n    Are you competent enough to monetise your intellectual constructs as a teacher? If yes? you can earn big monthly with royalty by producing intellectual content as a teacher ElitePage is hinged upon raising geniuses through mastery thereby organises weekly national contest with great prizes being won on weekly bases worth ood fortune',
                          heading: 'About ElitePage',
                        );

                        Navigator.of(context).pushNamed(learnmore);
                        // showAlertDialog(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.read_more_rounded, color: Colors.black),
                          Text(
                            ' About us',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        dialogResponse(
                            context,
                            'Are you sure you want to log out?',
                            'Logout',
                            logout);

                        // Navigate().LogOut(context);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.logout_rounded, color: Colors.red),
                          Text(
                            ' Log out',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: AppHead(headtitle: 'Profile')),
        body: castProfile(appStatus));
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: const Text(
        "Get Help",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          height: 250,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text(
                      'About',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                  child: Column(
                    children: [
                      Text('About Us?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 3, 38, 66),
                              shadowColor: const Color.fromARGB(255, 3, 38, 66),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              minimumSize: const Size(180, 50)),
                          onPressed: () {},
                          child: const Text(
                            'About ElitePage',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: const Size(180, 50), //////// HERE
                        ),
                        onPressed: () {},
                        child: const Text(
                          'About School',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
