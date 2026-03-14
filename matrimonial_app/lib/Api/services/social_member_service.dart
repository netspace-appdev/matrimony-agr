// lib/app/Api/services/social_member_service.dart

import 'package:dio/dio.dart';
import '../../modules/social_members/data/model/member_model.dart';
import '../config/AppConfig.dart';
import 'api_response.dart';

class SocialMemberService {

  static String get saveApiUrl => '${AppConfig.apiBaseUrl}social-member/save';
  static String get listApiUrl => '${AppConfig.apiBaseUrl}social-member/list';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  // ─────────────────────────────────────────────
  //  SAVE (Register social member)
  // ─────────────────────────────────────────────
  static Future<ApiResponse<SocialMemberSaveModel>> saveSocialMember({
    required String name,
    required String mobileNumber,
    required String dob,
    required String address,
    required String state,
    required String city,
    required String jobType,
    String profilePhoto = '',
    String status = '0',
  }) async {
    try {
      final requestBody = {
        'Name': name,
        'MobileNumber': mobileNumber,
        'DOB': dob,
        'Address': address,
        'State': state,
        'City': city,
        'JobType': jobType,
        'ProfilePhoto': profilePhoto,
        'Status': status,
      };

      print("📤 SOCIAL MEMBER SAVE URL: $saveApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(saveApiUrl, data: requestBody);

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['response_code'] == 200) {
          final model = SocialMemberSaveModel.fromJson(responseData);
          return ApiResponse.success(
            responseData['message'] ?? 'Registered successfully',
            data: model,
          );
        }
        return ApiResponse.error(
          responseData['message'] ?? 'Registration failed',
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        responseData['message'] ?? 'Registration failed',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      print("❌ DIO ERROR: ${e.response?.data}");
      return ApiResponse.error(
        e.response?.data?['message'] ?? e.message ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error: ${e.toString()}');
    }
  }

  // ─────────────────────────────────────────────
  //  LIST (Get all social members)
  // ─────────────────────────────────────────────
  static Future<ApiResponse<SocialMemberListModel>> getSocialMemberList() async {
    try {
      print("📤 SOCIAL MEMBER LIST URL: $listApiUrl");

      final response = await _dio.post(listApiUrl, data: {});

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['response_code'] == 200) {
          final model = SocialMemberListModel.fromJson(responseData);
          return ApiResponse.success(
            responseData['message'] ?? 'Social member list fetched successfully',
            data: model,
          );
        }
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to load members',
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        responseData['message'] ?? 'Failed to load members',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      print("❌ DIO ERROR: ${e.response?.data}");
      return ApiResponse.error(
        e.response?.data?['message'] ?? e.message ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error: ${e.toString()}');
    }
  }
}
