import 'package:dio/dio.dart';
import '../config/AppConfig.dart';
import 'api_response.dart';

class ContentService {

  static String get galleryApiUrl        => '${AppConfig.apiBaseUrl}content/gallery';
  static String get successStoriesApiUrl => '${AppConfig.apiBaseUrl}content/success-stories';
  static String get contactUsApiUrl      => '${AppConfig.apiBaseUrl}content/contact-us';
  static String get newsApiUrl           => '${AppConfig.apiBaseUrl}content/news';
  static String get staticPageApiUrl     => '${AppConfig.apiBaseUrl}content/static-page';
  static String get noticeApiUrl         => '${AppConfig.apiBaseUrl}content/notice';


  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: ApiConstants.connectionTimeout,
      receiveTimeout: ApiConstants.connectionTimeout,
      headers: ApiConstants.headers,
    ),
  );

  // ─────────────────────────────────────────────
  //  GET GALLERY
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getGallery() async {
    try {
      print("📤 GALLERY API URL: $galleryApiUrl");

      final response = await _dio.post(galleryApiUrl, data: {});
      final data = response.data;

      print("📥 GALLERY RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? 'Gallery fetched',
          data: data,
        );
      }

      return ApiResponse.error(data['message'] ?? 'Failed to load gallery');
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
  //  GET SUCCESS STORIES
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getSuccessStories() async {
    try {
      print("📤 SUCCESS STORIES API URL: $successStoriesApiUrl");

      final response = await _dio.post(successStoriesApiUrl, data: {});
      final data = response.data;

      print("📥 SUCCESS STORIES RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? 'Success stories fetched',
          data: data,
        );
      }

      return ApiResponse.error(data['message'] ?? 'Failed to load success stories');
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
  //  GET CONTACT US
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getContactUs() async {
    try {
      print("📤 CONTACT US API URL: $contactUsApiUrl");

      final response = await _dio.post(contactUsApiUrl, data: {});
      final data = response.data;

      print("📥 CONTACT US RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? 'Contact info fetched',
          data: data,
        );
      }

      return ApiResponse.error(data['message'] ?? 'Failed to load contact info');
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
  //  GET NEWS  (pass newsId='' for all)
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getNews({String newsId = ''}) async {
    try {
      final requestBody = {'news_id': newsId};

      print("📤 NEWS API URL: $newsApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(newsApiUrl, data: requestBody);
      final data = response.data;

      print("📥 NEWS RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? 'News fetched',
          data: data,
        );
      }

      return ApiResponse.error(data['message'] ?? 'Failed to load news');
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
  //  GET STATIC PAGE  (about_us / privacy_policy / terms_conditions)
  // ─────────────────────────────────────────────
  static Future<ApiResponse<dynamic>> getStaticPage(String pageName) async {
    try {
      final requestBody = {'PageName': pageName};

      print("📤 STATIC PAGE API URL: $staticPageApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(staticPageApiUrl, data: requestBody);
      final data = response.data;

      print("📥 STATIC PAGE RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? 'Page fetched',
          data: data,
        );
      }

      return ApiResponse.error(data['message'] ?? 'Failed to load page');
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


  static Future<ApiResponse<dynamic>> getNotice({required String noticeId}) async {
    try {
      final requestBody = {'notice_id': noticeId};

      print("📤 NOTICE API URL: $noticeApiUrl");
      print("📤 REQUEST BODY: $requestBody");

      final response = await _dio.post(noticeApiUrl, data: requestBody);
      final data = response.data;

      print("📥 NOTICE RESPONSE: $data");

      if (response.statusCode == 200) {
        return ApiResponse.success(
          data['message'] ?? 'Notices fetched',
          data: data,
        );
      }

      return ApiResponse.error(data['message'] ?? 'Failed to load notices');
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