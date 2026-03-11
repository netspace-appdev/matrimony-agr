// lib/app/modules/auth/login_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widgets.dart';
import 'auth_controller.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AuthController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: Column(
      //  crossAxisAlignment: CrossAxisAlignment.t,
        children: [

          // ── Mobile ──────────────────────────────────────────────────────
          Obx(() => TextField(
            controller: c.mobileController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Mobile Number',
              prefixIcon: const Icon(Icons.phone_outlined,
                  color: AppColors.textMuted),
              errorText: c.mobileError.value,
            ),
          )),
          const SizedBox(height: 14),

          // ── Password ─────────────────────────────────────────────────────
          Obx(() => TextField(
            controller: c.passwordController,
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

          // ── Forgot password ───────────────────────────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: navigate to ForgotPasswordScreen
              },
              child: const Text('Forgot Password?',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700)),
            ),
          ),

          // ── API error banner ──────────────────────────────────────────────
          Obx(() {
            final err = c.formError.value;
            if (err == null) return const SizedBox.shrink();
            return _ErrorBanner(
                message: err, onClose: () => c.formError.value = null);
          }),
          const SizedBox(height: 4),

          // ── Submit ────────────────────────────────────────────────────────
          Obx(() => c.isLoading.value
              ? const Center(
              child:
              CircularProgressIndicator(color: AppColors.primary))
              : GradientButton(text: 'Sign In', onTap: c.submit)),

          const SizedBox(height: 20),
          _divider(),
          const SizedBox(height: 14),

         // ── Social buttons ────────────────────────────────────────────────
              Row(
            children: [
              Expanded(
                  child:
                  OutlineButton(text: '📱 OTP Login', onTap: () {})),
              const SizedBox(width: 12),
              Expanded(
                  child: OutlineButton(text: '🔍 Google', onTap: () {})),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'By continuing, you agree to our Terms & Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────
Widget _divider() => Row(children: [
  Expanded(child: Divider(color: Colors.grey.shade200)),
  const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text('Or continue with',
          style: TextStyle(color: AppColors.textMuted, fontSize: 12))),
  Expanded(child: Divider(color: Colors.grey.shade200)),
]);

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onClose;
  const _ErrorBanner({required this.message, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
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