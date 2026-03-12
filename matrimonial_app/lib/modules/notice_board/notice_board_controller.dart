// lib/app/modules/notice_board/notice_board_controller.dart
import 'package:get/get.dart';
import '../../Api/services/ContentService.dart';

/*class NoticeBoardController extends GetxController {
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
}*/
// lib/app/modules/notice_board/notice_board_controller.dart
// lib/app/modules/notice_board/notice_board_controller.dart
import 'package:get/get.dart';
import 'data/model/notice_model.dart';
import 'data/model/news_model.dart';

class NoticeBoardController extends GetxController {

  // ── Notices ───────────────────────────────────────────────────────────────
  final notices      = <NoticeResult>[].obs;
  final noticeLoading   = false.obs;
  final noticeError     = ''.obs;

  // ── News ──────────────────────────────────────────────────────────────────
  final newsList     = <NewsResult>[].obs;
  final newsLoading     = false.obs;
  final newsError       = ''.obs;

  // ── Filter (for notices) ──────────────────────────────────────────────────
  final selectedFilter = 'All'.obs;
  final filters = <String>['All', 'Events', 'Notice', 'Wedding', 'News'];

  @override
  void onInit() {
    super.onInit();
    fetchNotices();
  }

  // ── Notice helpers ────────────────────────────────────────────────────────
  void setFilter(String f) {
    selectedFilter.value = f;
    if (f == 'News' && newsList.isEmpty) {
      fetchNews(); // called only when News tab tapped + not yet loaded
    }
  }
 // void setFilter(String f) => selectedFilter.value = f;

  List<NoticeResult> get filtered {
    if (selectedFilter.value == 'All') return notices;
    return notices
        .where((n) =>
        (n.title ?? '')
            .toLowerCase()
            .contains(selectedFilter.value.toLowerCase()))
        .toList();
  }

  String emojiFor(NoticeResult notice) => notice.emoji;

  // ── Fetch Notices ─────────────────────────────────────────────────────────
  Future<void> fetchNotices({String noticeId = ''}) async {
    try {
      noticeLoading.value = true;
      noticeError.value   = '';
      final response = await ContentService.getNotice(noticeId: noticeId);
      if (response.success) {
        final model = NoticeModel.fromJson(response.data);
        notices.assignAll(model.result ?? []);
      } else {
        noticeError.value = response.message ?? 'Failed to load notices';
      }
    } catch (e) {
      noticeError.value = 'Something went wrong. Please try again.';
    } finally {
      noticeLoading.value = false;
    }
  }

  // ── Fetch News ────────────────────────────────────────────────────────────
  Future<void> fetchNews({String newsId = ''}) async {
    try {
      newsLoading.value = true;
      newsError.value   = '';
      final response = await ContentService.getNews(newsId: newsId);
      if (response.success) {
        final model = NewsModel.fromJson(response.data);
        newsList.assignAll(model.result ?? []);
      } else {
        newsError.value = response.message ?? 'Failed to load news';
      }
    } catch (e) {
      newsError.value = 'Something went wrong. Please try again.';
    } finally {
      newsLoading.value = false;
    }
  }

  // ── Image URL helper ──────────────────────────────────────────────────────
  String newsImageUrl(String? image) {
    if (image == null || image.isEmpty) return '';
    return 'https://agraseva.com/uploads/news/${image}';
  }

  Future<void> refreshAll() async {
    await Future.wait([fetchNotices(), fetchNews()]);
  }

  imageUrl(String? image) {}
}