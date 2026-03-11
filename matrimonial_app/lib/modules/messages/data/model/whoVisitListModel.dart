// lib/app/modules/messages/data/model/WhoVisitModel.dart

class WhoVisitListModel {
  String? status;
  int?    responseCode;
  String? message;
  List<WhoVisitResult>? result;

  WhoVisitListModel({this.status, this.responseCode, this.message, this.result});

  WhoVisitListModel.fromJson(Map<String, dynamic> json) {
    status       = json['status'];
    responseCode = WhoVisitResult._parseInt(json['response_code']);
    message      = json['message'];
    if (json['result'] != null) {
      result = <WhoVisitResult>[];
      for (var v in json['result']) result!.add(WhoVisitResult.fromJson(v));
    }
  }
}

class WhoVisitResult {
  int?    mId;
  String? matriId;
  String? fName;
  String? lName;
  String? gender;
  String? fatherName;
  String? gotra;         // raw gotra id
  String? contact;
  String? altContact;
  String? email;
  String? address;
  String? pincode;
  int?    stateId;
  int?    distId;
  int?    tehsilId;
  String? maridStatus;
  int?    eId;
  int?    bId;
  String? income;
  String? complexion;
  String? bodyType;
  String? bloodGroup;
  int?    age;
  String? height;        // raw height id
  String? weight;
  String? dob;
  String? dot;
  String? placeBirth;
  String? rashi;
  String? nakshatra;
  String? manglik;
  String? memberType;
  int?    visitCount;
  String? token;
  String? updatedAt;
  String? createdDate;
  String? profilePhoto;
  String? coverPhoto;
  int?    status;
  // ── Formatted / joined fields from API ────────────────────────────────────
  String? gotraName;       // Gotra (name)
  String? education;       // Education
  String? heightFormatted; // Height e.g. "5' 9\""
  String? stateName;       // StateName
  String? cityName;        // CityName
  String? businessName;    // BusinessName
  String? maritialName;    // maritialname

  WhoVisitResult({
    this.mId, this.matriId, this.fName, this.lName, this.gender,
    this.fatherName, this.gotra, this.contact, this.altContact, this.email,
    this.address, this.pincode, this.stateId, this.distId, this.tehsilId,
    this.maridStatus, this.eId, this.bId, this.income, this.complexion,
    this.bodyType, this.bloodGroup, this.age, this.height, this.weight,
    this.dob, this.dot, this.placeBirth, this.rashi, this.nakshatra,
    this.manglik, this.memberType, this.visitCount, this.token,
    this.updatedAt, this.createdDate, this.profilePhoto, this.coverPhoto,
    this.status, this.gotraName, this.education, this.heightFormatted,
    this.stateName, this.cityName, this.businessName, this.maritialName,
  });

  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }

  WhoVisitResult.fromJson(Map<String, dynamic> json) {
    mId             = _parseInt(json['m_id']);
    matriId         = json['matri_id'];
    fName           = json['f_name'];
    lName           = json['l_name'];
    gender          = json['gender'];
    fatherName      = json['father_name'];
    gotra           = json['gotra']?.toString();
    contact         = json['contact'];
    altContact      = json['alt_contact'];
    email           = json['email'];
    address         = json['address'];
    pincode         = json['pincode'];
    stateId         = _parseInt(json['state_id']);
    distId          = _parseInt(json['dist_id']);
    tehsilId        = _parseInt(json['tehsil_id']);
    maridStatus     = json['marid_status']?.toString();
    eId             = _parseInt(json['e_id']);
    bId             = _parseInt(json['b_id']);
    income          = json['income'];
    complexion      = json['complexion'];
    bodyType        = json['body_type'];
    bloodGroup      = json['blood_group'];
    age             = _parseInt(json['age']);
    height          = json['height']?.toString();
    weight          = json['weight'];
    dob             = json['dob'];
    dot             = json['dot'];
    placeBirth      = json['place_birth'];
    rashi           = json['rashi'];
    nakshatra       = json['nakshatra'];
    manglik         = json['manglik'];
    memberType      = json['MemberType'];
    visitCount      = _parseInt(json['VisitCount']);
    token           = json['token'];
    updatedAt       = json['updated_at'];
    createdDate     = json['createdDate'];
    profilePhoto    = json['ProfilePhoto'];
    coverPhoto      = json['Coverphoto'];
    status          = _parseInt(json['status']);
    gotraName       = json['Gotra'];
    education       = json['Education'];
    heightFormatted = json['Height'];
    stateName       = json['StateName'];
    cityName        = json['CityName'];
    businessName    = json['BusinessName'];
    maritialName    = json['maritialname'];
  }

  // ── Computed helpers ───────────────────────────────────────────────────────
  String get fullName => '${fName ?? ''} ${lName ?? ''}'.trim();

  String get initials => [
    (fName?.trim().isNotEmpty == true) ? fName!.trim()[0].toUpperCase() : '',
    (lName?.trim().isNotEmpty == true) ? lName!.trim()[0].toUpperCase() : '',
  ].join();

  String get displayInitials => initials.isNotEmpty ? initials : '?';
}