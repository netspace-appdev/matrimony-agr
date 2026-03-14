class DashboardModel {
  String? status;
  int? responseCode;
  String? message;
  Result? result;

  DashboardModel({this.status, this.responseCode, this.message, this.result});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? name;
  int? profileCompletion;
  Counts? counts;
  List<SuggestedMatches>? suggestedMatches;
  List<QuickInfo>? quickInfo;
  List<NotificationContent>? notificationContent;
  List<NotificationAlert>? notificationAlert;

  Result(
      {this.name,
        this.profileCompletion,
        this.counts,
        this.suggestedMatches,
        this.quickInfo,
        this.notificationContent,
        this.notificationAlert});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    profileCompletion = json['ProfileCompletion'];
    counts =
    json['Counts'] != null ? new Counts.fromJson(json['Counts']) : null;
    if (json['SuggestedMatches'] != null) {
      suggestedMatches = <SuggestedMatches>[];
      json['SuggestedMatches'].forEach((v) {
        suggestedMatches!.add(new SuggestedMatches.fromJson(v));
      });
    }
    if (json['QuickInfo'] != null) {
      quickInfo = <QuickInfo>[];
      json['QuickInfo'].forEach((v) {
        quickInfo!.add(new QuickInfo.fromJson(v));
      });
    }
    if (json['NotificationContent'] != null) {
      notificationContent = <NotificationContent>[];
      json['NotificationContent'].forEach((v) {
        notificationContent!.add(new NotificationContent.fromJson(v));
      });
    }
    if (json['NotificationAlert'] != null) {
      notificationAlert = <NotificationAlert>[];
      json['NotificationAlert'].forEach((v) {
        notificationAlert!.add(new NotificationAlert.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['ProfileCompletion'] = this.profileCompletion;
    if (this.counts != null) {
      data['Counts'] = this.counts!.toJson();
    }
    if (this.suggestedMatches != null) {
      data['SuggestedMatches'] =
          this.suggestedMatches!.map((v) => v.toJson()).toList();
    }
    if (this.quickInfo != null) {
      data['QuickInfo'] = this.quickInfo!.map((v) => v.toJson()).toList();
    }
    if (this.notificationContent != null) {
      data['NotificationContent'] =
          this.notificationContent!.map((v) => v.toJson()).toList();
    }
    if (this.notificationAlert != null) {
      data['NotificationAlert'] =
          this.notificationAlert!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Counts {
  int? shortlist;
  int? views;
  int? viewsbyme;

  Counts({this.shortlist, this.views, this.viewsbyme});

  Counts.fromJson(Map<String, dynamic> json) {
    shortlist = json['Shortlist'];
    views = json['Views'];
    viewsbyme = json['Viewsbyme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Shortlist'] = this.shortlist;
    data['Views'] = this.views;
    data['Viewsbyme'] = this.viewsbyme;
    return data;
  }
}

class SuggestedMatches {
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
  Null? tehsilId;
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
  Null? familyStatus;
  String? timeToCall;
  String? mobileCP;
  String? emailCP;
  String? password;
  Null? profile;
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

  SuggestedMatches(
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
        this.coverphoto});

  SuggestedMatches.fromJson(Map<String, dynamic> json) {
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
    password = json['password'];
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
    data['password'] = this.password;
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
    return data;
  }
}

class QuickInfo {
  int? id;
  String? information;
  int? status;
  String? createdAt;
  String? updatedAt;

  QuickInfo(
      {this.id, this.information, this.status, this.createdAt, this.updatedAt});

  QuickInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    information = json['Information'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Information'] = this.information;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_At'] = this.updatedAt;
    return data;
  }
}

class NotificationContent {
  int? id;
  String? details;
  String? createdDate;

  NotificationContent({this.id, this.details, this.createdDate});

  NotificationContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}

class NotificationAlert {
  int? id;
  String? title;
  String? details;
  String? image;
  String? notificationFor;
  String? mId;
  String? createDate;
  String? updatedDate;
  int? status;

  NotificationAlert(
      {this.id,
        this.title,
        this.details,
        this.image,
        this.notificationFor,
        this.mId,
        this.createDate,
        this.updatedDate,
        this.status});

  NotificationAlert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['Title'];
    details = json['Details'];
    image = json['Image'];
    notificationFor = json['NotificationFor'];
    mId = json['m_id'];
    createDate = json['CreateDate'];
    updatedDate = json['UpdatedDate'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Title'] = this.title;
    data['Details'] = this.details;
    data['Image'] = this.image;
    data['NotificationFor'] = this.notificationFor;
    data['m_id'] = this.mId;
    data['CreateDate'] = this.createDate;
    data['UpdatedDate'] = this.updatedDate;
    data['Status'] = this.status;
    return data;
  }
}
