// lib/app/modules/success_stories/success_stories_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'success_stories_controller.dart';

class SuccessStoriesScreen extends GetView<SuccessStoriesController> {
  const SuccessStoriesScreen({super.key});

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
                      const Text('Success Stories 💑',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _HeroStat(count: '500+', label: 'Happy Couples'),
                      const SizedBox(width: 10),
                      _HeroStat(count: '5000+', label: 'Members'),
                      const SizedBox(width: 10),
                      _HeroStat(count: '10+', label: 'Years'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SectionHeader(title: 'Couple Stories 💑'),
          ),

          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final s = controller.stories[i];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12)
                        ],
                      ),
                      child: Column(
                        children: [
                          // Couple display
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withOpacity(0.08),
                                  AppColors.secondary.withOpacity(0.04),
                                ],
                              ),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                _CoupleAvatar(
                                    emoji: '🤵',
                                    name: s.groomName.split(' ')[0]),
                                const Column(
                                  children: [
                                    Text('💍',
                                        style: TextStyle(fontSize: 30)),
                                    Text('Married',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                _CoupleAvatar(
                                    emoji: '👰',
                                    name: s.brideName.split(' ')[0]),
                              ],
                            ),
                          ),
                          // Details
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('❤️ ${s.groomName} & ${s.brideName}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: AppColors.textDark)),
                                const SizedBox(height: 7),
                                Wrap(
                                  spacing: 6,
                                  children: [
                                    InfoTag(label: '📅 ${s.marriageDate}'),
                                    InfoTag(label: '📍 ${s.city}'),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF5F5),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: const Color(0xFFFFCCCC)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('"',
                                          style: TextStyle(
                                              fontSize: 36,
                                              color: AppColors.primary,
                                              height: 0.8)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(s.message,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: AppColors.textDark,
                                                height: 1.5,
                                                fontStyle:
                                                    FontStyle.italic)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: controller.stories.length,
                ),
              )),

          // CTA
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('Share Your Story ❤️',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.white)),
                  const SizedBox(height: 6),
                  const Text(
                      'Got married through Agraseva? Inspire others!',
                      style: TextStyle(fontSize: 13, color: Colors.white70)),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 11),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Submit Your Story',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final String count, label;
  const _HeroStat({required this.count, required this.label});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Column(
            children: [
              Text(count,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.white)),
              Text(label,
                  style: const TextStyle(fontSize: 10, color: Colors.white70)),
            ],
          ),
        ),
      );
}

class _CoupleAvatar extends StatelessWidget {
  final String emoji, name;
  const _CoupleAvatar({required this.emoji, required this.name});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(height: 6),
          Text(name,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark)),
        ],
      );
}
