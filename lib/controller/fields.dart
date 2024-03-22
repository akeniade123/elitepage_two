// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import '../controller/navigation.dart';
import '../controller/requester.dart';
import '../models/global_strings.dart';
import 'package:flutter/material.dart';

import '../database/datafields.dart';
import '../models/data/user.dart';
import '../models/env.dart';
import '../models/server_response.dart';
import '../views/studentView/cbtDisplay.dart';

const String serial = "Serial";
late User ussr_;
late UserDomain ussr_dmn;

late BuildContext? dlg;
late BuildContext? baseCtx;

late Widget init;

late bool notifyDash;
late String ttl_nw, cnt_nw, end_nw, info_nw, dtls_nw;

Future<Map<String, dynamic>?> contentConvert_(String text) async {
  //#\b([0-9]|[1-9][0-9])\b.

  Map<String, dynamic> flaw = {};

  List<String> instruct =
      text.split(RegExp("(?<=instruct\")(.*)(?=\"range\")"));

  try {
    if (instruct.isNotEmpty) {
      for (int i = 0; i < instruct.length; i++) {}
    } else {
      return contentConvert(text);
    }
  } catch (e) {}
  return null;
}

String tmn = "terminate";

Future<String?> collateTopics(String url, String subject, String exam, int dlm,
    BuildContext context) async {
  try {
    List<String> ppt = [];

    /*
        String url =
            "https://myschool.ng/classroom/$subject?exam_type=$exam&exam_year=&topic=";
        //  "https://myschool.ng/classroom/$subject?exam_type=$exam&topic=";
    */

    String url_ =
        "https://myschool.ng/classroom/$subject?exam_type=$exam&topic=";

    logger("Prelim: $url");
    logger("Post:  $url_");

    String? response = await getReqString(url, "", context, false, 5);

    logger("The response: got a response...");

    List<String> tpcc = response
        .split(RegExp("<option value selected=\"selected\">All</option>"));
    String sectSelect = tpcc[dlm];

    String divSpr = sectSelect.split("</div>")[0];

    List<String> tpcs = divSpr.split(RegExp("<option value=\""));
    for (int i = 0; i < tpcs.length; i++) {
      if (i > 0) {
        String tpcGet =
            tpcs[i].replaceAll("</option>", ""); //.split(RegExp("source"));

        String tpd = tpcGet.split(RegExp("\">"))[1];

        //  logger("ThisTopic: $ppt");

        ppt.add(tpd);
      }
    }

    logger("${ppt.length} topics available");

    for (int i = 0; i < ppt.length; i++) {
      logger("This Point: ${ppt[i]}");
      await getContent(context, subject, exam, ppt[i]);
    }
  } catch (e) {
    logger("The error: $e");
  }
}

Future<String?> getContent(
    BuildContext context, String subject, String exam, String topic) async {
  List<Map<String, dynamic>> qstnz = [];

  int index = 1;

  String cnt = "";
  while (cnt != tmn) {
    // ignore: use_build_context_synchronously
    String? rsp = await scoopTopic(context, subject, exam, topic, index);

    logger(
        "Exam: ${exam.toUpperCase()} Subject: $subject Topic: $topic  Page: $index");
    if (rsp != tmn) {
      // ignore: use_build_context_synchronously
      List<Map<String, dynamic>>? bmm =
          await scoop(rsp, subject, exam, topic, context);
      try {
        if (bmm!.isNotEmpty) {
          qstnz.addAll(bmm);
        }
        index++;
      } catch (e) {
        logger("terminated: $e");
      }
    } else {
      cnt = tmn;
    }
  }

  String vnt = jsonEncode(qstnz);
  logger("The_totality: ${jsonEncode(qstnz)}");

  Map<String, dynamic> mnfst = {
    "subject": subject,
    "exam": exam,
    "topic": topic
  };
  /*
  Map<String, dynamic> entries = {"content": vnt};
  

  Navigate nvg = Navigate();

  Map<String, dynamic>? ressp = await nvg.entry(
      "quiz_repo", mnfst, entries, mnfst, global, "", "", false, crt_, context);
*/
}

void getQuestionSize(BuildContext context) async {
  List<String> sbstk = ["Physics", "Chemistry", "Biology"];

  for (String item in sbstk) {
    await stackMagnitude(item, context);
  }
}

