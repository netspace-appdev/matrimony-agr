class MemberListModel {
  String? status;
  int?    responseCode;
  String? message;
  List<MemberListResultModel>? result;
  Count?  count;

  MemberListModel({this.status, this.responseCode, this.message, this.result, this.count});

  MemberListModel.fromJson(Map<String, dynamic> json) {
    status       = json['status'];
    responseCode = MemberListResultModel._parseInt(json['response_code']);
    message      = json['message'];
    if (json['result'] != null) {
      result = <MemberListResultModel>[];
      json['result'].forEach((v) => result!.add(MemberListResultModel.fromJson(v)));
    }
    count = json['count'] != null ? Count.fromJson(json['count']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status']        = status;
    data['response_code'] = responseCode;
    data['message']       = message;
    if (result != null) data['result'] = result!.map((v) => v.toJson()).toList();
    if (count  != null) data['count']  = count!.toJson();
    return data;
  }
}

class MemberListResultModel {
  int?    mId;
  String? matriId;
  String? fName;
  String? lName;
  String? gender;
  String? fatherName;
  String? gotra;
  String? contact;
  String? altContact;
  String? email;
  String? address;
  String? pincode;
  int?    stateId;
  int?    distId;
  String? maridStatus;
  int?    eId;
  int?    bId;
  String? income;
  String? complexion;
  String? bodyType;
  String? bloodGroup;
  int?    age;
  String? height;
  String? weight;
  String? dob;
  String? manglik;
  String? rashi;
  String? nakshatra;
  String? memberType;
  int?    visitCount;
  String? token;
  String? updatedAt;
  String? createdDate;
  String? profilePhoto;
  String? coverphoto;
  int?    status;
  String? education;
  String? stateName;
  String? cityName;
  String? businessName;
  String? maritialname;

  MemberListResultModel({
    this.mId, this.matriId, this.fName, this.lName, this.gender,
    this.fatherName, this.gotra, this.contact, this.altContact, this.email,
    this.address, this.pincode, this.stateId, this.distId, this.maridStatus,
    this.eId, this.bId, this.income, this.complexion, this.bodyType,
    this.bloodGroup, this.age, this.height, this.weight, this.dob,
    this.manglik, this.rashi, this.nakshatra, this.memberType, this.visitCount,
    this.token, this.updatedAt, this.createdDate, this.profilePhoto,
    this.coverphoto, this.status, this.education, this.stateName,
    this.cityName, this.businessName, this.maritialname,
  });

  // ✅ Handles API returning numbers as strings e.g. "27" instead of 27
  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }

  MemberListResultModel.fromJson(Map<String, dynamic> json) {
    mId          = _parseInt(json['m_id']);
    matriId      = json['matri_id'];
    fName        = json['f_name'];
    lName        = json['l_name'];
    gender       = json['gender'];
    fatherName   = json['father_name'];
    gotra        = json['Gotra'];
    contact      = json['contact'];
    altContact   = json['alt_contact'];
    email        = json['email'];
    address      = json['address'];
    pincode      = json['pincode'];
    stateId      = _parseInt(json['state_id']);
    distId       = _parseInt(json['dist_id']);
    maridStatus  = json['marid_status']?.toString();
    eId          = _parseInt(json['e_id']);
    bId          = _parseInt(json['b_id']);
    income       = json['income'];
    complexion   = json['complexion'];
    bodyType     = json['body_type'];
    bloodGroup   = json['blood_group'];
    age          = _parseInt(json['age']);
    height       = json['height']?.toString();
    weight       = json['weight'];
    dob          = json['dob'];
    manglik      = json['manglik'];
    rashi        = json['rashi'];
    nakshatra    = json['nakshatra'];
    memberType   = json['MemberType'];
    visitCount   = _parseInt(json['VisitCount']);
    token        = json['token'];
    updatedAt    = json['updated_at'];
    createdDate  = json['createdDate'];
    profilePhoto = json['ProfilePhoto'];
    coverphoto   = json['Coverphoto'];
    status       = _parseInt(json['status']);
    education    = json['Education'];
    height       = json['Height'];
    stateName    = json['StateName'];
    cityName     = json['CityName'];
    businessName = json['BusinessName'];
    maritialname = json['maritialname'];
  }

  Map<String, dynamic> toJson() => {
    'm_id': mId, 'matri_id': matriId, 'f_name': fName, 'l_name': lName,
    'gender': gender, 'father_name': fatherName, 'Gotra': gotra,
    'contact': contact, 'alt_contact': altContact, 'email': email,
    'address': address, 'pincode': pincode, 'state_id': stateId,
    'dist_id': distId, 'marid_status': maridStatus, 'e_id': eId,
    'b_id': bId, 'income': income, 'complexion': complexion,
    'body_type': bodyType, 'blood_group': bloodGroup, 'age': age,
    'Height': height, 'weight': weight, 'dob': dob, 'manglik': manglik,
    'rashi': rashi, 'nakshatra': nakshatra, 'MemberType': memberType,
    'VisitCount': visitCount, 'token': token, 'updated_at': updatedAt,
    'createdDate': createdDate, 'ProfilePhoto': profilePhoto,
    'Coverphoto': coverphoto, 'status': status, 'Education': education,
    'StateName': stateName, 'CityName': cityName,
    'BusinessName': businessName, 'maritialname': maritialname,
  };
}

class Count {
  int? todayscount;
  int? allowcount;

  Count({this.todayscount, this.allowcount});

  Count.fromJson(Map<String, dynamic> json) {
    todayscount = MemberListResultModel._parseInt(json['todayscount']);
    allowcount  = MemberListResultModel._parseInt(json['allowcount']);
  }

  Map<String, dynamic> toJson() => {
    'todayscount': todayscount,
    'allowcount':  allowcount,
  };
}