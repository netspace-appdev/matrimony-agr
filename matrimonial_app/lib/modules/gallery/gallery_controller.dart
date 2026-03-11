// lib/app/modules/gallery/gallery_controller.dart
import 'package:get/get.dart';
import '../../Api/services/ContentService.dart';
import '../../data/models/member_model.dart';

// lib/app/modules/gallery/gallery_controller.dart
import 'package:get/get.dart';
import 'data/model/gallery_api_model.dart';

// lib/app/modules/gallery/gallery_controller.dart
import 'package:get/get.dart';
import '../../Api/services/ContentService.dart';
import 'data/model/gallery_api_model.dart';

class GalleryController extends GetxController {

  final allItems         = <Result>[].obs;
  final categories       = <String>['All'].obs;
  final selectedCategory = 'All'.obs;
  final isLoading        = false.obs;
  final errorMessage     = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGallery();
  }

  // ─────────────────────────────────────────────
  //  FETCH GALLERY
  // ─────────────────────────────────────────────
  Future<void> fetchGallery() async {
    isLoading.value    = true;
    errorMessage.value = '';

    final response = await ContentService.getGallery();

    if (response.success && response.data != null) {
      // response.data is the raw Map — parse the full wrapper model
      final galleryModel = GalleryApiModel.fromJson(
          response.data as Map<String, dynamic>);

      final items = galleryModel.result ?? [];
      allItems.assignAll(items);
      _buildCategories(items);
    } else {
      errorMessage.value = response.message ?? 'Failed to load gallery.';
    }

    isLoading.value = false;
  }

  // ─────────────────────────────────────────────
  //  HELPERS
  // ─────────────────────────────────────────────
  void _buildCategories(List<Result> items) {
    // Using 'alias' as the category field (from your Result model)
    final cats = <String>{
      'All',
      ...items
          .map((e) => e.alias ?? '')
          .where((c) => c.isNotEmpty),
    };
    categories.assignAll(cats.toList());
  }

  void setCategory(String c) => selectedCategory.value = c;

  List<Result> get filtered => selectedCategory.value == 'All'
      ? allItems
      : allItems
      .where((i) => (i.alias ?? '') == selectedCategory.value)
      .toList();
}