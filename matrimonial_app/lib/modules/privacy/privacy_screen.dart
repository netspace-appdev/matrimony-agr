// lib/app/modules/privacy/privacy_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static const _sections = [
    ['1. Information We Collect', 'We collect personal details including name, age, education, profession, contact information, and photos when you register on Agraseva.com.'],
    ['2. How We Use Your Information', 'Your information is used to create and display your matrimonial profile to other verified and registered members of the Agrawal community.'],
    ['3. Data Sharing', 'We share your profile information only with registered and verified members. We never sell your personal data to third parties or advertisers.'],
    ['4. Data Security', 'We implement industry-standard security measures including SSL encryption to protect your personal information from unauthorized access or disclosure.'],
    ['5. Profile Visibility Controls', 'You can control who can view your profile and contact information through the privacy settings available in your account dashboard.'],
    ['6. Cookies & Analytics', 'Our app may use cookies and analytics tools to enhance user experience and understand usage patterns to improve our services.'],
    ['7. Third-Party Links', 'Our platform may contain links to third-party websites. We are not responsible for the privacy practices or content of those websites.'],
    ['8. Data Retention', 'Your data is retained as long as your account is active. You may request complete deletion of your data by contacting our support team.'],
    ['9. Changes to Policy', 'We may update this Privacy Policy periodically. Continued use of the platform constitutes acceptance of the updated policy.'],
    ['10. Contact', 'For any privacy concerns or data requests, please contact us at agraseva1@gmail.com or call +91 97557 39106.'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28)),
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
                      Text('🔒 Privacy Policy',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white)),
                      Text('Last updated: January 2025',
                          style:
                              TextStyle(fontSize: 11, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  if (i == _sections.length) {
                    return Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Your privacy is our priority. We are committed to protecting your personal information and providing a safe matrimonial experience.',
                        style: TextStyle(
                            color: Colors.white, fontSize: 13, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  final sec = _sections[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF0F0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                  child: Icon(Icons.lock_outline,
                                      size: 15, color: AppColors.primary)),
                            ),
                            const SizedBox(width: 10),
                            Text(sec[0],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(sec[1],
                            style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textDark,
                                height: 1.6)),
                      ],
                    ),
                  );
                },
                childCount: _sections.length + 1,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }
}