void collateJambSciences(BuildContext context, String subject, String url) {
  collateTopics(url, subject, "jamb", 3, context);
}

void collateJambEnglish(BuildContext context, String subject, String url) {
  collateTopics(url, subject, "jamb", 3, context);
}

Future<String?> stackMagnitude(String subj, BuildContext context) async {
  sct_var = {"subject": subj};
  Navigate nvg = Navigate();

  Map<String, Object> tag = {
    "Essence": "quiz_repo",
    "State": rd_e,
    "Manifest": sct_var
  };

  Map<String, dynamic>? dpp =
      await nvg.eliteApi(tag, global, "", "", false, context);

  if (dpp!["status"]) {
    ServerResponse? svr = ServerResponse.fromJson(dpp);

    logger("AdexResponse: Data Exists");

    List data_ = svr.data;

    logger("AdexResponse Log: ${data_.length}");

    for (final item in data_) {
      try {
        logger("AdexSubject: ${item["topic"]}");
        List dyn = jsonDecode(item["content"]);
        if (dyn.length > 0) {
          Map<String, dynamic> mnfst = {
            "subject": item["subject"],
            "exam": item["exam"],
            "topic": item["topic"]
          };

          Map<String, dynamic> entries = {
            "magnitude": "${dyn.length} questions"
          };

          logger("AdexResponse on ${item["topic"]}:  ${dyn.length} questions");

          Navigate nvg = Navigate();

          Map<String, dynamic>? ressp = await nvg.entry("quiz_repo", mnfst,
              entries, mnfst, global, "", "", false, upd_, context);
        }
      } catch (e) {
        logger("AdexPerceiced Error: $e");
      }
    }
  } else {
    logger("AdexResponse: No Data");
  }
}

Future<String> scoopTopic(BuildContext context, String subject, String exam,
    String topic, int page) async {
  String rslt = "";
  String tpcc = topic.replaceAll(" ", "-").toLowerCase();
  tpcc = tpcc.replaceAll(",", "").replaceAll("</select>", "");
  String url =
      "https://myschool.ng/classroom/$subject?exam_type=$exam&topic=$tpcc&page=$page";

  String? response = await getReqString(url, "", context, false, 5);

  List<String> prtc = response.split(RegExp("Practice Exam"));

  if (prtc.length > 1) {
    List<String> content =
        response.split(RegExp("<div class=\"media question-item mb-4\">"));
    if (content.length > 1) {
      rslt = response;
    } else {
      rslt = tmn;
    }
  }
  return rslt;
}

Future<String?> scoopGPT(String text, BuildContext context) async {
  String optn_a, optn_b, optn_c, optn_d, optn_e, qsst, qsst_n, expl;
  List<Map<String, dynamic>> qstnz = [];

  try {
    List<String> qstnSpr = text.split(RegExp("Question:"));
    for (int i = 0; i < qstnSpr.length; i++) {
      if (i > 0) {
        List<String> qstn_ans = qstnSpr[i].split(RegExp("Options:"));
        String qsst = qstn_ans[0];
        String anzz = qstn_ans[1];

        List<String> optn_ans = anzz.split(RegExp("Answer: "));
        String optnx = optn_ans[0];
        List<String> Optionz = optnx.split(RegExp("[a-e][\)]"));

        optn_a = optn_b = optn_c = optn_d = optn_e = "";

        for (int j = 0; j < Optionz.length; j++) {
          if (j > 0) {
            if (j == 1) {
              optn_a = Optionz[j];
            } else if (j == 2) {
              optn_b = Optionz[j];
            } else if (j == 3) {
              optn_c = Optionz[j];
            } else if (j == 4) {
              optn_d = Optionz[j];
            } else if (j == 5) {
              optn_e = Optionz[j];
            }
          }
        }

        String optn_expl = optn_ans[1];

        List<String> opp = optn_expl.split(RegExp("Explanation:"));

        String crrt = opp[0];
        String expp = opp[1];

        List<String> ans_ = crrt.split(RegExp("[\)]"));

        String optt = ans_[0];

        if (optt.contains("a")) {
          crrt = "A";
        } else if (optt.contains("b")) {
          crrt = "B";
        } else if (optt.contains("c")) {
          crrt = "C";
        } else if (optt.contains("d")) {
          crrt = "D";
        } else if (optt.contains("e")) {
          crrt = "E";
        }

        Map<String, dynamic> qna = {
          "question_no": i,
          "question": qsst,
          "option_a": optn_a,
          "option_b": optn_b,
          "option_c": optn_c,
          "option_d": optn_d,
          "option_e": optn_e,
          "answer": crrt,
          "answer_meta": expp
        };
        logger("IndexedQuiz: $i");
        qstnz.add(qna);
      }
    }
    logger("Stacked Content: ${jsonEncode(qstnz)}");

    return jsonEncode(qstnz);
  } catch (e) {
    logger("The flaw: $e");
  }
}

