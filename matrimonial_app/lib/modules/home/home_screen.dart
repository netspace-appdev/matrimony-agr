// lib/app/modules/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/app_routes.dart';
import '../../data/models/member_model.dart';
import '../../widgets/drawer.dart';
import 'home_controller.dart';

class HomeScreen extends  StatelessWidget{ //GetView<HomeController> {
   HomeScreen({super.key});
  final controller = Get.put(HomeController());
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      key: _scaffoldKey,
      drawer: new MyDrawer(),
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28)),
              ),
              padding: const EdgeInsets.fromLTRB(18, 52, 18, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                              ),
                              child:  Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child:  Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(width: 8),

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Namaste 🙏',
                                  style: TextStyle(color: Colors.white70, fontSize: 13)),
                              SizedBox(height: 2),
                              Text('Rahul Agrawal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22,
                                      color: Colors.white)),
                            ],
                          ),

                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.noticeBoard),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              const Icon(Icons.notifications_outlined,
                                  color: Colors.white, size: 22),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                      color: Colors.yellow,
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Profile completion
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Profile Completion',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                              SizedBox(height: 6),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                child: LinearProgressIndicator(
                                  value: 0.72,
                                  backgroundColor: Colors.white30,
                                  color: Colors.white,
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Text('72%',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16)),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Complete',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stats
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(emoji: '❤️', count: '12', label: 'Interests'),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.visitors),
                    child: _StatItem(emoji: '👁️', count: '48', label: 'Views'),
                  ),
                  _StatItem(emoji: '✅', count: '6', label: 'Accepted'),
                  _StatItem(emoji: '💌', count: '3', label: 'Messages'),
                ],
              ),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
              child: SectionHeader(title: 'Quick Actions')),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 88,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  _QuickAction(emoji: '📢', label: 'Notice\nBoard', onTap: () => Get.toNamed(AppRoutes.noticeBoard)),
                  _QuickAction(emoji: '🏆', label: 'Success\nStories', onTap: () => Get.toNamed(AppRoutes.successStories)),
                  _QuickAction(emoji: '🌟', label: 'Social\nMembers', onTap: () => Get.toNamed(AppRoutes.socialMembers)),
                  _QuickAction(emoji: '🖼️', label: 'Gallery', onTap: () => Get.toNamed(AppRoutes.gallery)),
                  _QuickAction(emoji: '💳', label: 'Payment\nInfo', onTap: () => Get.toNamed(AppRoutes.payment)),
                  _QuickAction(emoji: '🔖', label: 'My\nShortlist', onTap: () => Get.toNamed(AppRoutes.shortlist)),
                ],
              ),
            ),
          ),

          // Premium banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF8B0000), AppColors.primary]),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('⭐ Upgrade to Premium',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14)),
                        SizedBox(height: 4),
                        Text('Unlimited contacts & advanced filters',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.payment),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('₹999/mo',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Members
          SliverToBoxAdapter(
            child: SectionHeader(
              title: 'Suggested Matches',
              actionLabel: 'See All →',
              onAction: () => Get.toNamed(AppRoutes.search),
            ),
          ),
          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final m = controller.members[i];
                    return _MemberCard(
                      member: m,
                      onTap: () => Get.toNamed(AppRoutes.memberDetail,
                          arguments: m),
                      onShortlist: () => controller.toggleShortlist(m),
                      onInterest: () => controller.toggleInterest(m),
                    );
                  },
                  childCount: controller.members.length,
                ),
              )),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String emoji, count, label;
  const _StatItem({required this.emoji, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 2),
        Text(count,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary)),
        Text(label,
            style: const TextStyle(
                fontSize: 9,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final String emoji, label;
  final VoidCallback onTap;
  const _QuickAction({required this.emoji, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05), blurRadius: 6)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                    height: 1.2)),
          ],
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final MemberModel member;
  final VoidCallback onTap, onShortlist, onInterest;

  const _MemberCard({
    required this.member,
    required this.onTap,
    required this.onShortlist,
    required this.onInterest,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProfileAvatar(
                    initials: member.initials, size: 76, borderRadius: 18),
                if (member.isVerified)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Center(
                          child: Text('✓',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800))),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(member.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textDark))),
                      if (member.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('New',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text('${member.age} yrs • ${member.height} • ${member.city}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 7),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      InfoTag(label: member.profession),
                      InfoTag(label: 'Gotra: ${member.gotra}'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onShortlist,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: member.isShortlisted
                                  ? const Color(0xFFFFF0F0)
                                  : AppColors.bgLight,
                              border: Border.all(
                                  color: member.isShortlisted
                                      ? AppColors.primary
                                      : AppColors.border),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                member.isShortlisted
                                    ? '🔖 Saved'
                                    : '🔖 Shortlist',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: member.isShortlisted
                                        ? AppColors.primary
                                        : AppColors.textMuted),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: onInterest,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              gradient: member.interestSent
                                  ? AppColors.primaryGradient
                                  : null,
                              color: member.interestSent
                                  ? null
                                  : AppColors.bgLight,
                              border: Border.all(
                                  color: member.interestSent
                                      ? Colors.transparent
                                      : AppColors.border),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                member.interestSent
                                    ? '❤️ Interested'
                                    : '🤍 Interest',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: member.interestSent
                                        ? Colors.white
                                        : AppColors.textMuted),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
