// lib/app/modules/member_detail/member_detail_binding.dart
import 'package:get/get.dart';
import 'member_detail_controller.dart';

class MemberDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberDetailController>(() => MemberDetailController());
  }
}
