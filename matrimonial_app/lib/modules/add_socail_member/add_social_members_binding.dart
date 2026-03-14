// lib/app/modules/social_members/add_social_members_binding.dart
import 'package:get/get.dart';
import 'add_social_members_controller.dart';

class SocialMembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialMembersController>(() => SocialMembersController());
  }
}
