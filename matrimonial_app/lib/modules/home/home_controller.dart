// lib/app/modules/home/home_controller.dart
import 'package:get/get.dart';
import '../social_members/data/model/member_model.dart';

class HomeController extends GetxController {
  final currentNavIndex = 0.obs;
  final members = <MemberModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    members.assignAll(SampleData.members);
  }

  void setNavIndex(int i) => currentNavIndex.value = i;

  void toggleShortlist(MemberModel m) {
    m.isShortlisted = !m.isShortlisted;
    members.refresh();
  }

  void toggleInterest(MemberModel m) {
    m.interestSent = !m.interestSent;
    members.refresh();
  }

  List<MemberModel> get shortlisted => members.where((m) => m.isShortlisted).toList();
}
