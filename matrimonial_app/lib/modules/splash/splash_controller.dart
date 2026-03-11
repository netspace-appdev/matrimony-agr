import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../utils/storage_service.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();

    String userId = StorageService.get(StorageService.USER_ID) ?? "";

    _navigateToLogin(userId);
  }

  void _navigateToLogin(String userId) async {

    print("USER ID : $userId");

    await Future.delayed(const Duration(seconds: 2));

    if (userId.isNotEmpty) {
      Get.offAllNamed(AppRoutes.mainNav);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}