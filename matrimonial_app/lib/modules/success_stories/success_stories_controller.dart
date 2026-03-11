// lib/app/modules/success_stories/success_stories_controller.dart
import 'package:agraseva/modules/success_stories/data/model/success_story_apiModel.dart';
import 'package:get/get.dart';
import '../../Api/services/ContentService.dart';
import '../../data/models/member_model.dart';

// lib/app/modules/success_stories/success_stories_controller.dart
import 'package:get/get.dart';




/*
class SuccessStoriesController extends GetxController {

 // final stories      = <SuccessStoryApiModel>[].obs;
  final isLoading    = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStories();
  }

  // ─────────────────────────────────────────────
  //  FETCH SUCCESS STORIES
  // ─────────────────────────────────────────────
  Future<void> fetchStories() async {
    isLoading.value    = true;
    errorMessage.value = '';

    final response = await ContentService.getSuccessStories();

    if (response.success && response.data != null) {
      final List<dynamic> result = response.data['result'] ?? [];

     // stories.assignAll(result.map((e) => SuccessStoryApiModel.fromJson(e as Map<String, dynamic>)),);
    } else {
      errorMessage.value = response.message ?? 'Failed to load stories.';
    }

    isLoading.value = false;
  }
}*/

class SuccessStoriesController extends GetxController {
  final stories = <SuccessStoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    stories.assignAll(SampleData.successStories);
  }
}
