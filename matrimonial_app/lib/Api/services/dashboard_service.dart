// lib/app/core/services/home_service.dart

import 'package:dio/dio.dart';
import '../../modules/home/data/model/dashboard_model.dart';
import '../../utils/storage_service.dart';
import '../config/AppConfig.dart';
import 'api_response.dart';

class DashboardService {

  static String get dashboardApiUrl => '${AppConfig.apiBaseUrl}member/dashboard';


  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  // ─────────────────────────────────────────────
  //  DASHBOARD
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getDashboard() async {
    try {
      String userId = StorageService.get(StorageService.USER_ID) ?? "";

      final requestBody = {
        'ProfileID': userId,
      };

      print("📤 DASHBOARD API URL: $dashboardApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(dashboardApiUrl, data: requestBody);

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['status'] == 'Success' &&
            responseData['result'] != null) {
          final model = DashboardModel.fromJson(responseData);
          return ApiResponse.success(
            responseData['message'] ?? 'Dashboard loaded successfully',
            data: model,
          );
        }
        return ApiResponse.error(
          responseData['message'] ?? 'Failed to load dashboard',
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        responseData['message'] ?? 'Failed to load dashboard',
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