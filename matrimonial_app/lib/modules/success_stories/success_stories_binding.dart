// lib/app/modules/success_stories/success_stories_binding.dart
import 'package:get/get.dart';
import 'success_stories_controller.dart';

class SuccessStoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessStoriesController>(() => SuccessStoriesController());
  }
}
