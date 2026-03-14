// lib/app/modules/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/app_routes.dart';
import '../../widgets/drawer.dart';
import 'data/model/dashboard_model.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Obx(() {
        // ── Full-screen loader on first load ──────────────────────
        if (controller.isLoading.value && controller.dashboard.value == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        // ── Full-screen error (only if no cached data) ────────────
        if (controller.hasError.value && controller.dashboard.value == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off_rounded,
                      size: 56, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value.isNotEmpty
                        ? controller.errorMessage.value
                        : 'Failed to load dashboard.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: controller.fetchDashboard,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Main content ──────────────────────────────────────────
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.fetchDashboard,
          child: CustomScrollView(
            slivers: [
              // ── Header ────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildHeader()),

              // ── Marquee / Quick Info banner ───────────────────────
              if (controller.activeQuickInfo.isNotEmpty)
                SliverToBoxAdapter(child: _buildQuickInfoBanner()),

              // ── Stats ─────────────────────────────────────────────
              SliverToBoxAdapter(child: _buildStats()),

              // ── Notification Alerts ───────────────────────────────
              if (controller.activeAlerts.isNotEmpty) ...[
                SliverToBoxAdapter(
                    child: SectionHeader(title: 'Announcements')),
                SliverToBoxAdapter(child: _buildAlerts()),
              ],

              // ── Quick Actions ─────────────────────────────────────
              SliverToBoxAdapter(
                  child: SectionHeader(title: 'Quick Actions')),
              SliverToBoxAdapter(child: _buildQuickActions()),

              // ── Premium banner ────────────────────────────────────
              SliverToBoxAdapter(child: _buildPremiumBanner()),

              // ── Suggested Matches ─────────────────────────────────
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Suggested Matches',
                  actionLabel: 'See All →',
                  onAction: () => Get.toNamed(AppRoutes.search),
                ),
              ),

              Obx(() {
                final matches = controller.suggestedMatches;
                if (matches.isEmpty) {
                  return SliverToBoxAdapter(child: _buildEmptyMatches());
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) => _SuggestedMatchCard(member: matches[i]),
                    childCount: matches.length,
                  ),
                );
              }),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      }),
    );
  }

  // ── Header ────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 52, 18, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(14),
                        border:
                        Border.all(color: Colors.white.withOpacity(0.4)),
                      ),
                      child: const Center(
                        child:
                        Icon(Icons.menu, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Namaste 🙏',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(
                        controller.userName.isEmpty
                            ? 'Welcome!'
                            : controller.userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ],
                  )),
                ],
              ),
              // Notification bell
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
                      if (controller.activeAlerts.isNotEmpty)
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

          // Profile completion from API
          Obx(() => Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Profile Completion',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(100)),
                        child: LinearProgressIndicator(
                          value: controller.profileCompletionFraction,
                          backgroundColor: Colors.white30,
                          color: Colors.white,
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  '${controller.profileCompletion}%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.myProfile),
                  child: Container(
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
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // ── Quick Info scrolling banner ──────────────────────────────────
  Widget _buildQuickInfoBanner() {
    final items = controller.activeQuickInfo;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(
        children: [
          const Icon(Icons.campaign_rounded,
              color: Color(0xFFF57F17), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: items
                    .map((q) => Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    q.information ?? '',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5D4037),
                        fontWeight: FontWeight.w500),
                  ),
                ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats ────────────────────────────────────────────────────────
  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
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
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
              emoji: '❤️',
              count: controller.shortlistCount.toString(),
              label: 'Shortlists'),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.shortlist),
            child: _StatItem(
                emoji: '👁️',
                count: controller.viewsCount.toString(),
                label: 'Views'),
          ),
          _StatItem(
              emoji: '🔍',
              count: controller.viewsByMeCount.toString(),
              label: 'ViewsByMe'),
        ],
      )),
    );
  }

  // ── Notification alert cards ─────────────────────────────────────
  Widget _buildAlerts() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.activeAlerts.length,
        itemBuilder: (ctx, i) {
          final alert = controller.activeAlerts[i];
          return Container(
            width: 260,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B0000), AppColors.primary],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.campaign_rounded,
                        color: Colors.white70, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        alert.title ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    alert.details ?? '',
                    style:
                    const TextStyle(color: Colors.white70, fontSize: 11),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Quick Actions ─────────────────────────────────────────────────
  Widget _buildQuickActions() {
    return SizedBox(
      height: 88,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          _QuickAction(
              emoji: '📢',
              label: 'Notice\nBoard',
              onTap: () => Get.toNamed(AppRoutes.noticeBoard)),
          _QuickAction(
              emoji: '🏆',
              label: 'Success\nStories',
              onTap: () => Get.toNamed(AppRoutes.successStories)),
          _QuickAction(
              emoji: '🌟',
              label: 'Social\nMembers',
              onTap: () => Get.toNamed(AppRoutes.socialMembers)),
          _QuickAction(
              emoji: '🖼️',
              label: 'Gallery',
              onTap: () => Get.toNamed(AppRoutes.gallery)),
          _QuickAction(
              emoji: '💳',
              label: 'Payment\nInfo',
              onTap: () => Get.toNamed(AppRoutes.payment)),
          _QuickAction(
              emoji: '🔖',
              label: 'My\nShortlist',
              onTap: () => Get.toNamed(AppRoutes.shortlist)),
        ],
      ),
    );
  }

  // ── Premium Banner ────────────────────────────────────────────────
  Widget _buildPremiumBanner() {
    return Container(
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
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.payment),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
    );
  }

  // ── Empty matches state ───────────────────────────────────────────
  Widget _buildEmptyMatches() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: const Column(
        children: [
          Text('💑', style: TextStyle(fontSize: 40)),
          SizedBox(height: 12),
          Text('No suggested matches yet',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.textDark)),
          SizedBox(height: 4),
          Text('Complete your profile to get better suggestions',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SuggestedMatchCard  —  uses SuggestedMatches from dashboard API
// ─────────────────────────────────────────────────────────────────────────────
class _SuggestedMatchCard extends StatelessWidget {
  final SuggestedMatches member;

  const _SuggestedMatchCard({required this.member});

  String get _fullName =>
      '${member.fName ?? ''} ${member.lName ?? ''}'.trim();

  String get _initials {
    final f = member.fName?.isNotEmpty == true ? member.fName![0] : '';
    final l = member.lName?.isNotEmpty == true ? member.lName![0] : '';
    return '$f$l'.toUpperCase();
  }

  String get _subtitle {
    final parts = <String>[];
    if (member.age != null) parts.add('${member.age} yrs');
    if (member.height?.isNotEmpty == true) parts.add(member.height!);
    if (member.address?.isNotEmpty == true) parts.add(member.address!);
    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.memberDetail, arguments: member),
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
            // ── Avatar ───────────────────────────────────────────
            Stack(
              children: [
                _buildAvatar(),
                // Online / verified dot  (memberType == 'Premium')
                if (member.memberType?.toLowerCase() == 'premium')
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

            // ── Details ──────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name row + "New" badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _fullName.isEmpty ? 'Unknown' : _fullName,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark),
                        ),
                      ),
                      if (member.memberType?.toLowerCase() == 'new' ||
                          _isRecentlyJoined())
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

                  // Age • Height • City
                  if (_subtitle.isNotEmpty)
                    Text(_subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 7),

                  // Tags: gotra / marital status / manglik
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      if (member.gotra?.isNotEmpty == true)
                        InfoTag(label: 'Gotra: ${member.gotra}'),
                      if (member.maridStatus?.isNotEmpty == true)
                        InfoTag(label: member.maridStatus!),
                      if (member.manglik?.isNotEmpty == true)
                        InfoTag(label: 'Manglik: ${member.manglik}'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Action buttons
                  Row(
                    children: [
                      // Shortlist
                      Expanded(
                        child: _ActionButton(
                          label: '🔖 Shortlist',
                          isActive: false,
                          activeColor: AppColors.primary,
                          activeBg: const Color(0xFFFFF0F0),
                          onTap: () {
                            // TODO: hook to controller.shortlistMember(member)
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Send Interest
                      Expanded(
                        child: _ActionButton(
                          label: '🤍 Interest',
                          isActive: false,
                          useGradient: true,
                          onTap: () {
                            // TODO: hook to controller.sendInterest(member)
                          },
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

  // Shows profile photo if available, else initials avatar
  Widget _buildAvatar() {
    if (member.profilePhoto?.isNotEmpty == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          member.profilePhoto!,
          width: 76,
          height: 76,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _initialsAvatar(),
        ),
      );
    }
    return _initialsAvatar();
  }

  Widget _initialsAvatar() {
    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          _initials.isEmpty ? '?' : _initials,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  /// Treat as "new" if created within the last 30 days
  bool _isRecentlyJoined() {
    if (member.createdDate == null) return false;
    try {
      final created = DateTime.parse(member.createdDate!);
      return DateTime.now().difference(created).inDays <= 30;
    } catch (_) {
      return false;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared action button used inside _SuggestedMatchCard
// ─────────────────────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool useGradient;
  final Color activeColor;
  final Color activeBg;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    this.useGradient = false,
    this.activeColor = AppColors.primary,
    this.activeBg = const Color(0xFFFFF0F0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive && useGradient ? AppColors.primaryGradient : null,
          color: isActive
              ? (useGradient ? null : activeBg)
              : AppColors.bgLight,
          border: Border.all(
              color: isActive && !useGradient
                  ? activeColor
                  : AppColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isActive
                    ? (useGradient ? Colors.white : activeColor)
                    : AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable small widgets
// ─────────────────────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String emoji, count, label;
  const _StatItem(
      {required this.emoji, required this.count, required this.label});

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
  const _QuickAction(
      {required this.emoji, required this.label, required this.onTap});

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