class UserProfile {
  bool? status;
  String? message;
  Data? data;

  UserProfile({this.status, this.message, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  String? tehsilId;
  String? maridStatus;
  String? eId;
  String? bId;
  String? income;
  String? complexion;
  String? bodyType;
  String? bloodGroup;
  String? age;
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
  String? token;
  String? updatedAt;
  String? createdDate;
  String? profilePhoto;
  String? coverphoto;
  String? stateName;
  String? districtName;
  String? tehsilName;

  Data(
      {this.mId,
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
        this.stateName,
        this.districtName,
        this.tehsilName});

  Data.fromJson(Map<String, dynamic> json) {
    mId = json['m_id'];
    matriId = json['matri_id'];
    fName = json['f_name'];
    lName = json['l_name'];
    gender = json['gender'];
    fatherName = json['father_name'];
    gotra = json['gotra'];
    contact = json['contact'];
    altContact = json['alt_contact'];
    email = json['email'];
    address = json['address'];
    pincode = json['pincode'];
    stateId = json['state_id'];
    distId = json['dist_id'];
    tehsilId = json['tehsil_id'];
    maridStatus = json['marid_status'];
    eId = json['e_id'];
    bId = json['b_id'];
    income = json['income'];
    complexion = json['complexion'];
    bodyType = json['body_type'];
    bloodGroup = json['blood_group'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    dob = json['dob'];
    dot = json['dot'];
    placeBirth = json['place_birth'];
    rashi = json['rashi'];
    nakshatra = json['nakshatra'];
    manglik = json['manglik'];
    cPName = json['c_p_name'];
    relationCP = json['relation_c_p'];
    familyStatus = json['family_status'];
    timeToCall = json['time_to_call'];
    mobileCP = json['mobile_c_p'];
    emailCP = json['email_c_p'];
    profile = json['profile'];
    status = json['status'];
    lastLogin = json['last_login'];
    remark = json['remark'];
    date = json['date'];
    aadharNo = json['aadhar_no'];
    brother = json['brother'];
    mbrother = json['mbrother'];
    nmbrother = json['nmbrother'];
    tsister = json['tsister'];
    msister = json['msister'];
    nmsister = json['nmsister'];
    fahetrBussiness = json['fahetr_bussiness'];
    homeType = json['home_type'];
    memberType = json['MemberType'];
    visitCount = json['VisitCount'];
    token = json['token'];
    updatedAt = json['updated_at'];
    createdDate = json['createdDate'];
    profilePhoto = json['ProfilePhoto'];
    coverphoto = json['Coverphoto'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    tehsilName = json['tehsil_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_id'] = this.mId;
    data['matri_id'] = this.matriId;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['gender'] = this.gender;
    data['father_name'] = this.fatherName;
    data['gotra'] = this.gotra;
    data['contact'] = this.contact;
    data['alt_contact'] = this.altContact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['state_id'] = this.stateId;
    data['dist_id'] = this.distId;
    data['tehsil_id'] = this.tehsilId;
    data['marid_status'] = this.maridStatus;
    data['e_id'] = this.eId;
    data['b_id'] = this.bId;
    data['income'] = this.income;
    data['complexion'] = this.complexion;
    data['body_type'] = this.bodyType;
    data['blood_group'] = this.bloodGroup;
    data['age'] = this.age;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['dot'] = this.dot;
    data['place_birth'] = this.placeBirth;
    data['rashi'] = this.rashi;
    data['nakshatra'] = this.nakshatra;
    data['manglik'] = this.manglik;
    data['c_p_name'] = this.cPName;
    data['relation_c_p'] = this.relationCP;
    data['family_status'] = this.familyStatus;
    data['time_to_call'] = this.timeToCall;
    data['mobile_c_p'] = this.mobileCP;
    data['email_c_p'] = this.emailCP;
    data['profile'] = this.profile;
    data['status'] = this.status;
    data['last_login'] = this.lastLogin;
    data['remark'] = this.remark;
    data['date'] = this.date;
    data['aadhar_no'] = this.aadharNo;
    data['brother'] = this.brother;
    data['mbrother'] = this.mbrother;
    data['nmbrother'] = this.nmbrother;
    data['tsister'] = this.tsister;
    data['msister'] = this.msister;
    data['nmsister'] = this.nmsister;
    data['fahetr_bussiness'] = this.fahetrBussiness;
    data['home_type'] = this.homeType;
    data['MemberType'] = this.memberType;
    data['VisitCount'] = this.visitCount;
    data['token'] = this.token;
    data['updated_at'] = this.updatedAt;
    data['createdDate'] = this.createdDate;
    data['ProfilePhoto'] = this.profilePhoto;
    data['Coverphoto'] = this.coverphoto;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['tehsil_name'] = this.tehsilName;
    return data;
  }
}
