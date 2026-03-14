class StateListModel {
  String? status;
  int? responseCode;
  String? message;
  List<StateResult>? result;

  StateListModel({this.status, this.responseCode, this.message, this.result});

  StateListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <StateResult>[];
      json['result'].forEach((v) {
        result!.add(new StateResult.fromJson(v));
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

class StateResult {
  int? stateId;
  String? state;
  int? status;

  StateResult({this.stateId, this.state, this.status});

  StateResult.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    state = json['state'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state'] = this.state;
    data['status'] = this.status;
    return data;
  }
}
