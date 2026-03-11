class HeightListModel {
  String? status;
  int?    responseCode;
  String? message;
  List<HeightResult>? result;

  HeightListModel({this.status, this.responseCode, this.message, this.result});

  HeightListModel.fromJson(Map<String, dynamic> json) {
    status       = json['status'];
    responseCode = HeightResult._parseInt(json['response_code']);
    message      = json['message'];
    if (json['result'] != null) {
      result = <HeightResult>[];
      for (var v in json['result']) result!.add(HeightResult.fromJson(v));
    }
  }
}

class HeightResult {
  int?    hId;
  String? height;
  int?    status;

  HeightResult({this.hId, this.height, this.status});

  // ── Handles API returning numbers as strings ──────────────────────────────
  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }

  HeightResult.fromJson(Map<String, dynamic> json) {
    hId    = _parseInt(json['h_id']);
    height = json['height'];
    status = _parseInt(json['status']);
  }

  Map<String, dynamic> toJson() => {
    'h_id': hId, 'height': height, 'status': status,
  };

  // Required for DropdownButton value matching
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HeightResult && runtimeType == other.runtimeType && hId == other.hId;

  @override
  int get hashCode => hId.hashCode;
}