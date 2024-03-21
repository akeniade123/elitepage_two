import 'dart:core';

import '../data/curriculum.dart';

import '../data/video.dart';
import '../models/env.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';

var shm = "showPrelim";
var lgn = "loginStatus";

bool pnd = false;
bool vld = false;

bool ntcb = false;

bool isAppActive = false;

const String dev = "development";
const String prod = "production";

const String server = "Server";
const String resident = "Resident";
const String repository = "Repository";

const String logout = 'Logout';

const String token = "token";
const String tk_id = "tokenId";
const String prlmtpc = "tpks";
const String defdm = "defaultdomain";

String fbId = community;
String payload = "payload";

String paystruct = "Paystruct";

const String tdash = '/teacherdashboard';
const String dash = '/dashboard';

const String rsltEntry = "Result Entry";
const String rslt = '/resultentry';

String generic_msg = '';

Map<String, dynamic> userprofile = {};

String id = "id";
String nm = "name";
String imag = 'image';
String gend = 'gender';

String subnm = "subname";
String dsc = "description";

String clr = "color";
String icn = "icon";
String dest = "destination";

String stt = "status";
String dtt = "data";
String msg = "message";

const String rqstAlbum = "album";
const String rqstElite = "elite";

const String communal = "Communal";
const String global = "Global";

const String desig = "base";
const String raw = "raw";
const String generic = "Generic";

const String reg = "Register";
const String login = "Login";
const String pswOTP = "PasswordOTP";
const String getAlbum = "getAlbum";

const String todo = "Todo";
const String ttbl = "Time Table";
const String cald = "Calendar";
const String cbt = "CBT";

const String cbtTask = "/cbtTask";
const String cbtRoute = '/cbt';

const String lsn = "Lesson Note";
const String crsv = "Course Review";

const String mnn = "Menu";
const String qstbnk = "Qst Bank";
const String orgn = "Organizer";
const String vdd = "Videos";
const String vdr = "VideoRow";
const String prm = "promo";
const String sbm = "submit";

const String srcAsset = "assets";

/// EliteApi
const String rd = "read";
const String rd_e = "read_expl";

const drw = '/drawer';
const essdest = 'essdest';
const tReg = "Students";
const tRegroute = "/registerstudent";
const tLearn = "/learn";
const sCalendar = "/calendar";
const stuCalendar = "calendar";
const sLog = "/log";

const tCourse = "Course Review";

const tLesson = "Lesson Note";
const tLsnroute = '/createlessonnote';
const tLsnroutev = '/createlessonnotevew';
const tAttnd = "Attendance";
const tAttndroute = '/attendance';
const notifyer = '/notification';
const slesson = '/lesson';
const stime = '/timetable';
const sreview = '/review';
const sbrain = '/brain';
const sPqBank = '/screen2';
const sResult = '/result';
const sTheory = '/theory';
const sCurriculum = '/curriculum';
const sFee = '/schlFee';
const sTodo = '/todoscreen';

////CBT Modes
////
///
const String exm = "Exam";
const String sty = "Study";
const String prtc = "Practice";

const String pref = 'My Preferences';

///
///
/////
///
///student dasboard
const sflow = 'Students Flow';
const dflow = 'default Flow';
const pflow = 'Parent Flow';
const mflow = 'Management Flow';
const aflow = 'Admin Flow';
const tflow = 'Teachers Flow';
const videos = '/videos';
const sBreakdown = '/breakdown';
const slessonNote = "/studentlesson";

const fbMsg = '/firebase';

//Management string

const sManage = 'Student Management';
const tManage = 'Teachers Management';
const cManage = 'Curriculun Management';
const cNewUsr = 'New Users';
const ttManage = 'Time Table Management';
const srmanageclist = '/studentmanagementclasslist';
const sctCls = '/sctCls';
const crsLst = '/crsList';
const cntLst = '/cntLst';
const ccnLst = '/ccnLst';
const srmanage = '/studentmanagement';
const trmanage = '/teachersmanagement';
const ttrmanage = '/timetablemanagement';
const crmanage = '/curriculummanagementclasslist';
const addcurr = '/addcurriculum';
const adtch = "Add Teachers";

const frmanage = '/feesmanagement';
const fManage = 'Fees Management';
const verifyt = '/verifyteacher';
const verifys = '/verifystudent';
const accD = 'Account Details Management';
const accrD = '/accoundetail';
const stdsv = '/viewstudents';

