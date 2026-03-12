// lib/app/modules/news/news_controller.dart
import 'package:get/get.dart';

import '../../Api/services/ContentService.dart';
import 'data/model/news_model.dart';

class NewsController extends GetxController {
  final newsList     = <NewsResult>[].obs;
  final isLoading    = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews({String newsId = ''}) async {
    try {
      isLoading.value    = true;
      errorMessage.value = '';

      final response = await ContentService.getNews(newsId: newsId);

      if (response.success) {
        final model = NewsModel.fromJson(response.data);
        newsList.assignAll(model.result ?? []);
      } else {
        errorMessage.value = response.message ?? 'Failed to load news';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNews() => fetchNews();

  // ── Image URL helper ──────────────────────────────────────────────────────
  String imageUrl(String? image) {
    if (image == null || image.isEmpty) return '';
    // Adjust base path to match your server's image folder
    return 'https://agraseva.com/uploads/news/$image';
  }
}