Future<String?> scoopLatex(String text, BuildContext context) async {
  String optn_a, optn_b, optn_c, optn_d, optn_e, qsst, qsst_n, expl;
  List<Map<String, dynamic>> qstnz = [];

  try {
    List<String> qstnSpr = text.split(RegExp("##\\\\item"));
    logger("The length ${qstnSpr.length}");
    for (int i = 0; i < qstnSpr.length; i++) {
      if (i > 0) {
        List<String> qstn_ans =
            qstnSpr[i].split(RegExp("\\\\begin\\{enumerate\\}"));
        String qsst = qstn_ans[0];

        try {
          List<String> aggr = qsst.split(RegExp("\\\\textbf\\{Question:\\}"));

          if (qsst.length > 0) {
            qsst = aggr[1];
          }
        } catch (e) {}

        try {
          List<String> aggr = qsst.split(RegExp("\\\\textbf\\{"));

          if (qsst.length > 0) {
            qsst = aggr[1];
          }
        } catch (e) {}

        //.replaceAll("\textbf{Question:}", ""),

        String anzz = qstn_ans[1];
        logger("The question__: $qsst ***#*** $anzz");

        List<String> optn_ans = anzz.split(RegExp("\\\\textbf\\{Answer:\\} "));
        String optnx = optn_ans[0];

        List<String> Optionz_ = optnx.split(RegExp("\\\\end\\{enumerate\\}"));
        List<String> Optionz = [];
        if (Optionz_.length == 2) {
          logger("IndexedOptionzzz: ${Optionz_[0]}");
          Optionz = Optionz_[0].split(RegExp("\\\\item [A-E]\\)"));
          if (Optionz.length < 3) {
            Optionz = Optionz_[0].split(RegExp("\\\\item"));
          }
        }

        optn_a = optn_b = optn_c = optn_d = optn_e = "";

        if (Optionz.length > 0) {
          for (int j = 0; j < Optionz.length; j++) {
            logger("IndexedOption: ${Optionz[j]}");
            if (j > 0) {
              if (j == 1) {
                optn_a = Optionz[j];
              } else if (j == 2) {
                optn_b = Optionz[j];
              } else if (j == 3) {
                optn_c = Optionz[j];
              } else if (j == 4) {
                optn_d = Optionz[j];
              } else if (j == 5) {
                optn_e = Optionz[j];
              }
            }
          }

          String optn_expl = optn_ans[1];

          List<String> opp =
              optn_expl.split(RegExp("\\\\textbf\\{Explanation:\\}"));

          String crrt = opp[0];
          String expp = opp[1];

          List<String> ans_ = crrt.split(RegExp("[\\)]"));

          if (ans_.length < 2) {
            ans_ = crrt.split(RegExp("[\\.]"));
          }

          String optt = ans_[0];

          if (optt.contains("A") || optt.contains("a")) {
            crrt = "A";
          } else if (optt.contains("B") || optt.contains("b")) {
            crrt = "B";
          } else if (optt.contains("C") || optt.contains("c")) {
            crrt = "C";
          } else if (optt.contains("D") || optt.contains("d")) {
            crrt = "D";
          } else if (optt.contains("E") || optt.contains("e")) {
            crrt = "E";
          }

          // qsst = await serializeLatex(qsst);

          Map<String, dynamic> qna = {
            "question_no": i,
            "question": qsst,
            "option_a": optn_a,
            "option_b": optn_b,
            "option_c": optn_c,
            "option_d": optn_d,
            "option_e": optn_e,
            "answer": crrt,
            "answer_meta": expp
          };
          //  logger("IndexedQuiz: $i -- ${jsonEncode(qna)}");
          qstnz.add(qna);
        }
      }
    }

    logger("Stackerz Content: ${jsonEncode(qstnz)}");
    return jsonEncode(qstnz);
  } catch (e) {
    logger("Stacked error: $e");
  }
}

