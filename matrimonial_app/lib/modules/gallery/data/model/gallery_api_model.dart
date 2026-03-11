class GalleryApiModel {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  GalleryApiModel({this.status, this.responseCode, this.message, this.result});

  GalleryApiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? imgId;
  String? image;
  String? title;
  String? date;
  int? status;
  String? alias;

  Result(
      {this.imgId, this.image, this.title, this.date, this.status, this.alias});

  Result.fromJson(Map<String, dynamic> json) {
    imgId = json['img_id'];
    image = json['image'];
    title = json['title'];
    date = json['date'];
    status = json['status'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img_id'] = this.imgId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['date'] = this.date;
    data['status'] = this.status;
    data['alias'] = this.alias;
    return data;
  }
}
