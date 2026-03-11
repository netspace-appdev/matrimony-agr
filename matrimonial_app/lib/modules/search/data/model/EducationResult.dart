class EducationListModel {
  String? status;
  int?    responseCode;
  String? message;
  List<EducationResult>? result;

  EducationListModel({this.status, this.responseCode, this.message, this.result});

  EducationListModel.fromJson(Map<String, dynamic> json) {
    status       = json['status'];
    responseCode = EducationResult._parseInt(json['response_code']);
    message      = json['message'];
    if (json['result'] != null) {
      result = <EducationResult>[];
      for (var v in json['result']) result!.add(EducationResult.fromJson(v));
    }
  }
}

class EducationResult {
  int?    eId;
  String? education;
  int?    status;

  EducationResult({this.eId, this.education, this.status});

  // ── Handles API returning numbers as strings ──────────────────────────────
  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }

  EducationResult.fromJson(Map<String, dynamic> json) {
    eId       = _parseInt(json['e_id']);
    education = json['education'];
    status    = _parseInt(json['status']);
  }

  Map<String, dynamic> toJson() => {
    'e_id': eId, 'education': education, 'status': status,
  };

  // Required for DropdownButton value matching
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EducationResult && runtimeType == other.runtimeType && eId == other.eId;

  @override
  int get hashCode => eId.hashCode;
}