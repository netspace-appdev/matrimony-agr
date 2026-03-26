// lib/modules/userProfile/presentation/edit_profile_page.dart

import 'package:agraseva/modules/my_profile/my_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';

class EditProfilePage extends GetView<MyProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final d = controller.userProfile.value?.data;
        final String fullName =
        '${d?.fName ?? ''} ${d?.lName ?? ''}'.trim().isEmpty
            ? 'No Name'
            : '${d?.fName ?? ''} ${d?.lName ?? ''}'.trim();
        final String firstLetter =
        fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';

        return CustomScrollView(
          slivers: [

            // ── Gradient Header ──────────────────────────
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(18, 52, 18, 32),
                child: Column(
                  children: [
                    // Top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 20),
                          onPressed: () => Get.back(),
                        ),
                        const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 48), // balance
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Avatar
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.5), width: 3),
                          ),
                          child: d?.profilePhoto != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(23),
                            child: Image.network(
                              d!.profilePhoto!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Center(
                                child: Text(firstLetter,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                          )
                              : Center(
                            child: Text(firstLetter,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                        Positioned(
                          bottom: -8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 6)
                              ],
                            ),
                            child: const Text('📷 Change Photo',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Name
                    Text(fullName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white)),
                    const SizedBox(height: 4),
                    if (d?.contact != null)
                      Text(d!.contact!,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white70)),
                  ],
                ),
              ),
            ),

            // ── Form Card ───────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05), blurRadius: 10)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section label styled like my_profile_screen
                    const Text('Physical Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.primary)),
                    const SizedBox(height: 16),

                    _DropdownField(
                      label: 'Complexion',
                      icon: Icons.palette_outlined,
                      options: controller.complexionOptions,
                      selectedValue: controller.selectedComplexion,
                      onChanged: (v) => controller.selectedComplexion.value = v,
                    ),
                    const SizedBox(height: 14),

                    _DropdownField(
                      label: 'Body Type',
                      icon: Icons.accessibility_new_outlined,
                      options: controller.bodyTypeOptions,
                      selectedValue: controller.selectedBodyType,
                      onChanged: (v) => controller.selectedBodyType.value = v,
                    ),
                    const SizedBox(height: 14),

                    _DropdownField(
                      label: 'Blood Group',
                      icon: Icons.bloodtype_outlined,
                      options: controller.bloodGroupOptions,
                      selectedValue: controller.selectedBloodGroup,
                      onChanged: (v) => controller.selectedBloodGroup.value = v,
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _InputField(
                            label: 'Height (ft)',
                            icon: Icons.height_outlined,
                            controller: controller.heightController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _InputField(
                            label: 'Weight (kg)',
                            icon: Icons.monitor_weight_outlined,
                            controller: controller.weightController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Save Button ──────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                child: Obx(() => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: controller.isUpdating.value
                        ? null
                        : controller.updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor:
                      AppColors.primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isUpdating.value
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ─── Dropdown Field ───────────────────────────────────────────────────────────
class _DropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<String> options;
  final RxnString selectedValue;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.label,
    required this.icon,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
      value: selectedValue.value,
      decoration: _inputDecoration(label, icon),
      items: options
          .map((o) => DropdownMenuItem(value: o, child: Text(o)))
          .toList(),
      onChanged: onChanged,
    ));
  }
}

// ─── Text Input Field ─────────────────────────────────────────────────────────
class _InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label, icon),
    );
  }
}

// ─── Shared Input Decoration ──────────────────────────────────────────────────
InputDecoration _inputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
    filled: true,
    fillColor: AppColors.bgLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  );
}