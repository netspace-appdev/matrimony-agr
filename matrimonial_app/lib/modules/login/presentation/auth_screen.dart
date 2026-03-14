// lib/app/modules/login/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widgets.dart';
import '../../terms/terms_screen.dart';
import 'auth_controller.dart';

/*class AuthScreen extends StatelessWidget {
   AuthScreen({super.key});

final AuthController controller = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
              padding: const EdgeInsets.fromLTRB(22, 56, 22, 36),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(child: Text('🪔', style: TextStyle(fontSize: 22))),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Agraseva',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Colors.white)),
                          Text('Agrawal Samaj Matrimonial',
                              style: TextStyle(fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Obx(() => Text(
                        controller.isLogin.value ? 'Welcome Back 🙏' : 'Join Agraseva',
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            color: Colors.white),
                      )),
                  const SizedBox(height: 6),
                  Obx(() => Text(
                        controller.isLogin.value
                            ? 'Sign in to find your perfect match'
                            : 'Create your profile today',
                        style: const TextStyle(fontSize: 14, color: Colors.white70),
                      )),
                ],
              ),
            ),

            // Form body
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  // Tab switcher
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(4),
                    child: Obx(() => Row(
                          children: [

                            _TabBtn(
                              label: 'Sign In',
                              isActive: controller.isLogin.value,
                              onTap: () => controller.toggleTab(true),
                            ),
                            _TabBtn(
                              label: 'Register',
                              isActive: !controller.isLogin.value,
                              onTap: () => controller.toggleTab(false),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 18),

                  // Register extra fields
                  Obx(() => controller.isLogin.value
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            /// NAME
                            TextField(
                              controller: controller.userName,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                prefixIcon:  Image.asset('assets/images/user.png',height: 10,width: 10, color: AppColors.textMuted),
                                //  errorText: controller.mobileError.value,
                              ),
                            ),
                            const SizedBox(height: 10),


                            /// FATHER NAME
                            TextField(
                              controller: controller.userName,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Father Name',
                                prefixIcon:  Image.asset('assets/images/father.png',height: 10,width: 10, color: AppColors.textMuted),
                                errorText: controller.mobileError.value,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Obx(()=>
                                TextField(
                                  controller: controller.mobileController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Mobile Number',
                                    prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.textMuted),
                                    errorText: controller.mobileError.value,
                                  ),
                                ),
                            ),
                            const SizedBox(height: 10),
                            /// GOTRA
                            _dropdownField(
                              icon: "assets/images/gotra.png",
                              value: controller.gotraDropdownValue,
                              items: controller.gotraList,
                              onChanged: (val) {
                                controller.gotraDropdownValue.value = val!;
                              },
                            ),

                            const SizedBox(height: 10),


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
                                final sel = controller.lookingFor.value == g;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.setLookingFor(g),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: g == 'Bride' ? 8 : 0,
                                          left: g == 'Groom' ? 8 : 0),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        gradient: sel ? AppColors.primaryGradient : null,
                                        color: sel ? null : Colors.white,
                                        border: Border.all(
                                            color: sel ? Colors.transparent : AppColors.border),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          g == 'Bride' ? '👰 Bride' : '🤵 Groom',
                                          style: TextStyle(
                                              color: sel ? Colors.white : AppColors.textMuted,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            )),

                            /// MOBILE


                            const SizedBox(height: 10),

                            /// STATE
                            _dropdownField(
                              icon: "assets/images/state.png",
                              value: controller.stateDropdownValue,
                              items: controller.stateList,
                              onChanged: (val) {
                                controller.stateDropdownValue.value = val!;
                              },
                            ),

                            const SizedBox(height: 10),

                            /// CITY
                            _dropdownField(
                              icon: "assets/images/city.png",
                              value: controller.cityDropdownValue,
                              items: controller.cityList,
                              onChanged: (val) {
                                controller.cityDropdownValue.value = val!;
                              },
                            ),

                            const SizedBox(height: 10),

                            Obx(() => TextField(
                              controller: controller.passwordController,
                              obscureText: controller.obscurePass.value,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted),
                                errorText: controller.passwordError.value,
                                suffixIcon: GestureDetector(
                                  onTap: controller.toggleObscure,
                                  child: Icon(
                                    controller.obscurePass.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            )),

                            const SizedBox(height: 10),
                            Obx(() => TextField(
                              controller: controller.confirmPassword,
                              obscureText: controller.obscurePass.value,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted),
                                errorText: controller.passwordError.value,
                                suffixIcon: GestureDetector(
                                  onTap: controller.toggleObscure,
                                  child: Icon(
                                    controller.obscurePass.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            )),
                            /// CONFIRM PASSWORD


                            const SizedBox(height: 14),
                          ],
                        )),


                  const SizedBox(height: 12),
                  controller.isLogin.value==true? Obx(()=>
                      TextField(
                        controller: controller.mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.textMuted),
                          errorText: controller.mobileError.value,
                        ),
                      ),
                  ):SizedBox(),

                  const SizedBox(height: 10),

                  controller.isLogin.value.toString()=='Sign In'?Obx(() => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.obscurePass.value,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textMuted),
                      errorText: controller.passwordError.value,
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleObscure,
                        child: Icon(
                          controller.obscurePass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  )):SizedBox(),

                  Obx(() => controller.isLogin.value
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password?',
                                style: TextStyle(
                                    color: AppColors.primary, fontWeight: FontWeight.w700)),
                          ),
                        )
                      : const SizedBox(height: 16)),

                  Obx(() => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(color: AppColors.primary))
                      : GradientButton(
                          text: controller.isLogin.value ? 'Sign In' : 'Create Profile',
                          onTap: controller.submit,
                        )),

                  const SizedBox(height: 16),
      Obx(() => GestureDetector(
        onTap: (){
          controller.toggleTerms();
          Get.to(() => TermsScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// Checkbox Image
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: controller.isTermCheck.value
                  ? Image.asset(
                "assets/images/checked.png",
                height: 25,
              )
                  : Image.asset(
                "assets/images/unchecked.png",
                height: 25,
              ),
            ),

            const SizedBox(width: 5),

            /// Text Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "By logging in you agree to our",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                 //   Get.to(() => TermsScreen());
                  },
                  child: const Row(
                    children: [
                      Text(
                        "Terms and Conditions ",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        "and privacy policy.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ))

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dropdownField({
  required String icon,
  required RxString value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return Obx(() => Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
        )
      ],
    ),
    child: Row(
      children: [
        Image.asset(icon, height: 20, width: 20),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButton<String>(
            value: value.value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: onChanged,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        )
      ],
    ),
  ));
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _TabBtn({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print("Tab tapped: $label");   // 👈 print value
          onTap();                      // 👈 call parent function
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6)]
                : [],
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    color: isActive ? AppColors.primary : AppColors.textMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          ),
        ),
      ),
    );
  }
}*/

