import 'dart:io';
import 'package:dio/dio.dart';

import '../config/AppConfig.dart';
import 'api_response.dart';

class AuthService {

  static String get loginApiUrl => '${AppConfig.apiBaseUrl}auth/login';
  static String get stateApiUrl => '${AppConfig.apiBaseUrl}master/state';
  static String get gotraApiUrl => '${AppConfig.apiBaseUrl}master/gotra';
  static String get cityApiUrl => '${AppConfig.apiBaseUrl}master/city';
  static String get registerApiUrl => '${AppConfig.apiBaseUrl}auth/register';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  /// ================= LOGIN =================

  Future<ApiResponse<dynamic>> signInApi({
    required String mobile,
    required String password,
  }) async {
    try {

      final requestBody = {
        'mobileno': mobile,
        'password': password,
      };
      print("📤 LOGIN API URL: $loginApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(
        loginApiUrl,
        data: requestBody,
      );

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(
          responseData['message'] ?? 'Login successful',
          data: responseData,
        );
      } else {
        return ApiResponse.error(
          responseData['message'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }

    } on DioException catch (e) {
      return ApiResponse.error(e.message ?? "Server error");
    }
  }

  /// ================= GET STATE =================

  static Future<ApiResponse<dynamic>> getState() async {
    try {

      final response = await _dio.post(stateApiUrl);

      final data = response.data;

      if (response.statusCode == 200) {
        return ApiResponse.success("State list fetched", data: data);
      }

      return ApiResponse.error("Failed to load state");

    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// ================= GET GOTRA =================

  static Future<ApiResponse<dynamic>> getGotra() async {
    try {

      final response = await _dio.post(gotraApiUrl);

      final data = response.data;

      if (response.statusCode == 200) {
        return ApiResponse.success("Gotra list fetched", data: data);
      }

      return ApiResponse.error("Failed to load gotra");

    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// ================= GET CITY =================

  static Future<ApiResponse<dynamic>> getCity(String stateId) async {
    try {

      final response = await _dio.post(
        cityApiUrl,
        data: {
          "StateID": stateId,
        },
      );

      final data = response.data;

      if (response.statusCode == 200) {
        return ApiResponse.success("City list fetched", data: data);
      }

      return ApiResponse.error("Failed to load city");

    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  static Future<ApiResponse<dynamic>> registerUser({
    required String name,
    required String lastname,
    required String mobileno,
    required String alternateno,
    required String gender,
    required String gotra,
    required String fathername,
    required String address,
    required String state,
    required String city,
    required String password,
    required String date,
  }) async {
    try {

      final requestBody = {
        "name": name,
        "lastname": lastname,
        "mobileno": mobileno,
        "alternateno": alternateno,
        "gender": gender,
        "gotra": gotra,
        "fathername": fathername,
        "address": address,
        "state": state,
        "city": city,
        "password": password,
        "date": date,
      };

      print("📤 REGISTER API BODY: $requestBody");

      final response = await _dio.post(
        registerApiUrl,
        data: requestBody,
      );

      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RESPONSE DATA: ${response.data}");

      final responseData = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {

        return ApiResponse.success(
          responseData['message'] ?? "Registration successful",
          data: responseData,
        );

      } else {

        return ApiResponse.error(
          responseData['message'] ?? "Registration failed",
          statusCode: response.statusCode,
        );

      }

    } on DioException catch (e) {

      print("❌ DIO ERROR: ${e.response?.data}");

      return ApiResponse.error(
        e.response?.data['message'] ?? "Server error",
        statusCode: e.response?.statusCode,
      );

    } catch (e) {

      return ApiResponse.error("Unexpected error: ${e.toString()}");

    }
  }
}