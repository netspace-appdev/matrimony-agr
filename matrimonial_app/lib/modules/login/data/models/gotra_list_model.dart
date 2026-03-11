class GotraListModel {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  GotraListModel({this.status, this.responseCode, this.message, this.result});

  GotraListModel.fromJson(Map<String, dynamic> json) {
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
  int? gId;
  String? gotra;
  int? status;

  Result({this.gId, this.gotra, this.status});

  Result.fromJson(Map<String, dynamic> json) {
    gId = json['g_id'];
    gotra = json['gotra'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['g_id'] = this.gId;
    data['gotra'] = this.gotra;
    data['status'] = this.status;
    return data;
  }
}
