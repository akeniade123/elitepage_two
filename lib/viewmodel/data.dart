// ignore_for_file: unused_import, prefer_const_constructors

import '../database/datafields.dart';
import '../models/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Components/dashnotifier.dart';
import '../models/global_strings.dart';
import '../views/profilebtn.dart';
import '../views/profiledetails.dart';

//
///
/////
/////////
////////////Dashboards
/////
/////
//
//Managementdashboard

DashNotify mInfo = DashNotify(
  advertsvg: 'assets/svg/admin.svg',
  advertTtl: "Keep Track",
  ttlclr: Colors.orange,
  ttlCont: 'all the school activities',
  ttlEnd: 'With Ease',
  info: 'Very easy and reliable way to manage school activities',
  advEssence: 'Learn More',
);

ProfileButton mProfile = const ProfileButton(
    accNm: 'Adigun Manager',
    accPic: 'assets/images/blades.jpg',
    accAss: 'Management',
    dest: pDt);
// ProfileDetails mDetails = ProfileDetails(
//   accNm: 'Adigun Manager',
//   accPic: 'assets/images/blades.jpg',
//   accAss: 'Management',
// );
final List<Map> mBoards = [
  {
    nm: vStudent,
    subnm: "View all students in the school",
    dest: srmanageclist,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/pupil.svg',
  },
  {
    nm: vTeachers,
    subnm: "View all current teachers in the school",
    dest: trmanagev,
    clr: Colors.purple,
    icn: 'assets/svg/teach.svg',
  },
  {
    nm: vParent,
    subnm: "View all current parents of your school",
    dest: parntv,
    clr: Colors.teal,
    icn: 'assets/svg/parent1.svg',
  },
  {
    nm: vFees,
    subnm: "View fees for all classes",
    dest: vrFees,
    clr: Colors.green,
    icn: 'assets/svg/payment.svg',
  },
  {
    nm: vResults,
    subnm: "View results of all the student in the school",
    dest: vrResult,
    clr: Colors.blue,
    icn: 'assets/svg/result.svg',
  },
  {
    nm: vTimt,
    subnm: "View timetable for all classes",
    dest: vrTimt,
    clr: Colors.red,
    icn: 'assets/svg/table.svg',
  },
  {
    nm: 'View Curriculum',
    subnm: "View curriculum in all classes in the school",
    dest: crmanagecv,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: accD,
    subnm: "View and manage the school account for fees payment",
    dest: accrDv,
    clr: Colors.red,
    icn: 'assets/svg/accmanage.svg',
  },
  {
    nm: prcTbl,
    subnm: 'view previous school expenses and add recent ones',
    dest: procurementv,
    clr: Colors.orange,
    icn: 'assets/svg/expenses.svg',
  },
];

final List<Map> mBoards_1 = [
  {
    nm: vStudent,
    subnm: "View all students in the school",
    dest: srmanageclist,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/pupil.svg',
  },
  {
    nm: vTeachers,
    subnm: "View all current faciliators in the school",
    dest: trmanagev,
    clr: Colors.purple,
    icn: 'assets/svg/teach.svg',
  },
  {
    nm: vFees,
    subnm: "View fees for all classes",
    dest: vrFees,
    clr: Colors.green,
    icn: 'assets/svg/payment.svg',
  },
  {
    nm: vResults,
    subnm: "View results of all the student in the school",
    dest: vrResult,
    clr: Colors.blue,
    icn: 'assets/svg/result.svg',
  },
  /*
  {
    nm: vTimt,
    subnm: "View timetable for all classes",
    dest: vrTimt,
    clr: Colors.red,
    icn: 'assets/svg/table.svg',
  },
  */
  {
    nm: 'View Curriculum',
    subnm: "View curriculum in all classes in the school",
    dest: crmanagecv,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: accD,
    subnm: "View and manage the school account for fees payment",
    dest: accrDv,
    clr: Colors.red,
    icn: 'assets/svg/accmanage.svg',
  },
  {
    nm: prcTbl,
    subnm: 'view previous school expenses and add recent ones',
    dest: procurementv,
    clr: Colors.orange,
    icn: 'assets/svg/expenses.svg',
  },
];

