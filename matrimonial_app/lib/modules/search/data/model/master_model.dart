// lib/app/data/models/master_model.dart

class EducationModel {
  final int eId;
  final String education;
  final int status;

  EducationModel({
    required this.eId,
    required this.education,
    required this.status,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      eId: json['e_id'] ?? 0,
      education: json['education'] ?? '',
      status: json['status'] ?? 1,
    );
  }
}

class HeightModel {
  final int hId;
  final String height;
  final int status;

  HeightModel({
    required this.hId,
    required this.height,
    required this.status,
  });

  factory HeightModel.fromJson(Map<String, dynamic> json) {
    return HeightModel(
      hId: json['h_id'] ?? 0,
      height: json['height'] ?? '',
      status: json['status'] ?? 1,
    );
  }
}
