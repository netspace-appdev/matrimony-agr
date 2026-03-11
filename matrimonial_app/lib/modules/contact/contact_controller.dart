// lib/app/modules/contact/contact_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// lib/app/modules/contact/contact_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/model/contact_info_model.dart';

// lib/app/modules/contact/contact_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Api/services/ContentService.dart';
import 'data/model/contact_info_model.dart';

class ContactController extends GetxController {

  final nameController    = TextEditingController();
  final messageController = TextEditingController();

  final isLoading   = false.obs;
  final isSending   = false.obs;

  // Holds the first Result from API
  final contactResult = Rxn<Result>();

  @override
  void onInit() {
    super.onInit();
    fetchContactInfo();
  }

  @override
  void onClose() {
    nameController.dispose();
    messageController.dispose();
    super.onClose();
  }

  // ─────────────────────────────────────────────
  //  FETCH CONTACT INFO
  // ─────────────────────────────────────────────
  Future<void> fetchContactInfo() async {
    isLoading.value = true;

    final response = await ContentService.getContactUs();

    if (response.success && response.data != null) {
      final model = ContactInfoModel.fromJson(
          response.data as Map<String, dynamic>);

      if (model.result != null && model.result!.isNotEmpty) {
        contactResult.value = model.result!.first;
      }
    }
    // On error → contactResult stays null → screen shows fallback values

    isLoading.value = false;
  }

  // ─────────────────────────────────────────────
  //  CONVENIENCE GETTERS  (fallback to hardcoded defaults)
  // ─────────────────────────────────────────────
  String get phone1   => contactResult.value?.contact    ?? '919755739106';
  String get phone2   => contactResult.value?.altContact ?? '917987127780';
  String get email    => contactResult.value?.email      ?? 'agraseva1@gmail.com';
  String get address  => contactResult.value?.address    ?? 'B-22/11, Ved Nagar, Ujjain, MP - 456010';
  String get website  => 'https://www.agraseva.com';
  String get whatsapp => contactResult.value?.contact    ?? '919755739106';

  // ─────────────────────────────────────────────
  //  URL ACTIONS
  // ─────────────────────────────────────────────
  Future<void> callPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  Future<void> openEmail(String mail) async {
    final uri = Uri(scheme: 'mailto', path: mail);
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  Future<void> openWhatsApp() async {
    final uri = Uri.parse('https://api.whatsapp.com/send?phone=$whatsapp');
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> openWebsite() async {
    final uri = Uri.parse(website);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ─────────────────────────────────────────────
  //  SEND MESSAGE
  // ─────────────────────────────────────────────
  Future<void> sendMessage() async {
    if (nameController.text.isEmpty || messageController.text.isEmpty) {
      Get.snackbar(
        'Error', 'Please fill all fields',
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSending.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isSending.value = false;

    nameController.clear();
    messageController.clear();

    Get.snackbar(
      'Sent!', 'Your message has been sent successfully',
      backgroundColor: const Color(0xFF2D7A4F),
      colorText: const Color(0xFFFFFFFF),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}