Future<String?> serializeLatex(String text) async {
  List<String> checkDollar = text.split(RegExp("\\\\\$"));
  StringBuffer sbb = StringBuffer();

  String strt = " \\\\( ";
  String end = " \\\\) ";

  List<String> checkLatex = text.split(RegExp("\$"));
  if (checkLatex.length > 1) {
    for (int i = 0; i < checkLatex.length; i++) {
      if (i % 2 > 0) {
        sbb.write(checkLatex[i]);
        sbb.write(end);
      } else {
        sbb.write(checkLatex[i]);
        sbb.write(strt);
      }
    }
    return sbb.toString();
  } else {
    return text;
  }
}

Future<List<Map<String, dynamic>>?> scoop(String text, String subject,
    String exam, String topic, BuildContext context) async {
  String optn_a, optn_b, optn_c, optn_d, optn_e, qsst, qsst_n, expl;
  List<Map<String, dynamic>> qstnz = [];

  try {
    List<String> content =
        text.split(RegExp("<div class=\"media question-item mb-4\">"));

    if (content.length > 0) {
      logger("The response: Content Available");
      for (int i = 0; i < content.length; i++) {
        if (i > 0) {
          try {
            List<String> qpreheader = content[i]
                .split(RegExp("<div class=\"question-desc mt-0 mb-3\">"));
            String q_num = qpreheader[0];
            logger("The Current No: $q_num");

            List<String> num_ =
                q_num.split("<div class=\"question_sn bg-danger mr-3\">");

            qsst_n = num_[1].split("</div>")[0];

            String q_opt = qpreheader[1];

            List<String> question_opt = q_opt.split(RegExp("</div>"));
            qsst = question_opt[0];

            String opt_expl = question_opt[1];
            List<String> opt_spl = opt_expl.split(RegExp("<style>"));

            String optnz = opt_spl[0];
            optnz = optnz.replaceAll("<ul class=\"list-unstyled\">", "");
            optnz = optnz.replaceAll("</ul>", "");

            //  logger("The Inference: $qsst --***-- $optnz ");
            List<String> opn = [];
            optn_a = optn_b = optn_c = optn_d = optn_e = "";

            List<String> opt_stratify = optnz.split(RegExp("<li>"));

            for (int i = 0; i < opt_stratify.length; i++) {
              if (i > 0) {
                List<String> spr_opt =
                    opt_stratify[i].split(RegExp("</strong>"));
                String opt_st = spr_opt[0];
                String optned = spr_opt[1].replaceAll("</li>", "");

                if (opt_st.contains("<strong>A.")) {
                  optn_a = optned;
                } else if (opt_st.contains("<strong>B.")) {
                  optn_b = optned;
                } else if (opt_st.contains("<strong>C.")) {
                  optn_c = optned;
                } else if (opt_st.contains("<strong>D.")) {
                  optn_d = optned;
                } else if (opt_st.contains("<strong>E.")) {
                  optn_e = optned;
                }
              }
            }

            String getExpl = opt_spl[1];
            List<String> explk = getExpl.split(RegExp("href=\""));
            String lnk = explk[1].split("\"")[0];

            String? ans = await getAnswer(lnk, context);

            String crrt = "";
            String expp = "";

            if (ans.isNotEmpty) {
              List<String> dtn = ans.split(RegExp("###"));
              crrt = dtn[0];
              expp = dtn[1];
            }

            Map<String, dynamic> qna = {
              "question_no": int.parse(qsst_n),
              "question": qsst, //myschoolParse(qsst),
              "option_a": optn_a,
              "option_b": optn_b,
              "option_c": optn_c,
              "option_d": optn_d,
              "option_e": optn_e,
              "answer": crrt,
              "answer_meta": expp
            };
            logger("IndexedQuiz: $qsst_n");
            qstnz.add(qna);
            // logger("The Essential: ${qna.toString()}");
          } catch (e) {
            logger("The unit error: $e");
          }
        }
      }
    } else {
      logger("The response: Content NA");
    }

    String vnt = jsonEncode(qstnz);

    // logger("The Question: $vnt");

    // entry()

    //postReq(url, data, request, essence, designation, contentType, context, display)
    return qstnz;
  } catch (e) {
    logger("The entry error: $e");
  }
}

