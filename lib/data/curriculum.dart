import '../database/datafields.dart';

class Curriculum {
  final int id;
  final String subject;
  final String week;
  final String objectives;
  final String classTag;

  Curriculum(
      {required this.id,
      required this.subject,
      required this.week,
      required this.objectives,
      required this.classTag});
}

class dashNote {
  final String title, content, end, info, details;

  dashNote(
      {required this.title,
      required this.content,
      required this.end,
      required this.info,
      required this.details});

  factory dashNote.fromJson(Map<String, dynamic> json) {
    return dashNote(
        title: json[ttl],
        content: json[cnt],
        end: json[syp],
        info: json[sbj],
        details: json[dtl]);
  }
}

class liveNote {
  final String note;
  final String body;

  liveNote({required this.note, required this.body});
}

class liveSession {
  final String link;

  liveSession({required this.link});
}

class NoticeList {
  final List<Notice> notify;
  NoticeList({required this.notify});
}

class serverFile {
  final String filePath;
  final bool status;
  serverFile({required this.filePath, required this.status});
}

class Notice {
  final int id;
  final String title, caption, content, detail;

  Notice(
      {required this.id,
      required this.title,
      required this.caption,
      required this.content,
      required this.detail});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
        id: json[id_],
        title: json[ttl],
        content: json[cnt],
        detail: json[dtl],
        caption: cpt);
  }
}

  /*
        "Essence": "notification",
        "title": "Robotics Exams",
        "Content": "The kits are necessary",
        "Details": "The Essence of the kits can't be overemphasized being the driving wheel upon which every of the processions is hinged upon, let's get things going efficiently."
  */