const String sct = "Section";
const String setFee = "Set Fee";
const String expPro = 'Add Expenses';
const String addBank = 'Add bank Account';
const String ussr_Category = '2';
String endgoal = '';
String phase = '';
const String sct_vs = "SectionViewStudents";

const String sct_e = "Sectioned";
const String bds = "bodies";
const String assc = "assoc";
const String facI = "Inst_fac";
const String facD = "Dept_fac";

Map<String, String> sct_var = {};
String sct_ttled = "";
String crs_cd = "";
String crsSub = "";
const String cls_tg = "class_tag";

const String avl = 'availability';
const String phs_ = 'phase';

//
//
//
const probtn = '/profile';
//Teachers string
//
const dNote = 'Digital Note';
const rManage = 'Results Management';
const mycl = "My Class";
const mysb = "My Subject";
const sAtt = 'Student Attendance';
const cRvw = 'Course Review';
const cbtq = 'Set CBT Question';
const import = "Import";
const open = "Open";
const repo = "Repository";
const new_ = "New";
const srRegister = '/studentregister';
const cCbt = '/createcbt';
const pCbt = '/practiceCbt';
const addStd = '/addstudents';
const alrt = '/alertbmsg';
const vResults = "View Results";

const vww = "View";

const myResult = '/myresult';
//
//
//
//Admin string
//
const vStudent = "View Student";
const vTeachers = "View Teachers";
const vTimt = "View Time Table";
const vrTimt = '/viewtimetale';
const vCrr = "View Curriculum";
const vResult = "View Results";
const vFees = "View Fees";
const vrStudent = "/viewstudent";
const vrTeachers = "/viewteachers";
const vrResult = "/viewresult";
const vrFees = "/viewfees";
const stds = '/managestudents';
const stdsvT = '/studentmanage';
const procurementv = '/viewprocument';
const addcurrv = '/addcurriculumview';
const classes4resltv = 'viewResults';
const stRsM = '/resultmanage';
const crsubj = 'createsubjects';
const srmanageclistv = '/studentmanagementclasslistview';

const String crlm = 'Curriculum';
const String dgnt = 'Digital Note';
const String fgrnd = 'Foreground';
const String bkrnd = 'Background';
const String islt = 'Isolate';
const String rssl = 'Result';
const String upload = 'Upload';
const String zipDir = "zipDirectory";
const String unzipDir = "unzipDirectory";
const String slctDir = "selectDirectory";
const String crfile = 'CreateFile';
const String readfile = 'ReadFile';
const String listfiles = "ListFiles";
const String dirExist = "dirExists";
const String encrypt_ = "encrypt";
const String decrypt_ = "decrypt";
const String crtDir = "createDir";
const String getfilepath = "getfilePath";

const String bbst = 'Best brain';
const String bbl = 'Best brain Live';
const String bba = 'Best brain Advert';

const String ldbd = 'Leader Board';
const String tmbl = 'Time Table';
const String srlz = 'Serialize CBT';
const String mycnt = 'My Contents';
const String adlct = "Add Lecture";

const String mtrcNo = "Assign AdmissionNo";
const String mtrcNo_1 = "Assign MatricNo";

const String crtSct = "Create Section";
const String crtSct_1 = "Create Program";

const String crSess = "Create Session";
const String crSess_1 = "Create Academic Year";

const String crSems = "Create Term";
const String crSems_1 = "Create Semester";

const String crCls = "Create Class";
const String crCls_1 = "Create Program Type";

const String crArms = "Create Arms";
const String crArms_1 = "Create Cohort";

const String crClsP = "Designate Class";
const String crClsP_1 = "Designate Program";

const String crtSbj = "Create Subject";
const String crtSbj_1 = "Create Course";

const String vldTch = "Validate Teacher";
const String vldStd = "Validate Student";
const String vldPrnt = "Validate Parent";

/*

                              list2: 'Lesson Note',
                              list3: 'Result',
                              list4: 'Best brain',
                              list5: 'Leader Board',
                              list6: 'CBT',
                              list7: 'Time Table',
                              list8: 'Serialize CBT', 

                              */

