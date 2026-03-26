// lib/app/core/services/profile_service.dart

import 'package:dio/dio.dart';
import '../../modules/my_profile/data/model/profile_model.dart';
import '../../utils/storage_service.dart';
import '../config/AppConfig.dart';
import 'api_response.dart';

class ProfileService {

  static String get getUserApiUrl    => '${AppConfig.apiBaseUrl}member/get-user';
  static String get updateBasicApiUrl => '${AppConfig.apiBaseUrl}member/update-basic';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  // ─────────────────────────────────────────────
  //  GET USER PROFILE
  // ─────────────────────────────────────────────
  static Future<ApiResponse<UserProfile>> getUserProfile() async {
    try {
      final String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {'user_id': userId};

      print("📤 GET USER API URL: $getUserApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(getUserApiUrl, data: requestBody);

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['data'] != null) {
          final model = UserProfile.fromJson(responseData);
          return ApiResponse.success(
            responseData['message'] ?? 'Profile loaded successfully',
            data: model,
          );
        }
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to load profile',
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        responseData['message'] ?? 'Failed to load profile',
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
  //  UPDATE BASIC PROFILE
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> updateBasicProfile({
    required String complexion,
    required String bodyType,
    required String bloodGroup,
    required String height,
    required String weight,
  }) async {
    try {
      final String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {
        'ProfileID': userId,
        'complexion': complexion,
        'bodytype':   bodyType,
        'bloodgroup': bloodGroup,
        'height':     height,
        'weight':     weight,
      };

      print("📤 UPDATE BASIC API URL: $updateBasicApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(updateBasicApiUrl, data: requestBody);

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['status'] == 'Success') {
          return ApiResponse.success(
            responseData['message'] ?? 'Profile updated successfully',
          );
        }
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to update profile',
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        responseData['message'] ?? 'Failed to update profile',
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