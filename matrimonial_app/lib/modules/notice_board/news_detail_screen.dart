// lib/app/modules/news/news_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import 'data/model/news_model.dart';
import 'news_controller.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsResult news;
  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());
    final imgUrl     = controller.imageUrl(news.image);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: CustomScrollView(
        slivers: [
          // ── Hero image + back button ──────────────────────────────────
          SliverAppBar(
            expandedHeight: imgUrl.isNotEmpty ? 280 : 120,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: imgUrl.isNotEmpty
                  ? Image.network(
                imgUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primary.withOpacity(0.1),
                  child: const Center(
                      child: Icon(Icons.image_not_supported_outlined,
                          color: AppColors.textMuted, size: 48)),
                ),
              )
                  : Container(
                decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient),
              ),
            ),
            backgroundColor: AppColors.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 18),
                ),
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    news.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: AppColors.textDark,
                        height: 1.3),
                  ),

                  const SizedBox(height: 10),

                  // Meta row
                  Row(
                    children: [
                      if (news.date != null && news.date!.isNotEmpty) ...[
                        const Icon(Icons.calendar_today_outlined,
                            size: 13, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(news.date!,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 16),
                      ],
                      const Icon(Icons.access_time_outlined,
                          size: 13, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(
                        news.createdDate?.substring(0, 10) ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 16),

                  // Full details
                  Text(
                    news.details ?? '',
                    style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textDark,
                        height: 1.8),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}