//
//
///////
//////////

//teacherdashboard

DashNotify tInfo = DashNotify(
  advertsvg: 'assets/svg/organise.svg',
  advertTtl: "Organise",
  ttlclr: Colors.orange,
  ttlCont: 'and get all your task done',
  ttlEnd: 'Right here',
  info: 'Be renowned with your intellectual content',
  advEssence: 'Learn More',
);
ProfileButton tProfile = const ProfileButton(
    accNm: 'Adigun Teacher',
    accPic: 'assets/images/blades.jpg',
    accAss: 'Chemistry Teacher',
    dest: pDt);

final List<Map> tBoards = [
  {
    nm: rManage,
    subnm: "View and update your student results",
    dest: stRsM,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/result.svg'
  },
  {
    nm: sManage,
    subnm: "View and add new users as students of your class",
    dest: stdsvT,
    clr: Colors.orange,
    icn: 'assets/svg/manage.svg'
  },
  {
    nm: lectr,
    subnm: "You can uploads videos of course reviews",
    dest: lectrr,
    clr: Colors.purple,
    icn: 'assets/svg/learning10.svg'
  },
  {
    nm: dNote,
    subnm: "View and update lesson notes for your class",
    dest: tLsnroute,
    clr: Colors.green,
    icn: 'assets/svg/learning9.svg'
  },
  {
    nm: cbtq,
    subnm: "Set Mobile Based Test for you students to practice",
    dest: cCbt,
    clr: Colors.blue,
    icn: 'assets/svg/question.svg'
  },
  {
    nm: sAtt,
    subnm: "Mark and record attendance of student present in your class",
    dest: tAttndroute,
    clr: Colors.red,
    icn: 'assets/svg/attend.svg',
  },
  {
    nm: 'View Curriculum',
    subnm: "View curriculum in all classes in the school",
    dest: crmanagecv,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: qBks,
    subnm: 'Access and practice questions accross all level',
    dest: qstbnk,
    clr: Colors.orange,
    icn: 'assets/svg/lib11.svg'
  },

  //{nm: tAttnd, dest: tRegroute, clr: Colors.red, icn: 'assets/svg/cbt.svg'}
];
//
////
///////
/////
////
////
///
///
///Admin dasboard

DashNotify aInfo = DashNotify(
  advertsvg: 'assets/svg/management.svg',
  advertTtl: "Manage",
  ttlclr: Color.fromARGB(255, 6, 49, 83),
  ttlCont: 'all the school activities on',
  ttlEnd: 'One App',
  info: 'You can easily check records of your school activites at your pace',
  advEssence: 'Learn More',
);
ProfileButton aProfile = ProfileButton(
    accNm: 'Adigun Admin',
    accPic: 'assets/images/blades.jpg',
    accAss: 'Admin',
    dest: pDt);

