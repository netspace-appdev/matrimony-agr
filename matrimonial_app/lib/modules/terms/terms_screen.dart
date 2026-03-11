// lib/app/modules/terms/terms_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const _sections = [
    ['1. Acceptance of Terms', 'By registering on Agraseva.com, you agree to these Terms and Conditions. If you do not agree, please do not use our services.'],
    ['2. Eligibility', 'You must be at least 18 years of age and from the Agrawal community to register. Married individuals are not permitted to create profiles.'],
    ['3. User Responsibilities', 'You are responsible for maintaining the confidentiality of your account and all activities conducted under it. All information provided must be accurate and truthful.'],
    ['4. Profile & Content', 'Agraseva reserves the right to remove any profile that violates our guidelines. Inappropriate, misleading, or offensive content is strictly prohibited.'],
    ['5. Privacy of Information', 'Your personal information will only be shared with verified members who have shown mutual interest. We do not sell your data to third parties.'],
    ['6. Payment Terms', 'All subscription fees are non-refundable once the membership has been activated. Pricing may change without prior notice.'],
    ['7. Account Termination', 'Agraseva reserves the right to terminate any account that violates these terms or misuses the platform without prior notice.'],
    ['8. Limitation of Liability', 'Agraseva acts only as a platform to connect prospective life partners. We are not responsible for outcomes of meetings, relationships or marriages formed through the platform.'],
    ['9. Governing Law', 'These terms and conditions are governed by the laws of India. Any disputes shall be subject to the exclusive jurisdiction of courts in Ujjain, Madhya Pradesh.'],
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
                      Text('📋 Terms & Conditions',
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
                        'By using Agraseva, you agree to all the above terms and conditions. For any queries, contact us at agraseva1@gmail.com',
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
                        Text(sec[0],
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: AppColors.primary)),
                        const SizedBox(height: 8),
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
