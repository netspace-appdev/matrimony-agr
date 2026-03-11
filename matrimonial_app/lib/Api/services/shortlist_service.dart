import 'package:agraseva/modules/shortlist/data/model/shortlist_model.dart';
import 'package:dio/dio.dart';

import '../../utils/storage_service.dart';
import '../config/AppConfig.dart';
import 'api_response.dart';

class ShortlistService {
  static String get myShortlistApiUrl     => '${AppConfig.apiBaseUrl}shortlist/my';
  static String get addShortlistApiUrl    => '${AppConfig.apiBaseUrl}shortlist/add';
  static String get deleteShortlistApiUrl => '${AppConfig.apiBaseUrl}shortlist/delete';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  // ──────────────────────────────────────────────
  // GET MY SHORTLIST  →  POST /shortlist/my
  // Body: { "ProfileID": "1" }
  // ──────────────────────────────────────────────
  static Future<ApiResponse<List<ShortListResultModel>>> getMyShortlist({
    required String profileId,
  }) async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {
        'ProfileID': userId,
      };

      print("📤 GET MY SHORTLIST API URL: $myShortlistApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(
        myShortlistApiUrl,
        data: requestBody,
      );

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {

        final model = ShortlistModel.fromJson(responseData);

        return ApiResponse.success(
          model.message ?? 'Shortlist fetched successfully',
          data: model.result ?? [],
        );
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to fetch shortlist',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Unexpected error: ${e.toString()}');
    }
  }

  // ──────────────────────────────────────────────
  // ADD TO SHORTLIST  →  POST /shortlist/add
  // Body: { "ProfileID": "1", "ToProfileID": "5" }
  // ──────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> addToShortlist({
   // required String profileId,
    required String toProfileId,
  }) async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

    final requestBody = {
        'ProfileID': userId,
        'ToProfileID': toProfileId,
      };

      print("📤 ADD SHORTLIST API URL: $addShortlistApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(
        addShortlistApiUrl,
        data: requestBody,
      );

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          responseData['message'] ?? 'Added to shortlist successfully',
          data: responseData,
        );
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to add to shortlist',
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

  // ──────────────────────────────────────────────
  // DELETE FROM SHORTLIST  →  POST /shortlist/delete
  // Body: { "MyProfileID": "1", "ProfileID": "5" }
  // ──────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> removeFromShortlist({
 //   required String myProfileId,
    required String profileId,
  }) async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {
        'MyProfileID': userId,
        'ProfileID': profileId,
      };

      print("📤 DELETE SHORTLIST API URL: $deleteShortlistApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(
        deleteShortlistApiUrl,
        data: requestBody,
      );

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          responseData['message'] ?? 'Removed from shortlist successfully',
          data: responseData,
        );
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to remove from shortlist',
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