//
//
//
//
//////parent list
///
const vChildren = "View Children";
const vrChildren = "/viewchildren";
const vrBills = "/bills";
const vrAmt = "/amount";
const vTeacher = "View Teacher";
const vParent = "View Parent";
const vrTeacher = '/teacherlist';
const pFees = 'Fees Payment';
const prFees = '/feespayment';
const vCurriculum = "View Curriculum";
const vprCurriculum = '/viewparentcurriculum';
const parntv = '/viewparents';
const trmanagev = '/viewteacher';
const vrcResult = '/viewchildrenresult';
// const vrResults = "/resultview";
//
//

const ddash = '/defaultdashboard';

const learnmore = '/learnmore';
const nowplaying = '/nowplaying';
late VideoModel curr_vid;

String navEss = "";
String ttsCheck =
    "Access Bank plc, commonly known as Access Bank, is a Nigerian multinational commercial bank, owned by Access Bank Group. It is licensed by the Central Bank of Nigeria, the national banking regulator.[1] Originally a corporate bank, they expanded into personal and business banking in 2012. Access Bank and Diamond Bank merged on April 1, 2019. In conclusion of its merger with Diamond Bank, Access Bank unveiled its new logo, signalling the commencement of a new enlarged banking entity. The bank employs more than 28,000 people in 2021.[2] After the merger, with more than 42 million of customers, Access Bank plc became the largest bank in Africa by customer base, and the largest bank in Nigeria by asset.";
//
////
///
///defaltflow
const lectr = "Lectures";
const lectrr = "/lectures";
const cRev = "Course Reviews";
const fPay = 'Fees Payment';
const crRev = "/coursereview";
const qBks = "Question bank";
const qrBks = "/questionbanks";
const accStore = 'Academic Store';
const accArchive = 'Academic Archive';
const banky = '/banky';
const archv = '/archive';
const banks = "banks";
const procurement = "/procurement";
const mySub = "My Subscriptions";
const subscr = "Subscribe";
const tDo = "To Do List";
const trDo = '/todolist';
const bBrz = "BestBrainz MBT";
const chan = "/channels";

const String fac = "/faculty";
const String bdy_ = "/body";
const String fav = "/favourite";

const String sdyMode = "Study Mode";
const String exmMode = "Exam Mode";
const String rsltMode = "Result Mode";
const String prctMode = "Practice Mode";
const String lstMode = "Listening Mode";
const String explMode = "Explainer Mode";
const String prfMode = "ProofreadMode";
const String uplCBT = "UploadCBT";

const String cedar = "cedar";

const String clsmgt = 'classmanage';
const String clsvw = 'classview';
const String prtcCbt = 'practicecbt';
const String crrMgt = 'curriculummanage';
const String crlmVw = 'curriculumview';
const String clsRslt = 'classesResult';

late Widget cbtcontent;
late Widget courseReview;
late Widget myContents;
late Widget bdyCourses;
late Widget crsContents;
late Widget trnHistory;
late Widget elucidate;

late dashNote dnn;
late liveNote lnt;
late serverFile svrf;
late liveSession lss;
String dtls = "Awesome";
late List<Notice> lntc;

late Map<String, String> cbtStack;
String cbtCnt = "";
String outlineEss = "";
String slctItem = "";
late int cbtCog;

late BuildContext drwdlg, dshCtx, crrctx, bbCtx;
late BuildContext basedlg;

late Map<String, Map<String, List<Map<String, Map<String, String>>>>> scripts;

// late TextEditingController _searchedNm;

const brBrz = '/bestbrainzform';
////
///
///

const historyr = '/transactionhistory';

//////Profile details
const pDt = '/profile';
const conts = '/contents';
const chatr = '/chats';
const creatorReq = '/creatorrequest';
const classes = 'classes';
const classesv = 'classesview';

const parnt = '/parents';
const parents = 'Parent';
/////
const prof = '/profile';
const allusersP = '/allusersparent';
const allusersT = '/allusersteacher';
const crmanagec = '/curriculummanage';
const crmanagecv = '/curriculummanageview';
const accrDv = '/accountview';
const classes4cur = "class4curriculum";
const classes4curv = "class4curriculumview";

const allusersS = '/allusersstudent';
const addcur = '/addcurriculum';
const notify = '/notify';
const evntr = '/events';
const evnt = 'Events';
const abtr = '/aboutusinp';
const pndng = '/pending';
const texTest = "/flutterTeX";
XFile? profPic;

/////
////
////attendance
///
