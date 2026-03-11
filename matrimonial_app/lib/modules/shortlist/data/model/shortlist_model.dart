// lib/app/modules/shortlist/data/model/shortlist_model.dart

class ShortlistModel {
  String? status;
  int? responseCode;
  String? message;
  List<ShortListResultModel>? result;

  ShortlistModel({this.status, this.responseCode, this.message, this.result});

  ShortlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    if (json['result'] != null && json['result'] is List) {
      result = <ShortListResultModel>[];
      json['result'].forEach((v) {
        result!.add(ShortListResultModel.fromJson(v));
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

class ShortListResultModel {
  int? mId;
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
  int? stateId;
  int? distId;
  int? tehsilId;
  String? maridStatus;
  int? eId;
  int? bId;
  String? income;
  String? complexion;
  String? bodyType;
  String? bloodGroup;
  int? age;
  String? height;
  String? weight;
  String? dob;
  String? dot;
  String? placeBirth;
  String? rashi;
  String? nakshatra;
  String? manglik;
  String? cPName;
  String? relationCP;
  String? familyStatus;
  String? timeToCall;
  String? mobileCP;
  String? emailCP;
  String? password;
  String? profile;
  int? status;
  String? lastLogin;
  String? remark;
  String? date;
  String? aadharNo;
  String? brother;
  String? mbrother;
  String? nmbrother;
  String? tsister;
  String? msister;
  String? nmsister;
  String? fahetrBussiness;
  String? homeType;
  String? memberType;
  int? visitCount;
  dynamic token;
  String? updatedAt;
  String? createdDate;
  String? profilePhoto;
  dynamic coverphoto;

  ShortListResultModel({
    this.mId,
    this.matriId,
    this.fName,
    this.lName,
    this.gender,
    this.fatherName,
    this.gotra,
    this.contact,
    this.altContact,
    this.email,
    this.address,
    this.pincode,
    this.stateId,
    this.distId,
    this.tehsilId,
    this.maridStatus,
    this.eId,
    this.bId,
    this.income,
    this.complexion,
    this.bodyType,
    this.bloodGroup,
    this.age,
    this.height,
    this.weight,
    this.dob,
    this.dot,
    this.placeBirth,
    this.rashi,
    this.nakshatra,
    this.manglik,
    this.cPName,
    this.relationCP,
    this.familyStatus,
    this.timeToCall,
    this.mobileCP,
    this.emailCP,
    this.password,
    this.profile,
    this.status,
    this.lastLogin,
    this.remark,
    this.date,
    this.aadharNo,
    this.brother,
    this.mbrother,
    this.nmbrother,
    this.tsister,
    this.msister,
    this.nmsister,
    this.fahetrBussiness,
    this.homeType,
    this.memberType,
    this.visitCount,
    this.token,
    this.updatedAt,
    this.createdDate,
    this.profilePhoto,
    this.coverphoto,
  });

  // ── Helpers ──────────────────────────────────────
  String get fullName => '${fName?.trim() ?? ''} ${lName?.trim() ?? ''}'.trim();
  bool get hasPhoto => profilePhoto != null && profilePhoto!.isNotEmpty;

  ShortListResultModel.fromJson(Map<String, dynamic> json) {
    mId           = json['m_id'];
    matriId       = json['matri_id']?.toString();
    fName         = json['f_name']?.toString().trim();
    lName         = json['l_name']?.toString().trim();
    gender        = json['gender'];
    fatherName    = json['father_name'];
    gotra         = json['gotra']?.toString();
    contact       = json['contact']?.toString();
    altContact    = json['alt_contact']?.toString();
    email         = json['email'];
    address       = json['address'];
    pincode       = json['pincode']?.toString();
    stateId       = _parseInt(json['state_id']);
    distId        = _parseInt(json['dist_id']);
    tehsilId      = _parseInt(json['tehsil_id']);
    maridStatus   = json['marid_status']?.toString();
    eId           = _parseInt(json['e_id']);
    bId           = _parseInt(json['b_id']);
    income        = json['income']?.toString();
    complexion    = json['complexion'];
    bodyType      = json['body_type'];
    bloodGroup    = json['blood_group']?.toString();
    age           = _parseInt(json['age']);
    height        = json['height']?.toString();
    weight        = json['weight']?.toString();
    dob           = json['dob'];
    dot           = json['dot'];
    placeBirth    = json['place_birth'];
    rashi         = json['rashi'];
    nakshatra     = json['nakshatra'];
    manglik       = json['manglik'];
    cPName        = json['c_p_name'];
    relationCP    = json['relation_c_p'];
    familyStatus  = json['family_status'];
    timeToCall    = json['time_to_call'];
    mobileCP      = json['mobile_c_p']?.toString().trim();
    emailCP       = json['email_c_p'];
    password      = json['password']?.toString();
    profile       = json['profile']?.toString();
    status        = _parseInt(json['status']);
    lastLogin     = json['last_login'];
    remark        = json['remark'];
    date          = json['date'];
    aadharNo      = json['aadhar_no'];
    brother       = json['brother'];
    mbrother      = json['mbrother'];
    nmbrother     = json['nmbrother'];
    tsister       = json['tsister'];
    msister       = json['msister'];
    nmsister      = json['nmsister'];
    fahetrBussiness = json['fahetr_bussiness'];
    homeType      = json['home_type'];
    memberType    = json['MemberType'];
    visitCount    = _parseInt(json['VisitCount']);
    token         = json['token'];
    updatedAt     = json['updated_at'];
    createdDate   = json['createdDate'];
    profilePhoto  = json['ProfilePhoto']?.toString();
    coverphoto    = json['Coverphoto'];
  }

  Map<String, dynamic> toJson() {
    return {
      'm_id': mId,
      'matri_id': matriId,
      'f_name': fName,
      'l_name': lName,
      'gender': gender,
      'father_name': fatherName,
      'gotra': gotra,
      'contact': contact,
      'alt_contact': altContact,
      'email': email,
      'address': address,
      'pincode': pincode,
      'state_id': stateId,
      'dist_id': distId,
      'tehsil_id': tehsilId,
      'marid_status': maridStatus,
      'e_id': eId,
      'b_id': bId,
      'income': income,
      'complexion': complexion,
      'body_type': bodyType,
      'blood_group': bloodGroup,
      'age': age,
      'height': height,
      'weight': weight,
      'dob': dob,
      'dot': dot,
      'place_birth': placeBirth,
      'rashi': rashi,
      'nakshatra': nakshatra,
      'manglik': manglik,
      'c_p_name': cPName,
      'relation_c_p': relationCP,
      'family_status': familyStatus,
      'time_to_call': timeToCall,
      'mobile_c_p': mobileCP,
      'email_c_p': emailCP,
      'password': password,
      'profile': profile,
      'status': status,
      'last_login': lastLogin,
      'remark': remark,
      'date': date,
      'aadhar_no': aadharNo,
      'brother': brother,
      'mbrother': mbrother,
      'nmbrother': nmbrother,
      'tsister': tsister,
      'msister': msister,
      'nmsister': nmsister,
      'fahetr_bussiness': fahetrBussiness,
      'home_type': homeType,
      'MemberType': memberType,
      'VisitCount': visitCount,
      'token': token,
      'updated_at': updatedAt,
      'createdDate': createdDate,
      'ProfilePhoto': profilePhoto,
      'Coverphoto': coverphoto,
    };
  }

  static int? _parseInt(dynamic value) {
    if (value == null || value == '') return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}