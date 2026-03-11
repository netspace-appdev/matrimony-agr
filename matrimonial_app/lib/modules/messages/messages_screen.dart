// lib/app/modules/messages/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'data/model/whoVisitListModel.dart';
import 'messages_controller.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  final controller = Get.put(MessagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Column(
        children: [

          // ── Header ─────────────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28)),
            ),
            padding: const EdgeInsets.fromLTRB(18, 52, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Who Visited Me',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Colors.white)),
                const SizedBox(height: 4),
                Obx(() {
                  final count = controller.visitors.length;
                  return Text(
                    count > 0 ? '$count people viewed your profile' : '',
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  );
                }),
                const SizedBox(height: 14),
                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white70, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: controller.setSearch,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Search by name, city...',
                            hintStyle: TextStyle(color: Colors.white54, fontSize: 13),
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Body ───────────────────────────────────────────────────────────
          Expanded(
            child: Obx(() {
              // Loading
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary));
              }

              // Error
              if (controller.errorMsg.value.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                        const SizedBox(height: 12),
                        Text(controller.errorMsg.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.textMuted)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                            onPressed: controller.refresh,
                            child: const Text('Retry')),
                      ],
                    ),
                  ),
                );
              }

              // Empty
              if (controller.filtered.isEmpty) {
                return const EmptyState(
                    emoji: '👀',
                    title: 'No Visitors Yet',
                    subtitle: 'People who view your profile will appear here');
              }

              // List
              return RefreshIndicator(
                onRefresh: controller.refresh,
                color: AppColors.primary,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    return _VisitorCard(visitor: controller.filtered[i]);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ── Visitor card ──────────────────────────────────────────────────────────────
class _VisitorCard extends StatelessWidget {
  final WhoVisitResult visitor;
  const _VisitorCard({required this.visitor});

  @override
  Widget build(BuildContext context) {
    final v = visitor;

    final sub = [
      if (v.age != null) '${v.age} yrs',
      if (v.cityName?.isNotEmpty == true) v.cityName!,
      if (v.businessName?.isNotEmpty == true) v.businessName!,
    ].join(' • ');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(
        children: [
          // ── Avatar ──────────────────────────────────────────────────────
          v.profilePhoto?.isNotEmpty == true
              ? CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(
              'https://yourdomain.com/uploads/${v.profilePhoto}', // ⚠️ update base URL
            ),
            onBackgroundImageError: (_, __) {},
            child: null,
          )
              : Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                v.displayInitials,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── Info ─────────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + member badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        v.fullName.isNotEmpty ? v.fullName : 'Unknown',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: AppColors.textDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (v.memberType?.isNotEmpty == true) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: v.memberType == 'Premier'
                              ? AppColors.primaryGradient
                              : null,
                          color: v.memberType == 'Premier' ? null : AppColors.bgLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          v.memberType == 'Premier' ? '★ Premier' : v.memberType!,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: v.memberType == 'Premier'
                                  ? Colors.white
                                  : AppColors.textMuted),
                        ),
                      ),
                    ],
                  ],
                ),
                // Sub info: age • city • business
                if (sub.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(sub,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
                const SizedBox(height: 5),
                // Tags: gotra, education, height, manglik
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    if (v.gotraName?.isNotEmpty == true)
                      InfoTag(label: 'Gotra: ${v.gotraName}'),
                    if (v.education?.isNotEmpty == true)
                      InfoTag(label: v.education!),
                    if (v.heightFormatted?.isNotEmpty == true)
                      InfoTag(label: v.heightFormatted!),
                    if (v.manglik?.isNotEmpty == true)
                      InfoTag(label: 'Manglik: ${v.manglik}'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}