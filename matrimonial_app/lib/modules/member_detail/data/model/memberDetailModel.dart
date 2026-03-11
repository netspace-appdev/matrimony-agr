// lib/app/modules/member_detail/member_detail_model.dart

class MemberDetailModel {
  final int? mId;
  final String? matriId;
  final String? fName;
  final String? lName;
  final String? gender;
  final String? fatherName;
  final String? gotra;
  final String? contact;
  final String? altContact;
  final String? email;
  final String? address;
  final String? pincode;
  final int? stateId;
  final int? distId;
  final int? tehsilId;
  final String? maridStatus;
  final int? eId;
  final int? bId;
  final String? income;
  final String? complexion;
  final String? bodyType;
  final String? bloodGroup;
  final int? age;
  final String? height;
  final String? weight;
  final String? dob;
  final String? dot;
  final String? placeBirth;
  final String? rashi;
  final String? nakshatra;
  final String? manglik;
  final String? cPName;
  final String? relationCP;
  final String? familyStatus;
  final String? timeToCall;
  final String? mobileCp;
  final String? emailCp;
  final String? profile;
  final int? status;
  final String? lastLogin;
  final String? remark;
  final String? date;
  final String? aadharNo;
  final String? brother;
  final String? mbrother;
  final String? nmbrother;
  final String? tsister;
  final String? msister;
  final String? nmsister;
  final String? fahterBussiness;
  final String? homeType;
  final String? memberType;
  final int? visitCount;
  final String? token;
  final String? updatedAt;
  final String? createdDate;
  final String? profilePhoto;
  final String? coverPhoto;
  final String? gotraName;        // "Gotra" (resolved name)
  final String? education;
  final String? heightFormatted;  // "Height" (formatted)
  final String? stateName;
  final String? cityName;
  final String? businessName;
  final String? maritialName;
  final List<ProfilePhotoItem>? profilePhotoList;
  final String? isUserShortlisted;

  const MemberDetailModel({
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
    this.mobileCp,
    this.emailCp,
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
    this.fahterBussiness,
    this.homeType,
    this.memberType,
    this.visitCount,
    this.token,
    this.updatedAt,
    this.createdDate,
    this.profilePhoto,
    this.coverPhoto,
    this.gotraName,
    this.education,
    this.heightFormatted,
    this.stateName,
    this.cityName,
    this.businessName,
    this.maritialName,
    this.profilePhotoList,
    this.isUserShortlisted,
  });

  factory MemberDetailModel.fromJson(Map<String, dynamic> json) {
    return MemberDetailModel(
      mId: json['m_id'],
      matriId: json['matri_id'],
      fName: json['f_name'],
      lName: json['l_name'],
      gender: json['gender'],
      fatherName: json['father_name'],
      gotra: json['gotra']?.toString(),
      contact: json['contact'],
      altContact: json['alt_contact'],
      email: json['email'],
      address: json['address'],
      pincode: json['pincode'],
      stateId: json['state_id'],
      distId: json['dist_id'],
      tehsilId: json['tehsil_id'],
      maridStatus: json['marid_status']?.toString(),
      eId: json['e_id'],
      bId: json['b_id'],
      income: json['income'],
      complexion: json['complexion'],
      bodyType: json['body_type'],
      bloodGroup: json['blood_group'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      dob: json['dob'],
      dot: json['dot'],
      placeBirth: json['place_birth'],
      rashi: json['rashi'],
      nakshatra: json['nakshatra'],
      manglik: json['manglik'],
      cPName: json['c_p_name'],
      relationCP: json['relation_c_p'],
      familyStatus: json['family_status'],
      timeToCall: json['time_to_call'],
      mobileCp: json['mobile_c_p'],
      emailCp: json['email_c_p'],
      profile: json['profile'],
      status: json['status'],
      lastLogin: json['last_login'],
      remark: json['remark'],
      date: json['date'],
      aadharNo: json['aadhar_no'],
      brother: json['brother']?.toString(),
      mbrother: json['mbrother']?.toString(),
      nmbrother: json['nmbrother']?.toString(),
      tsister: json['tsister']?.toString(),
      msister: json['msister']?.toString(),
      nmsister: json['nmsister']?.toString(),
      fahterBussiness: json['fahetr_bussiness'],
      homeType: json['home_type'],
      memberType: json['MemberType'],
      visitCount: json['VisitCount'],
      token: json['token'],
      updatedAt: json['updated_at'],
      createdDate: json['createdDate'],
      profilePhoto: json['ProfilePhoto'],
      coverPhoto: json['Coverphoto'],
      gotraName: json['Gotra'],
      education: json['Education'],
      heightFormatted: json['Height'],
      stateName: json['StateName'],
      cityName: json['CityName'],
      businessName: json['BusinessName'],
      maritialName: json['maritialname'],
      profilePhotoList: (json['ProfilePhotoList'] as List<dynamic>?)
          ?.map((e) => ProfilePhotoItem.fromJson(e))
          .toList(),
      isUserShortlisted: json['IsuserShortlisted'],
    );
  }

  /// Full name helper
  String get fullName => '${fName ?? ''} ${lName ?? ''}'.trim();

  /// Full profile photo URL helper — replace base URL as needed
  String? get profilePhotoUrl {
    if (profilePhoto == null || profilePhoto!.isEmpty) return null;
    return 'https://yourdomain.com/uploads/$profilePhoto'; // ← update base URL
  }
}

class ProfilePhotoItem {
  final int? imgId;
  final String? profile;
  final String? matriId;
  final int? mId;
  final int? status;
  final String? createdDate;
  final String? updatedDate;

  const ProfilePhotoItem({
    this.imgId,
    this.profile,
    this.matriId,
    this.mId,
    this.status,
    this.createdDate,
    this.updatedDate,
  });

  factory ProfilePhotoItem.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoItem(
      imgId: json['img_id'],
      profile: json['profile'],
      matriId: json['matri_id'],
      mId: json['m_id'],
      status: json['status'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
    );
  }
}