// lib/app/data/models/news_model.dart

class NewsModel {
  String? status;
  int? responseCode;
  String? message;
  List<NewsResult>? result;

  NewsModel({this.status, this.responseCode, this.message, this.result});

  NewsModel.fromJson(Map<String, dynamic> json) {
    status       = json['status'];
    responseCode = json['response_code'];
    message      = json['message'];
    if (json['result'] != null) {
      result = <NewsResult>[];
      json['result'].forEach((v) {
        result!.add(NewsResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status']        = status;
    data['response_code'] = responseCode;
    data['message']       = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsResult {
  int?    newsId;
  String? title;
  String? details;
  String? image;
  String? date;
  int?    status;
  String? createdDate;
  String? updatedDate;

  NewsResult({
    this.newsId,
    this.title,
    this.details,
    this.image,
    this.date,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  NewsResult.fromJson(Map<String, dynamic> json) {
    newsId      = json['news_id'];
    title       = json['title'];
    details     = json['details'];
    image       = json['image'];
    date        = json['date'];
    status      = json['status'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['news_id']     = newsId;
    data['title']       = title;
    data['details']     = details;
    data['image']       = image;
    data['date']        = date;
    data['status']      = status;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    return data;
  }
}