final List<Map> aBoards = [
  {
    nm: sManage,
    subnm: "View and add new users as students of your school",
    dest: srmanageclist,
    clr: Colors.orange,
    icn: 'assets/svg/manage.svg'
  },
  {
    nm: tManage,
    subnm: "View and add new users as teachers or facilitators of your school",
    dest: trmanage,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/teach.svg'
  },
  {
    nm: 'Parent management',
    subnm: "View and add new users as parents of your school",
    dest: parnt,
    clr: Colors.teal,
    icn: 'assets/svg/parent1.svg',
  },
  {
    nm: fManage,
    subnm: "View and update fees to be paid accross all levels",
    dest: frmanage,
    clr: Colors.purple,
    icn: 'assets/svg/payment.svg'
  },
  {
    nm: cManage,
    subnm: "View and add curriculum for all classes in the school",
    dest: crmanagec,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: 'Courses',
    subnm: "View and add the school Subjects in all classes ",
    dest: crsubj,
    clr: Colors.orangeAccent,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: ttManage,
    subnm: "Create time table for all classes in the school",
    dest: ttrmanage,
    clr: Colors.blue,
    icn: 'assets/svg/table.svg'
  },
  {
    nm: accD,
    subnm: "View and manage the school account for fees payment",
    dest: accrD,
    clr: Colors.red,
    icn: 'assets/svg/accmanage.svg',
  },
  {
    nm: vResults,
    subnm: "View results of all the student in the school",
    dest: vrResult,
    clr: Colors.teal,
    icn: 'assets/svg/result.svg',
  },
  {
    nm: prcTbl,
    subnm: 'view previous school expenses and add recent ones',
    dest: procurement,
    clr: Colors.orange,
    icn: 'assets/svg/expenses.svg'
  },
  {
    nm: 'About us',
    subnm:
        "Update school mission, vision, email address, contact and other informationl",
    dest: abtr,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/about1.svg'
  },
  {
    nm: 'Notify',
    subnm: "Send general announcement to teachers, students or parents",
    dest: notify,
    clr: Colors.purple,
    icn: 'assets/svg/announce2.svg'
  },
  {
    nm: evnt,
    subnm: "View and manage the school events",
    dest: evntr,
    clr: Colors.red,
    icn: 'assets/svg/event.svg',
  },
];

final List<Map> aBoards_1 = [
  {
    nm: sManage,
    subnm: "View and add new users as students of the school",
    dest: srmanageclist,
    clr: Colors.orange,
    icn: 'assets/svg/manage.svg'
  },
  {
    nm: tManage,
    subnm: "View and add new users as facilitators of the school",
    dest: trmanage,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/teach.svg'
  },
  {
    nm: fManage,
    subnm: "View and update fees to be paid accross all levels",
    dest: frmanage,
    clr: Colors.purple,
    icn: 'assets/svg/payment.svg'
  },
  {
    nm: cManage,
    subnm: "View and add curriculum for all classes in the school",
    dest: crmanagec,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: 'Courses',
    subnm: "View and add the school Subjects in all classes ",
    dest: crsubj,
    clr: Colors.orangeAccent,
    icn: 'assets/svg/curriculum.svg'
  },
  /*
  {
    nm: ttManage,
    subnm: "Create time table for all classes in the school",
    dest: ttrmanage,
    clr: Colors.blue,
    icn: 'assets/svg/table.svg'
  },
  */
  {
    nm: accD,
    subnm: "View and manage the school account for fees payment",
    dest: accrD,
    clr: Colors.red,
    icn: 'assets/svg/accmanage.svg',
  },
  {
    nm: vResults,
    subnm: "View results of all the student in the school",
    dest: vrResult,
    clr: Colors.teal,
    icn: 'assets/svg/result.svg',
  },
  {
    nm: prcTbl,
    subnm: 'view previous school expenses and add recent ones',
    dest: procurement,
    clr: Colors.orange,
    icn: 'assets/svg/expenses.svg'
  },
  {
    nm: 'About us',
    subnm:
        "Update school mission, vision, email address, contact and other informationl",
    dest: abtr,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/about1.svg'
  },
  {
    nm: 'Notify',
    subnm: "Send general announcement to teachers, students or parents",
    dest: notify,
    clr: Colors.purple,
    icn: 'assets/svg/announce2.svg'
  },
  {
    nm: evnt,
    subnm: "View and manage the school events",
    dest: evntr,
    clr: Colors.red,
    icn: 'assets/svg/event.svg',
  },
];
//
//
/////
//////
///Parent dashboard

DashNotify pInfo = DashNotify(
  advertsvg: 'assets/svg/parent1.svg',
  advertTtl: "Unfold, Boost",
  ttlclr: Colors.purple.shade700,
  ttlCont: '& discover the hidden ability of your children, Right in',
  ttlEnd: 'Your Home',
  info: 'Participate in the upcoming BestBrainz contest',
  advEssence: "Learn More",
);
ProfileButton pProfile = const ProfileButton(
    accNm: 'Adigun Parent',
    accPic: 'assets/images/blades.jpg',
    accAss: 'Parent',
    dest: pDt);
