// lib/app/modules/payment/payment_controller.dart
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final selectedPlan = 'Gold'.obs;

  void selectPlan(String plan) => selectedPlan.value = plan;

  void copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied!',
      '$label copied to clipboard',
      backgroundColor: const Color(0xFFFF0000),
      colorText: const Color(0xFFFFFFFF),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
