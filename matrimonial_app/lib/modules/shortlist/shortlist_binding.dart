// lib/app/modules/shortlist/shortlist_binding.dart
import 'package:get/get.dart';
import 'shortlist_controller.dart';

class ShortlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortlistController>(() => ShortlistController());
  }
}
