// lib/app/modules/member_detail/member_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Api/config/AppConfig.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'member_detail_controller.dart';
import 'data/model/memberDetailModel.dart';

class MemberDetailScreen extends GetView<MemberDetailController> {
  const MemberDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.bgLight,
      // ── Single top-level Obx — all data access is inside here ─────────────
      body: Obx(() {
        // ── Loading ──────────────────────────────────────────────────────────
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // ── Error ────────────────────────────────────────────────────────────
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: Colors.redAccent),
                  const SizedBox(height: 12),
                  Text(controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textMuted)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.refresh,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Null guard — safe to access m freely below this line ─────────────
        final MemberDetailModel? m = controller.member;
        if (m == null) return const SizedBox.shrink();

        // ── Derived display values ───────────────────────────────────────────
        final initials = [
          (m.fName?.isNotEmpty ?? false) ? m.fName![0] : '',
          (m.lName?.isNotEmpty ?? false) ? m.lName![0] : '',
        ].join();

        final subLine = [
          if (m.age != null) '${m.age} yrs',
          if (m.heightFormatted?.isNotEmpty == true) m.heightFormatted!,
          if (m.cityName?.isNotEmpty == true) m.cityName!,
        ].join(' • ');

        return CustomScrollView(
          slivers: [
            // ── App Bar ───────────────────────────────────────────────────────
            SliverAppBar(
              expandedHeight: 290,
              pinned: true,
              backgroundColor: AppColors.primary,
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 18),
                ),
              ),
              actions: [
                Obx(() => GestureDetector(
                  onTap: controller.toggleShortlist,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      controller.isShortlisted.value
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: Colors.white,
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(
                        right: 10, top: 8, bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.share_outlined,
                        color: Colors.white),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 44),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.45),
                                width: 3,
                              ),
                            ),
                          ),

                          /// If profile photo exists

                          ProfileAvatar(
                            initials: initials,
                            size: 80,
                            borderRadius: 50,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        m.fullName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(subLine,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white70)),
                      if (m.memberType?.isNotEmpty == true) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Text(
                            m.memberType == 'Premier'
                                ? '★ Premier Member'
                                : '✓ ${m.memberType}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // ── Action buttons ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10)
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => GestureDetector(
                        onTap: () => controller.toggleInterest(m.mId),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: controller.isInterested(m.mId)
                                ? AppColors.primaryGradient
                                : null,
                            border: Border.all(
                                color: controller.isInterested(m.mId)
                                    ? Colors.transparent
                                    : AppColors.border),
                            color: controller.isInterested(m.mId)
                                ? null
                                : AppColors.bgLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              controller.isInterested(m.mId)
                                  ? '❤️ Interested'
                                  : '🤍 Show Interest',
                              style: TextStyle(
                                  color: controller.isInterested(m.mId)
                                      ? Colors.white
                                      : AppColors.textDark,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(width: 10),
                    /*Expanded(
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.bgLight,
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text('💌 Message',
                              style: TextStyle(
                                  color: AppColors.textDark,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),*/
                    GestureDetector(
                      onTap: () async {
                        if (m.contact?.isNotEmpty == true) {

                          final number = m.contact!.replaceAll(RegExp(r'\s+'), '');

                          final Uri phoneUri = Uri.parse("tel:$number");

                          if (await canLaunchUrl(phoneUri)) {
                            await launchUrl(phoneUri);
                          } else {
                            Get.snackbar(
                              'Error',
                              'Dialer not available',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                            );
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.bgLight,
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('📞',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Tab bar ───────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14)),
                child: Obx(() => Row(
                  children: List.generate(controller.tabs.length, (i) {
                    final active = controller.tabIndex.value == i;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.setTab(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              vertical: 9),
                          decoration: BoxDecoration(
                            gradient: active
                                ? AppColors.primaryGradient
                                : null,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Center(
                            child: Text(controller.tabs[i],
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: active
                                        ? Colors.white
                                        : AppColors.textMuted)),
                          ),
                        ),
                      ),
                    );
                  }),
                )),
              ),
            ),

            // ── Tab content ───────────────────────────────────────────────────
            // m is already non-null here; pass it directly to avoid re-checking
            Obx(() {
              final items =
              _getTabItems(controller.tabIndex.value, m);
              return SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[i][0],
                            style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textMuted)),
                        const SizedBox(height: 2),
                        Text(
                          items[i][1].isEmpty ? '—' : items[i][1],
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
// ── Tab content ───────────────────────────────────────────────────────────
            Obx(() {
              final tabIdx = controller.tabIndex.value;

              // ── Photo tab ─────────────────────────────────────────────────────────
              if (tabIdx == 4) {
                final photos = m.profilePhotoList ?? [];
                return SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: photos.isEmpty
                        ? const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                        child: Text(
                          'No photos available',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      ),
                    )
                        : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1, // square cells
                      ),
                      itemCount: photos.length,
                      itemBuilder: (_, i) {
                        final url =
                            '${AppConfig.apiBaseUrl}${photos[i].profile ?? ''}';
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, progress) =>
                            progress == null
                                ? child
                                : const Center(
                                child: CircularProgressIndicator()),
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.bgLight,
                              child: const Icon(Icons.broken_image,
                                  color: AppColors.textMuted, size: 40),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }

              // ── All other tabs ─────────────────────────────────────────────────────
              final items = _getTabItems(tabIdx, m);
              return SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: items.length,
                    itemBuilder: (_, i) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[i][0].toString(),
                            style: const TextStyle(
                                fontSize: 10, color: AppColors.textMuted)),
                        const SizedBox(height: 2),
                        Text(
                          items[i][1].toString().isEmpty
                              ? '—'
                              : items[i][1].toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        );
      }),
    );
  }

  // ── Receives non-null m directly — zero nullable access inside ────────────
  List<List<String>> _getTabItems(int tab, MemberDetailModel m) {
    switch (tab) {
      case 0: // Personal
        return [
          ['Age',         '${m.age ?? '—'} yrs'],
          ['Height',      m.heightFormatted ?? '—'],
          ['City',        m.cityName        ?? '—'],
          ['State',       m.stateName       ?? '—'],
          ['Gotra',       m.gotraName       ?? '—'],
          ['Manglik',     m.manglik         ?? '—'],
          ['Complexion',  m.complexion      ?? '—'],
          ['Blood Group', m.bloodGroup      ?? '—'],
          ['DOB',         m.dob             ?? '—'],
        ];
      case 1: // Career
        return [
          ['Education',  m.education    ?? '—'],
          ['Profession', m.businessName ?? '—'],
          ['Income',     m.income       ?? '—'],
          ['City',       m.cityName     ?? '—'],
        ];
      case 2: // Family
        return [
          ["Father's Name",    m.fatherName      ?? '—'],
          ['Address',          m.address         ?? '—'],
          ['Pincode',          m.pincode         ?? '—'],
          ['Total Brothers',   m.brother         ?? '—'],
          ['Married Brothers', m.mbrother        ?? '—'],
          ['Total Sisters',    m.tsister         ?? '—'],
          ['Married Sisters',  m.msister         ?? '—'],
          ['Home Type',        m.homeType        ?? '—'],
          ["Father's Biz",     m.fahterBussiness ?? '—'],
        ];
      case 3: // Religion
        return [
          ['Gotra',     m.gotraName    ?? '—'],
          ['Rashi',     m.rashi        ?? '—'],
          ['Nakshatra', m.nakshatra    ?? '—'],
          ['Manglik',   m.manglik      ?? '—'],
          ['Marital',   m.maritialName ?? '—'],
        ];

      default:
        return [];
    }
  }
}