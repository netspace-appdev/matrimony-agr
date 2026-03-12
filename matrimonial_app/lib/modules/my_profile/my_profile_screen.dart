// lib/app/modules/my_profile/my_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import '../../routes/app_routes.dart';
import 'my_profile_controller.dart';

class MyProfileScreen extends StatelessWidget  {
   MyProfileScreen({super.key});

  final controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
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
              padding: const EdgeInsets.fromLTRB(18, 52, 18, 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('My Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: Colors.white)),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.edit_outlined,
                                  color: Colors.white, size: 14),
                              SizedBox(width: 5),
                              Text('Edit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Avatar
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.5), width: 3),
                        ),
                        child: const Center(
                          child: Text('R',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      Positioned(
                        bottom: -8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6)
                            ],
                          ),
                          child: const Text('📷 Add Photo',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text('Rahul Agrawal',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  const Text("28 yrs • 5'10\" • Indore",
                      style: TextStyle(fontSize: 13, color: Colors.white70)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Text('✓ Verified Member',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
          ),

          // Profile completion
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05), blurRadius: 10)
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Profile Completion',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.textDark)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('72%',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const LinearProgressIndicator(
                      value: 0.72,
                      backgroundColor: AppColors.bgLight,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text('Add horoscope & photos to complete your profile',
                      style:
                          TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ),
          ),

          // My Activity section
       /*   SliverToBoxAdapter(
            child: _SectionLabel(label: 'My Activity'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MenuTile(
                    icon: Icons.bookmark_outlined,
                    title: 'My Shortlist',
                    subtitle: '2 profiles saved',
                    onTap: () => Get.toNamed(AppRoutes.shortlist)),
                MenuTile(
                    icon: Icons.remove_red_eye_outlined,
                    title: 'Who Visited My Profile',
                    subtitle: '48 profile views',
                    onTap: () => Get.toNamed(AppRoutes.visitors)),
                MenuTile(
                    icon: Icons.favorite_outline,
                    title: 'Interests Sent',
                    subtitle: 'Manage your interests',
                    onTap: () {}),
                MenuTile(
                    icon: Icons.chat_bubble_outline,
                    title: 'Messages',
                    subtitle: '3 unread messages',
                    onTap: () => Get.toNamed(AppRoutes.messages)),
              ],
            ),
          ),*/

          // Community
          SliverToBoxAdapter(child: _SectionLabel(label: 'Community')),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MenuTile(
                    icon: Icons.emoji_events_outlined,
                    title: 'Success Stories',
                    subtitle: 'Inspiring couple stories',
                    onTap: () => Get.toNamed(AppRoutes.successStories)),
                MenuTile(
                    icon: Icons.photo_library_outlined,
                    title: 'Gallery',
                    subtitle: 'Events & community photos',
                    onTap: () => Get.toNamed(AppRoutes.gallery)),
                MenuTile(
                    icon: Icons.star_outline,
                    title: 'Social Members',
                    subtitle: 'Respected members of Samaj',
                    onTap: () => Get.toNamed(AppRoutes.socialMembers)),
                MenuTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notice Board',
                    subtitle: 'Latest announcements',
                    onTap: () => Get.toNamed(AppRoutes.noticeBoard)),
              ],
            ),
          ),

          // Account & Support
          SliverToBoxAdapter(
              child: _SectionLabel(label: 'Account & Support')),
          SliverToBoxAdapter(
            child: Column(
              children: [
                MenuTile(
                    icon: Icons.credit_card_outlined,
                    title: 'Payment Information',
                    subtitle: 'Bank & UPI details',
                    iconBgColor: const Color(0xFFE8F5E9),
                    onTap: () => Get.toNamed(AppRoutes.payment)),
                MenuTile(
                    icon: Icons.info_outline,
                    title: 'About Agraseva',
                    subtitle: 'Our mission & team',
                    onTap: () => Get.toNamed(AppRoutes.about)),
                MenuTile(
                    icon: Icons.description_outlined,
                    title: 'Terms & Conditions',
                    subtitle: 'Usage terms & policies',
                    onTap: () => Get.toNamed(AppRoutes.terms)),
                MenuTile(
                    icon: Icons.lock_outline,
                    title: 'Privacy Policy',
                    subtitle: 'How we protect your data',
                    onTap: () => Get.toNamed(AppRoutes.privacy)),
                MenuTile(
                    icon: Icons.headset_mic_outlined,
                    title: 'Contact Us',
                    subtitle: 'Get help & support',
                    onTap: () => Get.toNamed(AppRoutes.contact)),
                MenuTile(
                    icon: Icons.star_outline,
                    title: 'Rate the App',
                    subtitle: 'Love Agraseva? Rate us!',
                    iconBgColor: const Color(0xFFFFF8E1),
                    onTap: () {}),
                MenuTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    titleColor: const Color(0xFFC0392B),
                    iconBgColor: const Color(0xFFFFEBEE),
                    onTap: controller.logout),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 6),
      child: Text(label,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 0.5)),
    );
  }
}
