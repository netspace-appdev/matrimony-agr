// lib/app/modules/notice_board/notice_board_controller.dart
import 'package:get/get.dart';
import '../../data/models/member_model.dart';

class NoticeBoardController extends GetxController {
  final notices = <NoticeModel>[].obs;
  final selectedFilter = 'All'.obs;
  final filters = ['All', 'Events', 'Notice', 'Wedding', 'News'];

  @override
  void onInit() {
    super.onInit();
    notices.assignAll(SampleData.notices);
  }

  void setFilter(String f) => selectedFilter.value = f;

  List<NoticeModel> get filtered {
    if (selectedFilter.value == 'All') return notices;
    return notices
        .where((n) =>
            n.type.toLowerCase() == selectedFilter.value.toLowerCase())
        .toList();
  }
}
