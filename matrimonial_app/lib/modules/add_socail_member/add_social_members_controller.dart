import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Api/services/social_member_service.dart';
import '../common/common_controller.dart';
import '../social_members/data/model/member_model.dart';

class SocialMembersController extends GetxController {

  CommonController get common => Get.find<CommonController>();

  final isListLoading    = true.obs;
  final hasListError     = false.obs;
  final listErrorMessage = ''.obs;
  final members          = <SocialMemberResult>[].obs;

  final isSaveLoading = false.obs;
  final formKey       = GlobalKey<FormState>();

  final nameCtrl       = TextEditingController();
  final mobileCtrl     = TextEditingController();
  final addressCtrl    = TextEditingController();
  final jobDetailsCtrl = TextEditingController();

  final dob = ''.obs;

  final jobTypeDropdownValue = RxnString();
  final List<String> jobTypeList = ['Business', 'Private Job', 'Government Job'];

  final Rx<File?> profileImage = Rx<File?>(null);

  final isTermCheck = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSocialMembers();
    // CommonController (permanent) already has states loaded — no extra call needed
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    mobileCtrl.dispose();
    addressCtrl.dispose();
    jobDetailsCtrl.dispose();
    super.onClose();
  }


  void onStateSelected(String stateName) {
    common.onStateChanged(stateName);   // ✅ sets stateId + loads cities
  }


  void onCitySelected(String cityName) {
    common.onCityChanged(cityName);     // ✅ sets cityId
  }

  Future<void> fetchSocialMembers() async {
    try {
      isListLoading.value    = true;
      hasListError.value     = false;
      listErrorMessage.value = '';

      print("👥 Fetching social member list...");
      final response = await SocialMemberService.getSocialMemberList();

      if (response.success && response.data != null) {
        members.assignAll(response.data!.result ?? []);
        print("✅ Social members loaded: ${members.length}");

      } else {
        hasListError.value     = true;
        listErrorMessage.value = response.message ?? 'Failed to load members';
        print("❌ List error: ${response.message}");
      }
    } catch (e) {
      hasListError.value     = true;
      listErrorMessage.value = 'Unexpected error: ${e.toString()}';
      print("❌ List exception: $e");
    } finally {
      isListLoading.value = false;
    }
  }


  Future<void> saveSocialMember() async {
    if (formKey.currentState?.validate() != true) return;

    if (dob.value.isEmpty) {
      Get.snackbar('Error', 'Please select date of birth',
          backgroundColor: const Color(0xFFFFEBEE),
          colorText: const Color(0xFFC62828));
      return;
    }

    // ✅ Read IDs from CommonController
    if (common.stateId.isEmpty) {
      common.stateError.value = 'Please select state';
      return;
    }
    if (common.cityId.isEmpty) {
      common.cityError.value = 'Please select city';
      return;
    }

    if (jobTypeDropdownValue.value == null) {
      Get.snackbar('Error', 'Please select occupation type',
          backgroundColor: const Color(0xFFFFEBEE),
          colorText: const Color(0xFFC62828));
      return;
    }

    try {
      isSaveLoading.value = true;

      String base64Photo = '';
      if (profileImage.value != null) {
        final Uint8List bytes = profileImage.value!.readAsBytesSync();
        base64Photo = base64Encode(bytes);
      }

      print("💾 Saving social member...");
      print("   name    : ${nameCtrl.text.trim()}");
      print("   mobile  : ${mobileCtrl.text.trim()}");
      print("   dob     : ${dob.value}");
      print("   state   : ${common.stateId}   (${common.stateDropdownValue.value})");
      print("   city    : ${common.cityId}    (${common.cityDropdownValue.value})");
      print("   jobType : ${jobTypeDropdownValue.value}");

      final response = await SocialMemberService.saveSocialMember(
        name:         nameCtrl.text.trim(),
        mobileNumber: mobileCtrl.text.trim(),
        dob:          dob.value,
        address:      addressCtrl.text.trim(),
        state:        common.stateId,    // ✅ real ID e.g. "12"
        city:         common.cityId,     // ✅ real ID e.g. "45"
        jobType:      jobTypeDropdownValue.value ?? '',
        profilePhoto: base64Photo,
        status:       '0',
      );

      if (response.success) {
        print("✅ Saved successfully");
        Get.snackbar('🎉 Success', response.message ?? 'Registered successfully!',
            backgroundColor: const Color(0xFFE8F5E9),
            colorText: const Color(0xFF2E7D32),
            duration: const Duration(seconds: 3));
        _clearForm();
        Get.back();
        fetchSocialMembers();
      } else {
        print("❌ Save error: ${response.message}");
        Get.snackbar('Error', response.message ?? 'Registration failed',
            backgroundColor: const Color(0xFFFFEBEE),
            colorText: const Color(0xFFC62828));
      }
    } catch (e) {
      print("❌ Save exception: $e");
      Get.snackbar('Error', 'Unexpected error: ${e.toString()}',
          backgroundColor: const Color(0xFFFFEBEE),
          colorText: const Color(0xFFC62828));
    } finally {
      isSaveLoading.value = false;
    }
  }

  // ── Image picker ───────────────────────────────────────────────────────────
  Future<void> pickImage(ImageSource source) async {
    final XFile? picked = await ImagePicker().pickImage(source: source);
    if (picked != null) profileImage.value = File(picked.path);
  }

  // ── Clear form ─────────────────────────────────────────────────────────────
  void _clearForm() {
    nameCtrl.clear();
    mobileCtrl.clear();
    addressCtrl.clear();
    jobDetailsCtrl.clear();
    dob.value                  = '';
    jobTypeDropdownValue.value = null;
    profileImage.value         = null;
    isTermCheck.value          = false;
    common.resetDropdowns();   // ✅ resets state/city in CommonController
  }
}