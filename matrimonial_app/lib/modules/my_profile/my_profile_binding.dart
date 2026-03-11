// lib/app/modules/my_profile/my_profile_binding.dart
import 'package:get/get.dart';
import 'my_profile_controller.dart';

class MyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
  }
}
