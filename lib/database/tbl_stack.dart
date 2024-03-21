import '../models/global_strings.dart';
import 'datafields.dart';

List<String> usrCln = [
  nmm,
  unq,
  phn,
  cph,
  slt,
  gnd,
  dvd,
  ctg,
  sct,
  eml,
  fbd,
  ind,
  phs,
  elg,
  crt,
  upd
];

// List<String> feesCln = [pup, des, prc];
// List<String> ldCln = [
//   nmm,
//   sch,
//   scr,
//   cls,
//   tme,
// ];
// List<String> prcCln = [
//   itm,
//   dte,
//   des,
//   prc,
// ];

List<String> rcnCln = [ID_, usd, dmn, bal, bns, qtd, vch, ltn];

List<String> ctgCln = [id_, tag];
List<String> crsCln = [id_, fbg, cdd, ttl, bdy];

List<String> accCln = [
  ref,
  nmm.toLowerCase(),
  dmn.toLowerCase(),
  usr,
  crc,
  prc,
  acy
];
List<String> frmCln = [
  id_,
  tag,
  env,
  desig,
  pyt,
  crrTbl,
  dsg,
  syc,
  shr,
  ctc,
  fbs,
  ssn,
  trm
];

List<String> appCln = [dmn_, nm, bnk, crrTbl, pls, ctc, fbs, ssn_, trm];

List<String> payloadCln = [id_, payload];

/*
{domain: 122, 
name: Sumise Schools, 
bank: , 
currency: &#x20A6;, playstore: , contact: , fb_sect: 3, session: 255949, term: 497084}], message: domains fetched...}
*/

/*
            {
                "status": true,
                "data": [
                    {
                        "domain": "107",
                        "name": "ElitePage",
                        "bank": "CARRICARE TECHNOLOGIES LIMITED#1648385724#Access Bank",
                        "currency": "",
                        "playstore": "https://play.google.com/store/apps/details?id=com.dlvtech.elitepage",
                        "contact": "+2348132547993",
                        "fb_sect": "2",
                        "session": "5346753",
                        "term": "5457512"
                    }
                ],
                "message": "domains fetched..."
            }
            */

List<String> sctCln = [id_, "section", "phase", avl, unq, createdAt, updtm];

String todoCln =
    "$id_ INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $ttl TEXT, $note TEXT, $deadline TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";

String feesManageCln =
    "$pup TEXT, $prc INT, $des TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";

String ldCln =
    "$pup TEXT, $prc INT, $des TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";

String prcCln =
    "$pup TEXT, $prc INT, $des TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";
String curriculumCln =
    "$pup TEXT, $prc INT, $des TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";

String pndCln =
    "$id_ INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $url TEXT, $pkt TEXT,$mmn TEXT, $est TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";

String ttrCln =
    "$id_ INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $ttl TEXT, $key TEXT, $flln TEXT, $createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, $updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ";

String ntfCln =
    "$id_ INTEGER PRIMARY KEY NOT NULL,$cnt TEXT, $cpt TEXT, $ttl TEXT, $dtl TEXT, $createdAt TIMESTAMP NOT NULL ";


/*
{"title": "Robotics Exams",
        "Content": "The kits are necessary",
        "Details": "The Essence of the kits can't be overemphasized being the driving wheel upon which every of the processions is hinged upon, let's get things going efficiently."
  }
*/