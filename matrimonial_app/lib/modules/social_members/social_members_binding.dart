// lib/app/modules/social_members/social_members_binding.dart
import 'package:get/get.dart';
import 'social_members_controller.dart';

class SocialMembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialMembersController>(() => SocialMembersController());
  }
}
