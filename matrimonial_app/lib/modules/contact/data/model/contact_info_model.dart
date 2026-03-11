class ContactInfoModel {
  String? status;
  int? responseCode;
  String? message;
  List<Result>? result;

  ContactInfoModel({this.status, this.responseCode, this.message, this.result});

  ContactInfoModel.fromJson(Map<String, dynamic> json) {
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
  int? conId;
  String? name;
  String? address;
  String? contact;
  String? altContact;
  String? email;
  String? image;
  int? status;

  Result(
      {this.conId,
        this.name,
        this.address,
        this.contact,
        this.altContact,
        this.email,
        this.image,
        this.status});

  Result.fromJson(Map<String, dynamic> json) {
    conId = json['con_id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    altContact = json['alt_contact'];
    email = json['email'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['con_id'] = this.conId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['alt_contact'] = this.altContact;
    data['email'] = this.email;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