// ProfileDetails pDetails = const ProfileDetails(
//   accNm: 'Adigun Parent',
//   accPic: 'assets/images/blades.jpg',
//   accAss: 'Parent',
// );
final List<Map> pBoards = [
  {
    nm: vChildren,
    subnm: "View and adopt all children from the school",
    dest: vrChildren,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/pupil.svg',
  },
  {
    nm: vTeacher,
    subnm: "View your children's teachers and their contacts",
    dest: trmanagev,
    clr: Colors.purple,
    icn: 'assets/svg/teach.svg',
  },
  {
    nm: pFees,
    subnm: "View and pay your children's Fees",
    dest: prFees,
    clr: Colors.green,
    icn: 'assets/svg/payment.svg',
  },
  {
    nm: vResults,
    subnm: "View your children's results",
    dest: vrcResult,
    clr: Colors.blue,
    icn: 'assets/svg/result.svg',
  },
  {
    nm: vTimt,
    subnm: "View what your children are currently having in class",
    dest: vrTimt,
    clr: Colors.red,
    icn: 'assets/svg/table.svg',
  },
  {
    nm: 'View Curriculum',
    subnm: "View curriculum in all classes in the school",
    dest: crmanagecv,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
];
////
////////
/////
/////
//////
///
//default flow

DashNotify ddInfo2 = DashNotify(
  advertsvg: 'assets/svg/Exams.svg',
  advertTtl: "Unlocking Excellence",
  ttlclr: Colors.blue,
  ttlCont: 'through mastery with 100% certified content accross ',
  ttlEnd: 'All Levels',
  info: 'Participate in the upcoming BestBrainz contest',
  advEssence: 'Learn More',
);

ProfileButton dProfile2 = ProfileButton(
    accNm: 'Olushola Student',
    accPic: 'assets/images/blades.jpg',
    accAss: 'Unverified User',
    dest: pDt);
final List<Map> ddBoards2 = [
  /*
  {
    nm: 'Primary School',
    subnm: 'Watch all course review videos at your pace',
    dest: banky,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/learning11.svg',
  },
  {
    nm: 'Secondary School',
    subnm: 'View and access your courses here',
    dest: banky,
    clr: Colors.purple,
    icn: 'assets/svg/study.svg',
  },
  {
    nm: 'Tetiary Institutions',
    subnm: 'Access and practice questions accross all level',
    dest: banky,
    clr: Colors.orange,
    icn: 'assets/svg/lib11.svg'
  },
  */
  {
    nm: tDo,
    subnm: 'Set and keep track all your need to do',
    dest: sTodo,
    clr: Colors.green,
    icn: 'assets/svg/learning8.svg',
  },
  {
    nm: bBrz,
    subnm: 'Demo Mode',
    dest: qrBks,
    clr: Colors.blue,
    icn: 'assets/svg/bestb.svg',
  },
  {
    nm: accStore,
    subnm: 'Access and practice questions accross all level',
    dest: banky,
    clr: Colors.orange,
    icn: 'assets/svg/lib11.svg'
  }
];

final List<Map> ddBoards_ = [
  {
    nm: lectr,
    subnm: 'Watch all course review videos at your pace',
    dest: videos,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/learning11.svg',
  },
  /*
  {
    nm: mySub,
    subnm: 'View and access your courses here',
    //dest: mrsub,
    clr: Colors.purple,
    icn: 'assets/svg/study.svg',
  },
  */
  {
    nm: tDo,
    subnm: 'Set and keep track all your need to do',
    dest: sTodo,
    clr: Colors.green,
    icn: 'assets/svg/learning8.svg',
  },
  {
    nm: bBrz,
    subnm: 'Demo Mode',
    dest: qrBks,
    clr: Colors.blue,
    icn: 'assets/svg/bestb.svg',
  },
  {
    nm: accStore,
    subnm: 'Access and practice questions accross all level',
    dest: banky,
    clr: Colors.orange,
    icn: 'assets/svg/lib11.svg'
  },
];

DashNotify sInfo = DashNotify(
  advertsvg: 'assets/svg/Exams.svg',
  advertTtl: "Are you smart?",
  ttlclr: Colors.blue,
  ttlCont: 'can you answer 100 questions in',
  ttlEnd: 'One Hour ?',
  info: 'Participate in the upcoming BestBrainz contest',
  advEssence: 'Learn More',
);

ProfileButton sProfile = ProfileButton(
    accNm: 'Olushola Student',
    accPic: 'assets/images/blades.jpg',
    accAss: 'Unverified User',
    dest: pDt);
final List<Map> sBoards = [
  {
    nm: lectr,
    subnm: 'Watch all course review videos at your pace',
    dest: videos,
    clr: Color.fromARGB(255, 2, 4, 80),
    icn: 'assets/svg/learning11.svg',
  },
  {
    nm: dNote,
    subnm: "View and update lesson notes for your class",
    dest: tLsnroutev,
    clr: Colors.green,
    icn: 'assets/svg/learning9.svg'
  },
  {
    nm: 'View Curriculum',
    subnm: "View curriculum in all classes in the school",
    dest: crmanagecv,
    clr: Colors.green,
    icn: 'assets/svg/curriculum.svg'
  },
  {
    nm: "Practice CBT",
    subnm: "Set Mobile Based Test for you students to practice",
    dest: pCbt,
    clr: Colors.blue,
    icn: 'assets/svg/question.svg'
  },
  {
    nm: vResults,
    subnm: "View your children's results",
    dest: myResult,
    clr: Colors.blue,
    icn: 'assets/svg/result.svg',
  },
  {
    nm: vTimt,
    subnm: "What's next on the time table",
    dest: vrTimt,
    clr: Colors.red,
    icn: 'assets/svg/table.svg',
  },
  {
    nm: tDo,
    subnm: 'Set and keep track all your need to do',
    dest: sTodo,
    clr: Colors.green,
    icn: 'assets/svg/learning8.svg',
  },
  {
    nm: bBrz,
    subnm: 'Demo Mode',
    dest: qrBks,
    clr: Colors.blue,
    icn: 'assets/svg/bestb.svg',
  },
  {
    nm: mySub,
    subnm: 'View and access your courses here',
    // dest: mrsub, // srmanageclist,
    clr: Colors.purple,
    icn: 'assets/svg/study.svg',
  },
  {
    nm: accStore,
    subnm: 'Access and practice questions accross all level',
    dest: banky,
    clr: Colors.orange,
    icn: 'assets/svg/lib11.svg'
  },
];

List<String> paneStack(String category) {
  List<String> pane = [];
  int sect = int.parse(category);
  switch (sect) {
    case 4:
      pane = [bbst, prfMode];
    case 2:
      pane = [
        crtSct_1,
        crSess_1,
        crSems_1,
        crCls_1,
        crArms_1,
        crClsP_1,
        crtSbj_1,
        mtrcNo_1,
      ];
      break;
    case 3:
      pane = [
        crtSct,
        crSess,
        crSems,
        crCls,
        crArms,
        crClsP,
        crtSbj,
        mtrcNo,
      ];
      break;
  }
  return pane;
}

final List<String> apane = [
  mtrcNo,
  crtSct,
  crSess,
  crSems,
  crCls,
  crArms,
  crClsP,
  crtSbj
];

final List<String> tpane = [dgnt, prfMode, crtSbj];

final List<String> tpane_ = [
  srlz,
  mycnt,
  upload,
  crfile,
  readfile,
  dirExist,
  encrypt_,
  slctDir,
  crtDir,
  listfiles,
  getfilepath,
  zipDir,
  unzipDir,
  bbst,
  dgnt,
  fgrnd,
  bkrnd,
  islt
];

final List<String> dpane = [bbst, dgnt];