Future<String> getAnswer(String link, BuildContext context) async {
  String rslt = "";

  String? ans = await getReqString(link, "", context, true, 5);

  if (ans.isNotEmpty) {
    List<String> explk = ans.split(RegExp("Correct Answer:"));
    String lnk = explk[1]; //.split("\"")[0];
    String ans_expl = lnk.split(RegExp("</div>"))[0];

    String crrt = "";
    List<String> ans_ = ans_expl.split(RegExp("Explanation"));
    if (ans_[0].contains("Option A")) {
      crrt = "A";
    } else if (ans_[0].contains("Option B")) {
      crrt = "B";
    } else if (ans_[0].contains("Option C")) {
      crrt = "C";
    } else if (ans_[0].contains("Option D")) {
      crrt = "D";
    } else if (ans_[0].contains("Option E")) {
      crrt = "E";
    }
    String expl = ans_[1].replaceAll("</h5>", "");

    if (expl.contains("There is an explanation video available")) {
      expl = expl.split(RegExp("<p class=\"my-4\">"))[0];
    }

    // logger("Thesis: $ans_expl");

    rslt = "$crrt###$expl";
  }

  return rslt;
}

Future<Map<String, dynamic>?> contentConvert(String text) async {
  //#\b([0-9]|[1-9][0-9])\b.
  try {
    Map<String, dynamic> flaw = {};
    List<String> content = text.split(
        RegExp("#([0-9]|[0-9]|[1-9][0-9])([.])")); //"#\b([0-9]|[1-9][0-9])\b."

    List<Map<String, dynamic>> qstnz = [];
    Map<String, dynamic> cvt = {};

    for (int i = 0; i < content.length; i++) {
      if (i != 0) {
        try {
          List<String> qstn = content[i].split("#");
          String qstnn = qstn[0];
          List<String> qRdv = qstnn.split("@ans");
          String qq = qRdv[0];

          List<String> quest = qq.split(RegExp("\\(([a-e])\\)"));
          String question = quest[0];
          String optA = quest[1];
          String optB = quest[2];
          String optC = quest[3];
          String optD = quest[4];
          String optE = "";
          try {
            optE = quest[5];
          } catch (e) {
            e.toString();
          }

          String ans = qRdv[1];

          List<String> axpl = ans.split("@expl");

          String expl = axpl[1];

          RegExp exp = RegExp("([A-E])"); //("\b((\s)([A-E])())\b");

          RegExpMatch? match = exp.firstMatch(axpl[0]);
          String answer = match![0]!; //!.replaceAll(" ", "");

          Map<String, dynamic> qna = {
            "question_no": i,
            "question": "<p>$question</p>",
            "option_a": "<p>$optA</p>",
            "option_b": "<p>$optB</p>",
            "option_c": "<p>$optC</p>",
            "option_d": "<p>$optD</p>",
            "option_e": optE,
            "answer": answer,
            "answer_meta": "<p>$expl</p>"
          };
          qstnz.add(qna);
        } catch (e) {
          flaw.addEntries({"No": i, "question": content[i]}.entries);
          /*
          List<String> qstn = content[i].split("#");
          String qstnn = qstn[0];
          flaw.addEntries({"question_no": i, "raw": qstnn}.entries);
          */
        }
      } else {
        try {
          String init = content[i];
          log("prlm: $init");
          cvt = jsonDecode(init);
        } catch (e) {
          log("errMsg: $e");
        }
      }
    }

    StringBuffer buffer = StringBuffer();

    if (flaw.isNotEmpty) {
      buffer.write(
          "${qstnz.length} questions were well formatted, \n ${flaw.length} questions were not well formatted. \n\n Here are some of the non-well formatted questions, kindly look into them, format and reserialize \n\n");

      flaw.forEach((key, value) {
        buffer.write("$key : $value \n");
      });
    }

    String? qry = jsonEncode(qstnz);
    return {
      "Questions": qstnz,
      "Flaws": flaw,
      "Manifest": cvt,
      "comment": buffer.toString()
    };
  } catch (e) {
    log("desrl_error: $e");
    return null;
  }
}