// lib/app/modules/auth/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widgets.dart';
import 'auth_controller.dart';
import 'login_tab.dart';
import 'register_tab.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  //final AuthController controller= Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Gradient Header ──────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
            padding: const EdgeInsets.fromLTRB(22, 56, 22, 28),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo row
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text('🪔', style: TextStyle(fontSize: 22))),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Agraseva',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Colors.white)),
                        Text('Agrawal Samaj Matrimonial',
                            style:
                            TextStyle(fontSize: 11, color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Dynamic title
                Obx(() => Text(
                  controller.isLogin.value
                      ? 'Welcome Back 🙏'
                      : 'Join Agraseva',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                      color: Colors.white),
                )),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.isLogin.value
                      ? 'Sign in to find your perfect match'
                      : 'Create your profile today',
                  style: const TextStyle(
                      fontSize: 13, color: Colors.white70),
                )),
                const SizedBox(height: 20),

                // ── Tab switcher (lives in header) ───────────────────────
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(4),
                  child: Obx(() => Row(
                    children: [
                      _TabBtn(
                        label: 'Sign In',
                        isActive: controller.isLogin.value,
                        onTap: () => controller.toggleTab(true),
                      ),
                      _TabBtn(
                        label: 'Register',
                        isActive: !controller.isLogin.value,
                        onTap: () => controller.toggleTab(false),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),

          // ── Body — swaps between Login / Register ────────────────────────
          Expanded(
            child: Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: controller.isLogin.value
                  ? LoginTab(key: const ValueKey('login'))
                  : RegisterTab(key: const ValueKey('register')),
            )),
          ),
        ],
      ),
    );
  }
}

// ── Tab button ───────────────────────────────────────────────────────────────
class _TabBtn extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _TabBtn(
      {required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
              BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 6)
            ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: isActive ? AppColors.primary : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}