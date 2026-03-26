import 'dart:convert';

import 'package:dio/dio.dart';
import '../../modules/member_detail/data/model/memberDetailModel.dart';
import '../../utils/storage_service.dart';
import '../config/AppConfig.dart';
import 'api_response.dart';

class MasterService {

  static String get educationApiUrl  => '${AppConfig.apiBaseUrl}master/education';
  static String get heightApiUrl     => '${AppConfig.apiBaseUrl}master/height';
  static String get memberListApiUrl => '${AppConfig.apiBaseUrl}member/list';
  static String get memberListDetailApiUrl => '${AppConfig.apiBaseUrl}member/profile';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );


  static Future<ApiResponse<dynamic>> getEducation() async {
    try {

      final response = await _dio.post(
        educationApiUrl,

      );

      final data = response.data;

      if (response.statusCode == 200) {
        return ApiResponse.success("City list fetched", data: data);
      }

      return ApiResponse.error("Failed to load education");

    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }


  static Future<ApiResponse<dynamic>> getHeight() async {
    try {

      final response = await _dio.post(
        heightApiUrl,
      );

      final data = response.data;

      if (response.statusCode == 200) {
        return ApiResponse.success("heightApiUrl list fetched", data: data);
      }

      return ApiResponse.error("Failed to load heightApiUrl");

    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }




  // ─────────────────────────────────────────────
  //  MEMBER LIST (Search)
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getMemberList(Map<String, dynamic> body, {
    String profileID      = '',
    String occupation     = '',
    String ageFrom        = '',
    String ageTo          = '',
    String marriedStatus  = '',
    String education      = '',
    String manglikStatus  = '',
    String heightFrom     = '',
    String heightTo       = '',
    String gotra          = '',
  }) async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {
        'mobileno':      '',
        'gender':        '',
        'gotra':         gotra,
        'UserID':        userId,
        'ProfileID':     profileID,
        'occupation':    occupation,
        'AgeFrom':       ageFrom,
        'AgeTo':         ageTo,
        'MarriedStatus': marriedStatus,
        'Education':     education,
        'ManglikStatus': manglikStatus,
        'HeightFrom':    heightFrom,
        'HeightTo':      heightTo,
      };

      print("📤 MEMBER LIST API URL: $memberListApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(memberListApiUrl, data: requestBody);
      final data = response.data;

      print("📥 MEMBER LIST RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? "Member list fetched",
          data: data,
        );
      }
      return ApiResponse.error(data['message'] ?? "Failed to load members");
    } on DioException catch (e) {
      print("❌ DIO ERROR: ${e.response?.data}");
      return ApiResponse.error(
        e.response?.data?['message'] ?? e.message ?? "Server error",
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error("Unexpected error: ${e.toString()}");
    }
  }

/*  Future<MemberDetailModel> fetchMemberDetail({
    required String myProfileId,
  }) async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final response = await _dio.post(
        memberListDetailApiUrl, // appended to baseUrl
        data: {
          'ProfileID': userId,
          'MyProfileID': myProfileId,
        },
      );

      final body = response.data;

      if (body['status'] == 'Success' &&
          body['result'] != null &&
          (body['result'] as List).isNotEmpty) {
        return MemberDetailModel.fromJson(
            (body['result'] as List).first as Map<String, dynamic>);
      }

      throw Exception(body['message'] ?? 'Failed to load member detail');
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }*/




  static Future<ApiResponse<dynamic>> fetchMemberDetail({
  //  required String profileId,
    required String myProfileId,
  }) async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {
        'ProfileID': myProfileId,
        'MyProfileID': userId,
      };

      print("📤 MEMBER DETAIL API URL: $memberListDetailApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(
        memberListDetailApiUrl,
        data: requestBody,
      );

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = responseData['result'];

        if (result != null && (result as List).isNotEmpty) {
          final model = MemberDetailModel.fromJson(
              result.first as Map<String, dynamic>);
          return ApiResponse.success(
            responseData['message'] ?? 'Profile loaded successfully',
            data: model,
          );
        }

        return ApiResponse.error(
          responseData['message'] ?? 'No profile data found',
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to load profile',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      print("❌ DIO ERROR: ${e.response?.data}");
      return ApiResponse.error(
        e.response?.data['message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error: ${e.toString()}');
    }
  }
}