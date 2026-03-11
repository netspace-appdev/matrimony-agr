// lib/app/modules/notice_board/notice_board_binding.dart
import 'package:get/get.dart';
import 'notice_board_controller.dart';

class NoticeBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeBoardController>(() => NoticeBoardController());
  }
}
