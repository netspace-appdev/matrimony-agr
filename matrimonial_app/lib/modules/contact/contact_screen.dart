// lib/app/modules/contact/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'contact_controller.dart';

class ContactScreen extends GetView<ContactController> {
  const ContactScreen({super.key});

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
              padding: const EdgeInsets.fromLTRB(16, 52, 16, 28),
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
                      const Text('🎧 Contact Us',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3))),
                    child: const Row(
                      children: [
                        Text('🙏', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'We are here to help you. Reach out to us anytime!',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13),
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
                  // Contact cards
                  _ContactCard(
                    icon: '📞',
                    title: 'Call Us',
                    subtitle: '+91 97557 39106\n+91 79871 27780',
                    onTap: () => controller.callPhone('919755739106'),
                  ),
                  const SizedBox(height: 10),
                  _ContactCard(
                    icon: '📧',
                    title: 'Email Us',
                    subtitle: 'agraseva1@gmail.com',
                    onTap: () => controller.openEmail('agraseva1@gmail.com'),
                  ),
                  const SizedBox(height: 10),
                  _ContactCard(
                    icon: '📍',
                    title: 'Our Address',
                    subtitle: 'B-22/11, Ved Nagar,\nUjjain, MP - 456010',
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _ContactCard(
                    icon: '🌐',
                    title: 'Website',
                    subtitle: 'www.agraseva.com',
                    onTap: controller.openWebsite,
                  ),
                  const SizedBox(height: 14),

                  // WhatsApp
                  GestureDetector(
                    onTap: controller.openWhatsApp,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFF25D366).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle),
                            child: const Center(
                                child:
                                    Text('💬', style: TextStyle(fontSize: 22))),
                          ),
                          const SizedBox(width: 14),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chat on WhatsApp',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16)),
                              Text('+91 97557 39106',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Message form
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Send a Message',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: AppColors.textDark)),
                        const SizedBox(height: 16),
                        TextField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(
                            hintText: 'Your Name',
                            prefixIcon: Icon(Icons.person_outline,
                                color: AppColors.textMuted),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: controller.messageController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Your Message...',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 60),
                              child: Icon(Icons.message_outlined,
                                  color: AppColors.textMuted),
                            ),
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(() => controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primary))
                            : GradientButton(
                                text: 'Send Message 📤',
                                onTap: controller.sendMessage,
                              )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final String icon, title, subtitle;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.textDark)),
                  const SizedBox(height: 3),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          height: 1.4)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
