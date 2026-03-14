// lib/app/modules/social_members/data/model/social_member_model.dart

// ─── Save API response ────────────────────────────────────────────────────────
class SocialMemberSaveModel {
  bool? status;
  int? responseCode;
  String? message;

  SocialMemberSaveModel({this.status, this.responseCode, this.message});

  SocialMemberSaveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'response_code': responseCode,
      'message': message,
    };
  }
}

// ─── List API response ────────────────────────────────────────────────────────
class SocialMemberListModel {
  bool? status;
  int? responseCode;
  String? message;
  List<SocialMemberResult>? result;

  SocialMemberListModel({
    this.status,
    this.responseCode,
    this.message,
    this.result,
  });

  SocialMemberListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <SocialMemberResult>[];
      json['result'].forEach((v) {
        result!.add(SocialMemberResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['response_code'] = responseCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialMemberResult {
  int? memId;
  String? name;
  String? mobile;
  String? dob;
  String? address;
  String? businessType;
  String? profilePhoto;
  int? status;
  String? createdDate;
  String? cityName;
  String? stateName;

  SocialMemberResult({
    this.memId,
    this.name,
    this.mobile,
    this.dob,
    this.address,
    this.businessType,
    this.profilePhoto,
    this.status,
    this.createdDate,
    this.cityName,
    this.stateName,
  });

  SocialMemberResult.fromJson(Map<String, dynamic> json) {
    memId = json['mem_id'];
    name = json['name'];
    mobile = json['mobile'];
    dob = json['dob'];
    address = json['address'];
    businessType = json['business_type'];
    profilePhoto = json['ProfilePhoto'];
    status = json['status'];
    createdDate = json['CreatedDate'];
    cityName = json['CityName'];
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mem_id': memId,
      'name': name,
      'mobile': mobile,
      'dob': dob,
      'address': address,
      'business_type': businessType,
      'ProfilePhoto': profilePhoto,
      'status': status,
      'CreatedDate': createdDate,
      'CityName': cityName,
      'StateName': stateName,
    };
  }

  /// Initials for avatar fallback
  String get initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  /// Location display string
  String get location {
    final parts = <String>[];
    if (cityName?.isNotEmpty == true) parts.add(cityName!);
    if (stateName?.isNotEmpty == true) parts.add(stateName!);
    return parts.join(', ');
  }
}