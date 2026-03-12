// lib/app/modules/notice_board/notice_board_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import 'data/model/notice_model.dart';
import 'data/model/news_model.dart';
import 'notice_board_controller.dart';
import 'news_detail_screen.dart';

class NoticeBoardScreen extends GetView<NoticeBoardController> {
  const NoticeBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: RefreshIndicator(
        onRefresh: controller.refreshAll,
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [

            // ── Header ──────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 52, 16, 24),
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
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Notice Board',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.white)),
                            Text('Latest news & announcements',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('LIVE',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800)),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Stay updated with latest notices & announcements',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Filter tabs ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: Obx(() => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  children: controller.filters.map((f) {
                    final sel = controller.selectedFilter.value == f;
                    return GestureDetector(
                      onTap: () => controller.setFilter(f),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: sel ? AppColors.primaryGradient : null,
                          color: sel ? null : Colors.white,
                          border: Border.all(
                              color: sel ? Colors.transparent : AppColors.border),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(f,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: sel ? Colors.white : AppColors.textMuted)),
                      ),
                    );
                  }).toList(),
                )),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 4)),

            // ── Body: switches based on selected tab ─────────────────────────
            Obx(() {
              final tab = controller.selectedFilter.value;

              // ── News tab ───────────────────────────────────────────────────
              if (tab == 'News') {
                if (controller.newsLoading.value) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
                  );
                }
                if (controller.newsError.value.isNotEmpty) {
                  return SliverFillRemaining(
                    child: _ErrorRetry(
                      message: controller.newsError.value,
                      onRetry: controller.fetchNews,
                    ),
                  );
                }
                if (controller.newsList.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No news found.',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) {
                      final news = controller.newsList[i];
                      return _NewsCard(
                        news: news,
                        imageUrl: controller.newsImageUrl(news.image),
                        onTap: () => Get.to(
                              () => NewsDetailScreen(news: news),
                          transition: Transition.rightToLeft,
                        ),
                      );
                    },
                    childCount: controller.newsList.length,
                  ),
                );
              }

              // ── Notice tabs (All / Events / Notice / Wedding) ──────────────
              if (controller.noticeLoading.value) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
                );
              }
              if (controller.noticeError.value.isNotEmpty) {
                return SliverFillRemaining(
                  child: _ErrorRetry(
                    message: controller.noticeError.value,
                    onRetry: controller.fetchNotices,
                  ),
                );
              }
              if (controller.filtered.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No notices found.',
                        style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, i) {
                    final notice = controller.filtered[i];
                    return _NoticeCard(
                      notice: notice,
                      emoji: controller.emojiFor(notice),
                    );
                  },
                  childCount: controller.filtered.length,
                ),
              );
            }),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Error + Retry
// ─────────────────────────────────────────────────────────────────────────────
class _ErrorRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Notice Card
// ─────────────────────────────────────────────────────────────────────────────
class _NoticeCard extends StatelessWidget {
  final NoticeResult notice;
  final String emoji;
  const _NoticeCard({required this.notice, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.06),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notice.title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: AppColors.textDark)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_outlined,
                              size: 11, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(notice.date ?? '',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (notice.image != null && notice.image!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.zero,
              child: Image.network(
                notice.image!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Text(notice.details ?? '',
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textDark, height: 1.6)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: navigate to notice detail with notice.noticeId
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Read More',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  News Card
// ─────────────────────────────────────────────────────────────────────────────
class _NewsCard extends StatelessWidget {
  final NewsResult news;
  final String imageUrl;
  final VoidCallback onTap;
  const _NewsCard({required this.news, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          /*  if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: AppColors.primary.withOpacity(0.07),
                    child: const Center(
                        child: Icon(Icons.image_not_supported_outlined,
                            color: AppColors.textMuted, size: 40)),
                  ),
                ),
              )
            else
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.07),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                ),
                child: const Center(
                    child: Icon(Icons.article_outlined,
                        color: AppColors.primary, size: 40)),
              ),*/
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Text(news.title ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppColors.textDark)),
            ),
            if (news.date != null && news.date!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 11, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(news.date!,
                        style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(news.details ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textMuted, height: 1.5)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Read More',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
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


