import '../database/datafields.dart';
import '../database/tbl_stack.dart';
import '../models/global_strings.dart';

Map<String, List<String>> procession() {
  Map<String, List<String>> prc = {};
  prc.addEntries({usrTbl: usrCln}.entries);
  prc.addEntries({rcnTbl: rcnCln}.entries);
  prc.addEntries({ctgTbl: ctgCln}.entries);
  prc.addEntries({crsTbl: crsCln}.entries);
  prc.addEntries({sct: sctCln}.entries);
  prc.addEntries({accTbl: accCln}.entries);
  prc.addEntries({frmTbl: frmCln}.entries);
  prc.addEntries({appDtl: appCln}.entries);
  prc.addEntries({paystruct: payloadCln}.entries);
  return prc;
}

Map<String, String> explicit() {
  Map<String, String> exp = {};
  exp.addEntries({todoTbl: todoCln}.entries);
//  exp.addEntries({feesManageTbl: feesManageCln}.entries);
  exp.addEntries({ldTbl: ldCln}.entries);
  exp.addEntries({prcTbl: prcCln}.entries);
  exp.addEntries({curriculumTbl: curriculumCln}.entries);
  exp.addEntries({pndTbl: pndCln}.entries);
  exp.addEntries({notificationTbl: ntfCln}.entries);
//  exp.addEntries({fvrTbl: pndCln}.entries);
//  exp.addEntries({newEntries});
  exp.addEntries({ttcnt: ttrCln}.entries);
  //exp.addEntries({paystruct:});

  return exp;
}