void launchCBT(Map<String, dynamic>? cnnt, BuildContext context, bool extract) {
  try {
    if (!extract) {
      log("Verified VVV");
      List<Map<String, dynamic>> qstnz = cnnt!["Questions"];

      String hm = jsonEncode(qstnz);

      Map<String, dynamic> cnpp = cnnt["Manifest"];
      String ttl = "Proofread";
      if (cnpp.isNotEmpty) {
        ttl = cnpp["subject"];
      }
      cbtStack = {ttl: hm};
    } else {
      log("Checking VVV");
      cnnt!.forEach((key, value) {
        log("Key: $key");
        log("Value: $value");
        List<dynamic> lst = jsonDecode(value);
        cbtStack = {key: jsonEncode(lst)};
        cbtCog = 0;
      });
    }

    cbtcontent = CBTDisplay(
        duration: const Duration(hours: 1, minutes: 25),
        contents: cbtStack,
        mode: prfMode,
        cog: cbtCog);

    Navigator.of(context).pushNamed(cbtRoute);
  } catch (e) {
    log("CBT Launch Error: $e");
  }
}

void logger(String message) {
  log(message);
}

late Navigate nvg;

Future<Map<String, dynamic>>? getDomain(BuildContext context) async {
  Map<String, dynamic> domain = {};
  nvg = Navigate();
  // nvg.eliteApi(tag, domain, essence, show, context)

  /*
  {
      "Essence":"access",
      "State":"specific_tsk",
      "Specific":"Router",
      "Table":"domains",
      "Rep":" d.id AS domain, name, f.pay_with_bank AS bank, f.currency AS currency, f.share AS playstore, contact, fb_sect, session, term",
      "Joint":" d INNER JOIN framework f on d.id = f.tag WHERE d.name = 'ElitePage' "
    }
  */
  String rep =
      " d.id AS domain, name, f.pay_with_bank AS bank, f.currency AS currency, f.share AS playstore, contact, fb_sect, session, term";
  String joint =
      " d INNER JOIN framework f on d.id = f.tag WHERE d.name = '$org_' ";
  nvg.eliteRouter(generic, "domain", "", false, context, "domains", rep, joint);
/*
"Rep":"a.id, a.Unique_ID AS Matric_No, u.Name as Candidate, u.Phone AS Contact, u.Gender as Gender, c.Class_tag AS Class, m.Class_Name AS Dept, t.term AS Term, s.session AS Session, a.subject AS Subject, a.assessment_result As Assessment, a.score",
   "Joint":" a INNER JOIN users u on a.Unique_ID = u.Unique_ID INNER JOIN class_particular c on a.class = c.Unique_ID INNER JOIN class_arms m on c.Class_arm = m.Unique_ID INNER JOIN term_tag t on a.term = t.term_id INNER JOIN session s on c.session = s.session_id WHERE a.Unique_ID = 6656789 "

*/

  return domain;
}

Future<Map<String, dynamic>>? getBalance() async {
  Map<String, dynamic> wallet = {};
  nvg = Navigate();

//  nvg.eliteApi(tag, domain, essence, show, context)
  return wallet;
  /*
  {
    "status": true,
    "data": [
        {
            "ID": "9",
            "Domain": "107",
            "User_ID": "3599585",
            "Balance": "1000",
            "Bonus": "0",
            "Quotidian": "0",
            "Voucher": "0",
            "Last_Transaction": "2022-07-30 11:52:14"
        }
    ],
    "message": {
        "Name": "reconciliation",
        "message": "Data Successfully fetched"
    }
}

  */
}

Future<void> unZip(String zipped, String dest) async {
  log("File procession terrain starts");
  final bytes = File(zipped).readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);
  log("File components obtained ");
  for (final file in archive) {
    final filename = file.name;
    log("File being processed: $filename");
    if (file.isFile) {
      final data = file.content as List<int>;
      File(dest)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
    } else {
      Directory(dest).create(recursive: true);
    }
  }
}
