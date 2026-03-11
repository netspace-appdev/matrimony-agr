class CityListModel {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  CityListModel({this.status, this.responseCode, this.message, this.result});

  CityListModel.fromJson(Map<String, dynamic> json) {
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
  int? distId;
  String? district;
  int? stateId;
  int? status;

  Result({this.distId, this.district, this.stateId, this.status});

  Result.fromJson(Map<String, dynamic> json) {
    distId = json['dist_id'];
    district = json['district'];
    stateId = json['state_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dist_id'] = this.distId;
    data['district'] = this.district;
    data['state_id'] = this.stateId;
    data['status'] = this.status;
    return data;
  }
}
