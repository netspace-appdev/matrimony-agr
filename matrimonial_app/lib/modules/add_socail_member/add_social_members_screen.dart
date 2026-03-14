// lib/app/modules/social_members/add_social_members_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_theme.dart';
import '../common/common_controller.dart';
import 'add_social_members_controller.dart';

class SocialMemberSignupScreen extends StatelessWidget {
  SocialMemberSignupScreen({super.key});

  final SocialMembersController controller = Get.find<SocialMembersController>();

  CommonController get common => Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: CustomScrollView(
        slivers: [
          // ── Header ────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 52, 16, 28),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🌟 Join Social Members',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white)),
                      Text('Register as a community leader',
                          style: TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Form ──────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _buildPhotoSection(),
                    const SizedBox(height: 20),

                    _sectionLabel('Personal Information'),
                    const SizedBox(height: 12),

                    _buildTextField(
                      ctrl: controller.nameCtrl,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: Icons.person_outline_rounded,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Name is required'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    _buildTextField(
                      ctrl: controller.mobileCtrl,
                      label: 'Mobile Number',
                      hint: '10-digit mobile number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (v) {
                        if (v == null || v.trim().isEmpty)
                          return 'Mobile number is required';
                        if (v.length < 10) return 'Enter valid 10-digit number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    _buildDobPicker(context),
                    const SizedBox(height: 20),

                    _sectionLabel('Location'),
                    const SizedBox(height: 12),

                    // ── State dropdown ── reads from CommonController ────────
                    Obx(() => _DropdownField(
                      icon: 'assets/images/state.png',
                      value: common.stateDropdownValue.value,  // ✅
                      items: common.stateList,                 // ✅
                      errorText: common.stateError.value,      // ✅
                      onChanged: (val) {
                        if (val != null) controller.onStateSelected(val);
                      },
                    )),
                    const SizedBox(height: 14),

                    // ── City dropdown ── auto-populated after state pick ─────
                    Obx(() => _DropdownField(
                      icon: 'assets/images/city.png',
                      value: common.cityDropdownValue.value,   // ✅
                      items: common.cityList,                  // ✅
                      errorText: common.cityError.value,       // ✅
                      onChanged: (val) {
                        if (val != null) controller.onCitySelected(val);
                      },
                    )),
                    const SizedBox(height: 12),

                    _buildTextField(
                      ctrl: controller.addressCtrl,
                      label: 'Address',
                      hint: 'Enter your full address',
                      icon: Icons.location_on,
                   //   maxLines: 2,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Address is required'
                          : null,
                    ),
                    const SizedBox(height: 20),

                    _sectionLabel('Occupation'),
                    const SizedBox(height: 12),
                    _buildJobTypeDropdown(),
                    const SizedBox(height: 28),

                    _buildSubmitButton(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Profile photo ──────────────────────────────────────────────────────────
  Widget _buildPhotoSection() {
    return Center(
      child: Column(
        children: [
          Obx(() => GestureDetector(
            onTap: () => _showImagePicker(Get.context!),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: controller.profileImage.value == null
                    ? AppColors.primaryGradient
                    : null,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: AppColors.primary.withOpacity(0.3), width: 2),
              ),
              child: controller.profileImage.value != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.file(
                  controller.profileImage.value!,
                  fit: BoxFit.cover,
                ),
              )
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_rounded,
                      color: Colors.white, size: 28),
                  SizedBox(height: 4),
                  Text('Add Photo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          )),
          const SizedBox(height: 6),
          const Text('Profile Photo (Optional)',
              style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  // ─── DOB picker ─────────────────────────────────────────────────────────────
  Widget _buildDobPicker(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => _selectDob(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.cake_rounded,
                color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.dob.value.isEmpty
                    ? 'Date of Birth'
                    : controller.dob.value,
                style: TextStyle(
                  fontSize: 14,
                  color: controller.dob.value.isEmpty
                      ? AppColors.textMuted
                      : AppColors.textDark,
                ),
              ),
            ),
            const Icon(Icons.calendar_today_rounded,
                color: AppColors.textMuted, size: 18),
          ],
        ),
      ),
    ));
  }

  Future<void> _selectDob(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme:
          const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      controller.dob.value =
      '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  // ─── Job type dropdown ───────────────────────────────────────────────────────
  Widget _buildJobTypeDropdown() {
    return Obx(() => _buildDropdownContainer(
      icon: Icons.work_outline_rounded,
      hint: 'Select Occupation Type',
      value: controller.jobTypeDropdownValue.value ?? 'Select Occupation Type',
      items: ['Select Occupation Type', ...controller.jobTypeList],
      onChanged: (val) {
        if (val == null || val == 'Select Occupation Type') return;
        controller.jobTypeDropdownValue.value = val;
      },
    ));
  }

  Widget _buildDropdownContainer({
    required IconData icon,
    required String hint,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: items.contains(value) ? value : items.first,
                isExpanded: true,
                style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                hint: Text(hint,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 14)),
                items: items
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e,
                      style: TextStyle(
                          color: e.startsWith('Select')
                              ? AppColors.textMuted
                              : AppColors.textDark)),
                ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Text field ─────────────────────────────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController ctrl,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14, color: AppColors.textDark),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
        labelStyle:
        const TextStyle(color: AppColors.textMuted, fontSize: 13),
        hintStyle:
        const TextStyle(color: AppColors.textMuted, fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
          const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  // ─── Submit button ───────────────────────────────────────────────────────────
  Widget _buildSubmitButton() {
    return Obx(() => GestureDetector(
      onTap: controller.isSaveLoading.value
          ? null
          : controller.saveSocialMember,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: controller.isSaveLoading.value
              ? null
              : AppColors.primaryGradient,
          color: controller.isSaveLoading.value ? AppColors.border : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: controller.isSaveLoading.value
              ? []
              : [
            BoxShadow(
                color: AppColors.primary.withOpacity(0.35),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Center(
          child: controller.isSaveLoading.value
              ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2.5),
          )
              : const Text(
            'Register as Social Member',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    ));
  }

  Widget _sectionLabel(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted,
            letterSpacing: 0.5));
  }

  // ─── Image picker bottom sheet ───────────────────────────────────────────────
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2)),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.bgLight,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.camera_alt_rounded,
                    color: AppColors.primary),
              ),
              title: const Text('Camera',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.bgLight,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.photo_library_rounded,
                    color: AppColors.primary),
              ),
              title: const Text('Gallery',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ── _DropdownField — UNCHANGED from original ─────────────────────────────────
class _DropdownField extends StatelessWidget {
  final String icon;
  final String value;
  final List<String> items;
  final String? errorText;
  final Function(String?) onChanged;

  const _DropdownField({
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: hasError
                    ? const Color(0xFFD32F2F)
                    : AppColors.border),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4)
            ],
          ),
          child: Row(
            children: [
              Image.asset(icon,
                  height: 20, width: 20, color: AppColors.textMuted),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  value: items.contains(value) ? value : null,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textMuted),
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                  onChanged: onChanged,
                  items: items
                      .toSet()
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 12),
            child: Text(errorText!,
                style: const TextStyle(
                    color: Color(0xFFD32F2F), fontSize: 12)),
          ),
      ],
    );
  }
}