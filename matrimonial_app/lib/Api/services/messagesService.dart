// lib/app/modules/messages/data/service/messages_service.dart

import 'package:agraseva/Api/config/AppConfig.dart';
import 'package:agraseva/Api/services/api_response.dart';
import 'package:agraseva/utils/storage_service.dart';
import 'package:dio/dio.dart';

import '../../modules/messages/data/model/whoVisitListModel.dart';

class MessagesService {
  static String get whoVisitApiUrl => '${AppConfig.apiBaseUrl}member/who-visit';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  static Future<ApiResponse<dynamic>> getWhoVisitList() async {
    try {
      final String userId = StorageService.get(StorageService.USER_ID) ?? '';

      final requestBody = {
        'ProfileID': userId,
      };

      print('📤 WHO VISIT API URL: $whoVisitApiUrl');
      print('📤 REQUEST BODY: $requestBody');

      final response = await _dio.post(whoVisitApiUrl, data: requestBody);

      print('📥 STATUS CODE: ${response.statusCode}');
      print('📥 WHO VISIT RESPONSE: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = WhoVisitListModel.fromJson(
            response.data as Map<String, dynamic>);

        print('✅ Visitor count: ${model.result?.length}');

        if (model.responseCode == 200 && model.result != null) {
          return ApiResponse.success(
            model.message ?? 'Who visit list fetched',
            data: model,
          );
        }

        return ApiResponse.error(
          model.message ?? 'No visitors found',
          statusCode: response.statusCode,
        );
      }

      return ApiResponse.error(
        'Failed to load who visit list',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      print('❌ DIO ERROR: ${e.response?.data}');
      return ApiResponse.error(
        e.response?.data?['message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    } catch (e, stack) {
      print('❌ UNEXPECTED ERROR: $e\n$stack');
      return ApiResponse.error('Unexpected error: ${e.toString()}');
    }
  }
}