// lib/app/modules/my_profile/my_profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../utils/storage_service.dart';
import '../../widgets/common_widgets.dart';

class MyProfileController extends GetxController {
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
