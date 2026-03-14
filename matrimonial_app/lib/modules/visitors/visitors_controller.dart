// lib/app/modules/visitors/visitors_controller.dart
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../social_members/data/model/member_model.dart';

class VisitorsController extends GetxController {
 // final visitors = <MemberModel>[].obs;
  final filter = 'All'.obs;
  final filters = ['All', 'Today', 'This Week', 'This Month'];

  @override
  void onInit() {
    super.onInit();
   // visitors.assignAll(SampleData.members);
  }

  void setFilter(String f) => filter.value = f;
 // void viewProfile(MemberModel m) => Get.toNamed(AppRoutes.memberDetail, arguments: m);
}
