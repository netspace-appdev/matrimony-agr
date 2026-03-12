// lib/app/data/models/notice_model.dart

class NoticeModel {
  String? status;
  int? responseCode;
  String? message;
  List<NoticeResult>? result;

  NoticeModel({this.status, this.responseCode, this.message, this.result});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <NoticeResult>[];
      json['result'].forEach((v) {
        result!.add(NoticeResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['response_code'] = responseCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NoticeResult {
  int? noticeId;
  String? title;
  String? details;
  String? image;
  String? date;
  int? status;
  String? createdDate;
  String? updatedDate;

  NoticeResult({
    this.noticeId,
    this.title,
    this.details,
    this.image,
    this.date,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  NoticeResult.fromJson(Map<String, dynamic> json) {
    noticeId = json['notice_id'];
    title    = json['title'];
    details  = json['details'];
    image    = json['image'];
    date     = json['date'];
    status   = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notice_id']   = noticeId;
    data['title']       = title;
    data['details']     = details;
    data['image']       = image;
    data['date']        = date;
    data['status']      = status;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }

  // ── Emoji helper ─────────────────────────────────────────────────────────
  String get emoji => _emojiForType(title, details);

  static String _emojiForType(String? title, String? details) {
    final combined = ((title ?? '') + ' ' + (details ?? '')).toLowerCase();

    if (combined.contains('wedding') ||
        combined.contains('vivah')   ||
        combined.contains('marriage') ||
        combined.contains('shadi')) {
      return '\u{1F492}'; // 💒
    } else if (combined.contains('event')   ||
        combined.contains('festival') ||
        combined.contains('utsav')   ||
        combined.contains('celebration')) {
      return '\u{1F389}'; // 🎉
    } else if (combined.contains('news')     ||
        combined.contains('samachar') ||
        combined.contains('update')) {
      return '\u{1F4F0}'; // 📰
    } else if (combined.contains('meeting') ||
        combined.contains('baithak') ||
        combined.contains('sabha')) {
      return '\u{1F465}'; // 👥
    } else if (combined.contains('award')  ||
        combined.contains('samman') ||
        combined.contains('prize')) {
      return '\u{1F3C6}'; // 🏆
    } else {
      return '\u{1F4E2}'; // 📢
    }
  }
}