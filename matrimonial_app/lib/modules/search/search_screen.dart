import 'package:agraseva/modules/search/search_controller.dart' as s;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../member_detail/member_detail_controller.dart';
import 'data/model/EducationResult.dart';
import 'data/model/heightListModel.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  final s.SearchController controller=Get.put(s.SearchController());

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
              padding: const EdgeInsets.fromLTRB(18, 52, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Find Your Match',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text('Filter by preferences',
                      style: TextStyle(fontSize: 13, color: Colors.white70)),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.white70, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: controller.searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,   // ← removes default border
                              focusedBorder: InputBorder.none,   // ← removes focus border
                              hintText: 'Search name, city, profession...',
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
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Age range

                  _FilterCard(
                    title: 'Profile ID',
                    child: _StyledTextField(
                      controller: controller.profileIdController,
                      hintText: 'Enter Profile ID',
                    ),
                  ),
                  const SizedBox(height: 12),

                  _FilterCard(
                    title: 'Age Range',
                    child: Obx(() => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${controller.ageMin.value.round()} yrs',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary)),
                            Text('${controller.ageMax.value.round()} yrs',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primary)),
                          ],
                        ),
                        RangeSlider(
                          values: RangeValues(
                            controller.ageMin.value.clamp(18, 50),  // ← clamp
                            controller.ageMax.value.clamp(18, 50),  // ← clamp
                          ),
                          min: 18,
                          max: 50,
                          divisions: 32,
                          activeColor: AppColors.primary,
                          inactiveColor: AppColors.border,
                          onChanged: (v) {
                            controller.ageMin.value = v.start;
                            controller.ageMax.value = v.end;
                          },
                        ),
                      ],
                    )),
                  ),
                  const SizedBox(height: 12),
                  // Height From / To
                  _FilterCard(
                    title: 'Height',
                    child: Obx(() {
                      final isLoading   = controller.isHeightLoading.value;
                      final heightList  = controller.heightList;
                      final fromVal     = controller.selectedHeightFrom.value;
                      final toVal       = controller.selectedHeightTo.value;

                      if (isLoading) {
                        return Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                              color: AppColors.bgLight,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary),
                              ),
                              SizedBox(width: 12),
                              Text('Loading heights...',
                                  style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 14)),
                            ],
                          ),
                        );
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: _HeightDropdown(
                              hint: 'Height From',
                              value: fromVal,
                              items: heightList,
                              onChanged: (v) =>
                              controller.selectedHeightFrom.value = v,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _HeightDropdown(
                              hint: 'Height To',
                              value: toVal,
                              items: heightList,
                              onChanged: (v) =>
                              controller.selectedHeightTo.value = v,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 12),



                  const SizedBox(height: 12),

                  // Education
                  _FilterCard(
                    title: 'Manglik',
                    child: Obx(() {
                      // Read observable at top — avoids improper GetX use error
                      final current = controller.isManglik.value; // null=Any, true=Yes, false=No

                      return SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 8,
                          children: controller.manglik.map((option) {
                            // Map string label → bool? for comparison
                            final bool? optionVal = option == 'Yes'
                                ? true
                                : option == 'No'
                                ? false
                                : null;

                            final sel = current == optionVal;

                            return GestureDetector(
                              onTap: () => controller.isManglik.value = optionVal,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  gradient: sel ? AppColors.primaryGradient : null,
                                  color: sel ? null : Colors.white,
                                  border: Border.all(
                                      color: sel
                                          ? Colors.transparent
                                          : AppColors.border),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  option,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: sel ? Colors.white : AppColors.textMuted),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ),



                  const SizedBox(height: 12),
                // Marital Status
                _FilterCard(
                  title: 'Marital Status',
                  child: Obx(() => _StyledDropdown<String>(
                    hint: 'Select Marital Status',
                    value:
                    controller.selectedMaritalStatus.value,
                    items: controller.maritalStatuses,
                    labelBuilder: (v) => v,
                    onChanged: (v) =>
                    controller.selectedMaritalStatus.value =
                        v,
                  )),
                ),

                const SizedBox(height: 12),

                // ── Education — API dropdown ──────────────────────────────
                  _FilterCard(
                    title: 'Education',
                    child: Obx(() {
                      final isLoading  = controller.isEducationLoading.value;
                      final eduList    = controller.educationList;
                      final selected   = controller.selectedEducation.value;

                      if (isLoading) {
                        return Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14),
                          decoration: BoxDecoration(
                              color: AppColors.bgLight,
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary),
                              ),
                              SizedBox(width: 12),
                              Text('Loading education...',
                                  style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 14)),
                            ],
                          ),
                        );
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.bgLight,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(12)),
                        child: DropdownButton<EducationResult>(
                          value: selected,
                          isExpanded: true,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.textMuted),
                          hint: const Text('Select Education',
                              style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 14)),
                          items: eduList
                              .map((edu) => DropdownMenuItem<EducationResult>(
                            value: edu,
                            child: Text(
                              edu.education ?? '',
                              style:
                              const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          onChanged: (v) =>
                          controller.selectedEducation.value = v,
                        ),
                      );
                    }),
                  ),
    // City

                  const SizedBox(height: 20),

                  GradientButton(
                    text: '🔍  Search Profiles',
                    onTap:(){
                      controller.search();


                    },
                    icon: null,
                  ),
                  const SizedBox(height: 10),
                  OutlineButton(text: 'Reset Filters', onTap: controller.reset),
                ],
              ),
            ),
          ),

          // Results
          Obx(() {
            if (!controller.hasSearched.value) return const SliverToBoxAdapter(child: SizedBox());
            if (controller.results.isEmpty) {
              return const SliverToBoxAdapter(
                child: EmptyState(
                    emoji: '🔍',
                    title: 'No Results Found',
                    subtitle: 'Try changing your filters'),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, i) {
                  final m = controller.results[i];
                  return GestureDetector(
                    onTap: () {
                    final   MemberDetailController  memberController = Get.put(MemberDetailController());
                    memberController.loadMemberDetail(
                      myProfileId: controller.results[i].mId,
                    );

                    Get.toNamed(AppRoutes.memberDetail);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8)
                        ],
                      ),
                      child: Row(
                        children: [
                          ProfileAvatar(
                              initials: getInitials(m.fName ?? '', m.lName ?? ''),
                              size: 54
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(m.fName.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                                Text(
                                    '${m.age} yrs • ${m.cityName.toString()} • ${m.dob}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMuted)),
                                const SizedBox(height: 4),
                                InfoTag(label: 'Gotra: ${m.gotra}'),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: AppColors.textMuted),
                        ],
                      ),
                    ),
                  );
                },
                childCount: controller.results.length,
              ),
            );
          }),
          // ── Results ─────────────────────────────────────────────────────────
         /* Obx(() {
            // Loading
            if (controller.isLoading.value) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primary)),
                ),
              );
            }

            if (!controller.hasSearched.value) {
              return const SliverToBoxAdapter(child: SizedBox());
            }

            // Error
            if (controller.errorMsg.value.isNotEmpty) {
              return SliverToBoxAdapter(
                child: EmptyState(
                    emoji: '⚠️',
                    title: 'Oops!',
                    subtitle: controller.errorMsg.value),
              );
            }

            // Empty
            if (controller.results.isEmpty) {
              return const SliverToBoxAdapter(
                child: EmptyState(
                    emoji: '🔍',
                    title: 'No Results Found',
                    subtitle: 'Try changing your filters'),
              );
            }

            // List
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, i) {
                  final m = controller.results[i]; // ✅ Result type

                  // Build initials from f_name + l_name
                  final initials = [
                    m.fName?.isNotEmpty == true
                        ? m.fName![0].toUpperCase()
                        : '',
                    m.lName?.isNotEmpty == true
                        ? m.lName![0].toUpperCase()
                        : '',
                  ].join();

                  // Full name
                  final name =
                  '${m.fName ?? ''} ${m.lName ?? ''}'.trim();

                  // Sub-info line
                  final sub = [
                    if (m.age != null) '${m.age} yrs',
                    if (m.cityName?.isNotEmpty == true) m.cityName!,
                    if (m.businessName?.isNotEmpty == true)
                      m.businessName!,
                  ].join(' • ');

                  return GestureDetector(
                    onTap: () => controller.viewProfile(m),
                    child: Container(
                      margin:
                      const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8)
                        ],
                      ),
                      child: Row(
                        children: [
                          // Avatar with photo or initials
                          m.profilePhoto?.isNotEmpty == true
                              ? CircleAvatar(
                            radius: 27,
                            backgroundImage: NetworkImage(
                                m.profilePhoto!),
                          )
                              : ProfileAvatar(
                              initials: initials, size: 54),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15)),
                                if (sub.isNotEmpty)
                                  Text(sub,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textMuted)),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 4,
                                  children: [
                                    if (m.gotra?.isNotEmpty == true)
                                      InfoTag(
                                          label: 'Gotra: ${m.gotra}'),
                                    if (m.education?.isNotEmpty ==
                                        true)
                                      InfoTag(label: m.education!),
                                    if (m.manglik?.isNotEmpty == true)
                                      InfoTag(
                                          label:
                                          'Manglik: ${m.manglik}'),
                                    if (m.memberType?.isNotEmpty ==
                                        true)
                                      InfoTag(label: m.memberType!),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: AppColors.textMuted),
                        ],
                      ),
                    ),
                  );
                },
                childCount: controller.results.length,
              ),
            );
          }),*/
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

   String getInitials(String firstName, String lastName) {
     return "${firstName.isNotEmpty ? firstName[0] : ''}"
         "${lastName.isNotEmpty ? lastName[0] : ''}".toUpperCase();
   }
}

class _StyledDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final String Function(T) labelBuilder;
  final ValueChanged<T?> onChanged;

  const _StyledDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
          color: AppColors.bgLight,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12)),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,
            color: AppColors.textMuted),
        hint: Text(hint,
            style: const TextStyle(
                color: AppColors.textMuted, fontSize: 14)),
        items: items
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(labelBuilder(item),
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _FilterCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.textMuted)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const _StyledTextField(
      {required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: AppColors.textDark),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
          const TextStyle(color: AppColors.textMuted, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        ),
      ),
    );
  }
}

class _HeightDropdown extends StatelessWidget {
  final String hint;
  final HeightResult? value;
  final List<HeightResult> items;
  final ValueChanged<HeightResult?> onChanged;

  const _HeightDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
          color: AppColors.bgLight,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12)),
      child: DropdownButton<HeightResult>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down,
            color: AppColors.textMuted),
        hint: Text(hint,
            style: const TextStyle(
                color: AppColors.textMuted, fontSize: 14)),
        items: items
            .map((h) => DropdownMenuItem<HeightResult>(
          value: h,
          child: Text(
            h.height ?? '',
            style: const TextStyle(fontSize: 14),
          ),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
