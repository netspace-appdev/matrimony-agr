import 'appEnvironment.dart';

class AppConfig {
  //static const AppEnvironment environment = AppEnvironment.local;
   static const AppEnvironment environment = AppEnvironment.live;

  static String get baseUrl {
    switch (environment) {
      case AppEnvironment.local:
        return 'http://<LOCAL-IP>:<PORT>';
      case AppEnvironment.live:
        return 'https://asapi.netspacesoftware.online/api/';
    }
  }

  /// Common API prefix (from doc)
  // static const String apiPrefix = '/jarvis/v1';

   static String get apiBaseUrl => baseUrl;

}
class ApiConstants {
  // Headers
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static String errorTitleFromStatus(int? status) {
    switch (status) {
      case -1:
        return "No Internet";
      case 400:
      case 401:
        return "Login Failed";
      case 500:
        return "Server Error";
      default:
        return "Something Went Wrong";
    }
  }



}
