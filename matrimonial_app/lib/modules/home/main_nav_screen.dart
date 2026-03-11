// lib/app/modules/home/main_nav_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import 'home_controller.dart';
import 'home_screen.dart';
import '../search/search_screen.dart';
import '../shortlist/shortlist_screen.dart';
import '../messages/messages_screen.dart';
import '../my_profile/my_profile_screen.dart';

class MainNavScreen extends GetView<HomeController> {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
       HomeScreen(),
       SearchScreen(),
       ShortlistScreen(),
       MessagesScreen(),
       MyProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentNavIndex.value,
            children: screens,
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -4))
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                        icon: Icons.home_rounded,
                        label: 'Home',
                        index: 0,
                        current: controller.currentNavIndex.value,
                        onTap: controller.setNavIndex),
                    _NavItem(
                        icon: Icons.search_rounded,
                        label: 'Search',
                        index: 1,
                        current: controller.currentNavIndex.value,
                        onTap: controller.setNavIndex),
                    _NavItem(
                        icon: Icons.bookmark_rounded,
                        label: 'Shortlist',
                        index: 2,
                        current: controller.currentNavIndex.value,
                        onTap: controller.setNavIndex),
                    _NavItem(
                        icon: Icons.chat_bubble_rounded,
                        label: 'Who Visit',
                        index: 3,
                        current: controller.currentNavIndex.value,
                        onTap: controller.setNavIndex),
                    _NavItem(
                        icon: Icons.person_rounded,
                        label: 'Profile',
                        index: 4,
                        current: controller.currentNavIndex.value,
                        onTap: controller.setNavIndex),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final void Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          gradient: active ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: active ? Colors.white : AppColors.textMuted, size: 22),
            if (active) ...[
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}
