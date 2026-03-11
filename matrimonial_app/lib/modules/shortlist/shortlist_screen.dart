// lib/app/modules/shortlist/shortlist_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'data/model/shortlist_model.dart';
import 'shortlist_controller.dart';

class ShortlistScreen extends StatelessWidget {
  ShortlistScreen({super.key});

  final ShortlistController controller = Get.put(ShortlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 52, 18, 24),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Shortlist',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Profiles you saved',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${controller.shortlisted.length} saved',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ── Body (loading / error / list / empty) ────────
  Widget _buildBody() {
    return Obx(() {
      if (controller.isLoading.value && controller.shortlisted.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        );
      }

      if (controller.errorMessage.value.isNotEmpty && controller.shortlisted.isEmpty) {
        return _buildErrorState();
      }

      if (controller.shortlisted.isEmpty) {
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.onRefresh,
          child: ListView(
            children: const [
              SizedBox(height: 80),
              EmptyState(
                emoji: '🔖',
                title: 'No Saved Profiles',
                subtitle: 'Browse matches and tap 🔖 to save profiles',
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        color: AppColors.primary,
        onRefresh: controller.onRefresh,
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.shortlisted.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            // ✅ Each item is a Result directly — no more [0] indexing
            final member = controller.shortlisted[i];
            return _buildMemberCard(member);
          },
        ),
      );
    });
  }

  // ── Member card ──────────────────────────────────
  Widget _buildMemberCard(ShortListResultModel member) {
    return GestureDetector(
   //   onTap: () => controller.viewProfile(member),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            // ✅ Profile photo or initials
            member.hasPhoto
                ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                member.profilePhoto!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _initialsAvatar(member),
              ),
            )
                : _initialsAvatar(member),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Full name directly from Result
                  Text(
                    member.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // ✅ Age + DOB subtitle
                  Text(
                    _buildSubtitle(member),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                /*  if ((member!=null) ....[
                    const SizedBox(height: 5),
                    InfoTag(label: 'Gotra: ${member.gotra}'),
                  ],*/
                ],
              ),
            ),

            // Delete button
            GestureDetector(
              onTap: () => _confirmRemove(member),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  // ── Initials fallback avatar ─────────────────────
  Widget _initialsAvatar(ShortListResultModel member) {
    final initials = (member.fName?.isNotEmpty == true ? member.fName![0] : '?').toUpperCase();
    return ProfileAvatar(
      initials: initials,
      size: 56,
      borderRadius: 14,
    );
  }

  // ── Subtitle line ────────────────────────────────
  String _buildSubtitle(ShortListResultModel member) {
    final parts = <String>[];
    if ((member.age ?? 0) > 0) parts.add('${member.age} yrs');
    if ((member.manglik ?? '').isNotEmpty) parts.add('Manglik: ${member.manglik}');
    if ((member.dob ?? '').isNotEmpty) parts.add('DOB: ${member.dob}');
    return parts.join(' • ');
  }

  // ── Confirm remove dialog ────────────────────────
  void _confirmRemove(ShortListResultModel member) {
    Get.defaultDialog(
      title: 'Remove Shortlist',
      middleText: 'Remove ${member.fullName} from your shortlist?',
      textConfirm: 'Remove',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primary,
      onConfirm: () {
        Get.back();
        controller.removeShortlist(member);
      },
    );
  }

  // ── Error state ──────────────────────────────────
  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_outlined, size: 56, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: controller.fetchShortlist,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}