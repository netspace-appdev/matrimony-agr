// lib/app/modules/visitors/visitors_binding.dart
import 'package:get/get.dart';
import 'visitors_controller.dart';

class VisitorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorsController>(() => VisitorsController());
  }
}
