// lib/app/modules/auth/register_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widgets.dart';
import '../../common/common_controller.dart';
import '../../terms/terms_screen.dart';
import 'auth_controller.dart';

class RegisterTab extends StatelessWidget {
  const RegisterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();
    final common = Get.find<CommonController>();   // ← single line added

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // ── Full Name  →  c.userName ────────────────────────────────────
          Obx(() => TextField(
            controller: c.userName,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Full Name',
              prefixIcon: Image.asset(
                  'assets/images/user.png',
                  height: 20, width: 20,
                  color: AppColors.textMuted),
              errorText: c.nameError.value,
            ),
          )),
          const SizedBox(height: 14),

          Obx(() => TextField(
            controller: c.userLastName,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Last Name',
              prefixIcon: Image.asset(
                  'assets/images/user.png',
                  height: 20, width: 20,
                  color: AppColors.textMuted),
              errorText: c.nameError.value,
            ),
          )),
          const SizedBox(height: 14),

          // ── Father Name  →  c.userFather ───────────────────────────────
          Obx(() => TextField(
            controller: c.userFather,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Father Name',
              prefixIcon: Image.asset(
                  'assets/images/father.png',
                  height: 20, width: 20,
                  color: AppColors.textMuted),
              errorText: c.fatherError.value,
            ),
          )),
          const SizedBox(height: 14),

          // ── Mobile  →  c.userMobile ────────────────────────────────────
          Obx(() => TextField(
            controller: c.userMobile,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              hintText: 'Mobile Number',
              prefixIcon: const Icon(Icons.phone_outlined,
                  color: AppColors.textMuted),
              errorText: c.regMobileError.value,
            ),
          )),
          const SizedBox(height: 14),

          Obx(() => TextField(
            controller: c.userConfirmMobile,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              hintText: 'Alternate Mobile Number',
              prefixIcon: const Icon(Icons.phone_outlined,
                  color: AppColors.textMuted),
              errorText: c.regConfirmMobileError.value,
            ),
          )),

          const SizedBox(height: 14),
          // ── Gotra  →  c.gotraDropdownValue ─────────────────────────────
          Obx(() => _DropdownField(
            icon: 'assets/images/gotra.png',
            value: common.gotraDropdownValue.value,
            items: common.gotraList,
            errorText: common.gotraError.value,
            onChanged: (val) => common.onGotraChanged(val!),
          )),
          const SizedBox(height: 14),

          // ── Looking For ─────────────────────────────────────────────────
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Looking For',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted)),
          ),
          const SizedBox(height: 8),
          Obx(() => Row(
            children: ['Bride', 'Groom'].map((g) {
              final sel = c.lookingFor.value == g;
              return Expanded(
                child: GestureDetector(
                  onTap: () => c.setLookingFor(g),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: g == 'Bride' ? 8 : 0,
                        left: g == 'Groom' ? 8 : 0),
                    padding:
                    const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient:
                      sel ? AppColors.primaryGradient : null,
                      color: sel ? null : Colors.white,
                      border: Border.all(
                          color: sel ? Colors.transparent : AppColors.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        g == 'Bride' ? '👰 Bride' : '🤵 Groom',
                        style: TextStyle(
                            color: sel
                                ? Colors.white
                                : AppColors.textMuted,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
          const SizedBox(height: 14),
          Obx(() => TextField(
            controller: c.userAddress,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Address',
              prefixIcon: const Icon(Icons.location_on,
                  color: AppColors.textMuted),
              errorText: c.regAddressError.value,
            ),
          )),
          const SizedBox(height: 14),

          // ── State  →  c.stateDropdownValue ─────────────────────────────
          Obx(() => _DropdownField(
            icon: 'assets/images/state.png',
            value: common.stateDropdownValue.value,
            items: common.stateList,
            errorText: common.stateError.value,
            onChanged: (val) => common.onStateChanged(val!),
          )),
          const SizedBox(height: 14),

          // ── City  →  c.cityDropdownValue ───────────────────────────────
          Obx(() => _DropdownField(
            icon: 'assets/images/city.png',
            value: common.cityDropdownValue.value,
            items: common.cityList,
            errorText: common.cityError.value,
            onChanged: (val) => common.onCityChanged(val!),
          )),
          const SizedBox(height: 14),

          // ── Password  →  c.password ────────────────────────────────────
          Obx(() => TextField(
            controller: c.password,
            obscureText: c.obscurePass.value,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppColors.textMuted),
              errorText: c.passwordError.value,
              suffixIcon: GestureDetector(
                onTap: c.toggleObscure,
                child: Icon(
                  c.obscurePass.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          )),
          const SizedBox(height: 14),

          // ── Confirm Password  →  c.confirmPassword ─────────────────────
          Obx(() => TextField(
            controller: c.confirmPassword,
            obscureText: c.obscureConfirmPass.value,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppColors.textMuted),
              errorText: c.confirmPassError.value,
              suffixIcon: GestureDetector(
                onTap: c.toggleObscureConfirm,
                child: Icon(
                  c.obscureConfirmPass.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          )),
          const SizedBox(height: 18),

          // ── Terms & Conditions  →  c.isTermCheck ───────────────────────
          Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: c.toggleTerms,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Checkbox image  →  c.isTermCheck.value
                    c.isTermCheck.value
                        ? Image.asset('assets/images/checked.png',
                        height: 24)
                        : Image.asset('assets/images/unchecked.png',
                        height: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () =>
                                    Get.to(() => TermsScreen()),
                                child: const Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () =>
                                    Get.to(() => TermsScreen()),
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Terms error text
              if (c.termsError.value != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 4),
                  child: Text(
                    c.termsError.value!,
                    style: const TextStyle(
                        color: Color(0xFFD32F2F), fontSize: 12),
                  ),
                ),
            ],
          )),
          const SizedBox(height: 18),

          // ── API error banner ──────────────────────────────────────────────
          Obx(() {
            final err = c.formError.value;
            if (err == null) return const SizedBox.shrink();
            return _ErrorBanner(
                message: err, onClose: () => c.formError.value = null);
          }),

          // ── Submit ────────────────────────────────────────────────────────
          Obx(() => c.isLoading.value
              ? const Center(
              child: CircularProgressIndicator(
                  color: AppColors.primary))
              : GradientButton(
              text: 'Create Profile', onTap: (){
                c.register();
          })),
        ],
      ),
    );
  }
}

// ── Dropdown field with error + red border ────────────────────────────────
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
                  style: const TextStyle(
                      color: Colors.black87, fontSize: 14),
                  onChanged: onChanged,
                  items: items
                      .toSet()
                      .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
                      .toList(),
                )
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

// ── Error banner ──────────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  const _ErrorBanner({required this.message, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        border: Border.all(color: const Color(0xFFFFCDD2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline,
              color: Color(0xFFD32F2F), size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(message,
                  style: const TextStyle(
                      color: Color(0xFFD32F2F), fontSize: 13))),
          GestureDetector(
              onTap: onClose,
              child: const Icon(Icons.close,
                  color: Color(0xFFD32F2F), size: 16)),
        ],
      ),
    );
  }
}