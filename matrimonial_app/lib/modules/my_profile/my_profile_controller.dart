
// lib/app/modules/my_profile/my_profile_controller.dart
import 'package:agraseva/Api/services/dashboard_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Api/services/profileService.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../utils/storage_service.dart';
import '../../widgets/common_widgets.dart';
import 'data/model/profile_model.dart';

/*
class MyProfileController extends GetxController {

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  var userProfile = Rxn<UserProfile>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // fetchUserProfile();
  }




  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print("📤 Fetching user profile...");

      final result = await DashboardService.getUserDetails();

      if (result.success && result.data != null) {
        userProfile.value = result.data;
        print("✅ Profile loaded: ${result.data!.fullName}");
      } else {
        errorMessage.value = result.message ?? 'Failed to load profile';
        print("❌ Profile error: ${result.message}");
      }
    } catch (e) {
      errorMessage.value = 'Unexpected error: ${e.toString()}';
      print("❌ Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }




}
*/





class MyProfileController extends GetxController {

  // ─── State ────────────────────────────────────
  final isLoading  = false.obs;
  final isUpdating = false.obs;
  final userProfile = Rxn<UserProfile>();

  // Shorthand getter for inner Data object
  Data? get data => userProfile.value?.data;

  // ─── Text Controllers ─────────────────────────
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  // ─── Dropdown Selections ──────────────────────
  final selectedComplexion  = RxnString();
  final selectedBodyType    = RxnString();
  final selectedBloodGroup  = RxnString();

  // ─── Options ──────────────────────────────────
  final complexionOptions = ['Fair', 'Wheatish', 'Brown', 'Dark'];
  final bodyTypeOptions   = ['Slim', 'Average', 'Athletic', 'Heavy'];
  final bloodGroupOptions = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  // ─────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  @override
  void onClose() {
    heightController.dispose();
    weightController.dispose();
    super.onClose();
  }

  // ─────────────────────────────────────────────
  //  FETCH PROFILE
  // ─────────────────────────────────────────────
  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await ProfileService.getUserProfile();

      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('✅ message   : ${response.message}');
      print('✅ f_name    : ${response.data?.data?.fName}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

      if (response.data != null) {                    // ← check data, NOT isSuccess
        userProfile.value = response.data;
        if (response.data!.data != null) {
          _populateFields(response.data!.data!);
        }
      } else {
        Get.snackbar('Error', response.message ?? 'Failed to load profile',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFFF5C5C),
            colorText: const Color(0xFFFFFFFF));
      }
    } catch (e) {
      print("❌ FETCH PROFILE ERROR: $e");
      Get.snackbar('Error', 'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFF5C5C),
          colorText: const Color(0xFFFFFFFF));
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────
  //  POPULATE FIELDS FROM MODEL
  // ─────────────────────────────────────────────
  void _populateFields(Data d) {
    selectedComplexion.value =
    complexionOptions.contains(d.complexion) ? d.complexion : null;
    selectedBodyType.value =
    bodyTypeOptions.contains(d.bodyType) ? d.bodyType : null;
    selectedBloodGroup.value =
    bloodGroupOptions.contains(d.bloodGroup) ? d.bloodGroup : null;
    heightController.text = d.height ?? '';
    weightController.text = d.weight ?? '';
  }

  // ─────────────────────────────────────────────
  //  UPDATE PROFILE
  // ─────────────────────────────────────────────
  Future<void> updateProfile() async {
    isUpdating.value = true;
    try {
      final response = await ProfileService.updateBasicProfile(
        complexion: selectedComplexion.value ?? '',
        bodyType:   selectedBodyType.value   ?? '',
        bloodGroup: selectedBloodGroup.value ?? '',
        height:     heightController.text.trim(),
        weight:     weightController.text.trim(),
      );

      if (response.success) {
        Get.snackbar('Success', response.message ?? 'Profile updated successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF4CAF50),
            colorText: const Color(0xFFFFFFFF));
        await fetchProfile();
        Get.back();
      } else {
        Get.snackbar('Error', response.message ?? 'Update failed',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFFF5C5C),
            colorText: const Color(0xFFFFFFFF));
      }
    } catch (e) {
      print("❌ UPDATE PROFILE ERROR: $e");
      Get.snackbar('Error', 'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFF5C5C),
          colorText: const Color(0xFFFFFFFF));
    } finally {
      isUpdating.value = false;
    }
  }

  // ─────────────────────────────────────────────
  //  LOGOUT
  // ─────────────────────────────────────────────
  void logout() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🚪', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              const Text('Logout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
              const SizedBox(height: 8),
              const Text('Are you sure you want to logout?',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textMuted))),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: GradientButton(text: 'Logout', onTap: confirmLogout)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmLogout() {
    StorageService.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}