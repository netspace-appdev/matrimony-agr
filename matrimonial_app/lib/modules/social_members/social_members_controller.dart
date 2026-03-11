// lib/app/modules/social_members/social_members_controller.dart
import 'package:get/get.dart';
import '../../data/models/member_model.dart';

class SocialMembersController extends GetxController {
  final members = <SocialMemberModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    members.assignAll(SampleData.socialMembers);
  }
}
