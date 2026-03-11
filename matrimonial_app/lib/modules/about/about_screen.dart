// lib/app/modules/about/about_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(16, 52, 16, 36),
              child: Column(
                children: [
                  Row(
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
                      const Text('About Agraseva',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 2),
                    ),
                    child: const Center(
                        child: Text('🪔', style: TextStyle(fontSize: 44))),
                  ),
                  const SizedBox(height: 14),
                  const Text('Agraseva.com',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('AGRAWAL SAMAJ MATRIMONIAL',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoCard(
                      icon: '🎯',
                      title: 'Our Mission',
                      content:
                          'Agraseva.com is a dedicated matrimonial platform for the Agarwal community, helping eligible bachelors and bachelorettes find their ideal life partners with trust, transparency and reliability.'),
                  const SizedBox(height: 12),
                  _InfoCard(
                      icon: '👁️',
                      title: 'Our Vision',
                      content:
                          'We blend modern matchmaking technology with traditional Indian values, supporting families in India and across the globe to build strong, respectful marital bonds.'),
                  const SizedBox(height: 12),

                  // Founder message
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Founder\'s Message',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: AppColors.textDark)),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: Text('GM',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Govind Mittal',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: AppColors.textDark)),
                                Text('Founder & Owner',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                Text('Ujjain, Madhya Pradesh',
                                    style: TextStyle(
                                        color: AppColors.textMuted,
                                        fontSize: 11)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF5F5),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: const Color(0xFFFFCCCC)),
                          ),
                          child: const Text(
                            '"हमारी मैट्रिमोनियल वेबसाइट का उद्देश्य समाज के योग्य दूल्हे और दुल्हन को एक सुरक्षित, पारदर्शी और विश्वसनीय मंच प्रदान करना है।"',
                            style: TextStyle(
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                height: 1.7,
                                color: AppColors.textDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Stats
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatCol(count: '5000+', label: 'Members'),
                        _StatCol(count: '500+', label: 'Marriages'),
                        _StatCol(count: '10+', label: 'Years'),
                        _StatCol(count: '50+', label: 'Cities'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline,
                            size: 14, color: AppColors.textMuted),
                        SizedBox(width: 8),
                        Text('Version 1.0.0 | agraseva.com',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String icon, title, content;
  const _InfoCard({required this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 10),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: AppColors.textDark)),
              ],
            ),
            const SizedBox(height: 10),
            Text(content,
                style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textDark,
                    height: 1.6)),
          ],
        ),
      );
}

class _StatCol extends StatelessWidget {
  final String count, label;
  const _StatCol({required this.count, required this.label});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(count,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.white)),
          Text(label,
              style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ],
      );
}
