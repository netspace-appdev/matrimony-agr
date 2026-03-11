// lib/app/modules/payment/payment_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'payment_controller.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

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
                      const Text('💳 Payment Information',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3))),
                    child: const Row(
                      children: [
                        Text('ℹ️', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Make payment via bank transfer or UPI to activate your membership',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Plans
          SliverToBoxAdapter(
              child: SectionHeader(title: 'Choose Your Plan')),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130,
              child: Obx(() => ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    children: [
                      _PlanCard(
                          title: 'Silver',
                          price: '₹499',
                          duration: '1 Month',
                          features: '50 Contacts • Basic Search',
                          isSelected: controller.selectedPlan.value == 'Silver',
                          onTap: () => controller.selectPlan('Silver')),
                      _PlanCard(
                          title: 'Gold ⭐',
                          price: '₹999',
                          duration: '3 Months',
                          features: 'Unlimited • Advanced',
                          isSelected: controller.selectedPlan.value == 'Gold',
                          isPopular: true,
                          onTap: () => controller.selectPlan('Gold')),
                      _PlanCard(
                          title: 'Platinum',
                          price: '₹1499',
                          duration: '6 Months',
                          features: 'All Gold + Priority Listing',
                          isSelected: controller.selectedPlan.value == 'Platinum',
                          onTap: () => controller.selectPlan('Platinum')),
                    ],
                  )),
            ),
          ),

          // Bank Details
          SliverToBoxAdapter(
              child: SectionHeader(title: '🏦 Bank Account Details')),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12)
                ],
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF1A2F6E), Color(0xFF2563EB)]),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: Text('🏦',
                                  style: TextStyle(fontSize: 22))),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('State Bank of India',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15)),
                            Text('Agraseva Official Account',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _BankRow(
                            label: 'Account Name',
                            value: 'Agraseva Matrimonial Services',
                            onCopy: () => controller.copyToClipboard(
                                'Agraseva Matrimonial Services',
                                'Account Name')),
                        const _Divider(),
                        _BankRow(
                            label: 'Account Number',
                            value: 'XXXX XXXX XXXX 4521',
                            onCopy: () => controller.copyToClipboard(
                                'XXXX XXXX XXXX 4521',
                                'Account Number')),
                        const _Divider(),
                        _BankRow(
                            label: 'IFSC Code',
                            value: 'SBIN0007890',
                            onCopy: () => controller.copyToClipboard(
                                'SBIN0007890', 'IFSC Code')),
                        const _Divider(),
                        const _BankRow(
                            label: 'Branch',
                            value: 'Ujjain Main Branch'),
                        const _Divider(),
                        const _BankRow(
                            label: 'Account Type',
                            value: 'Current Account'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // UPI & QR
          SliverToBoxAdapter(
              child: SectionHeader(title: '📱 UPI / QR Code')),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12)
                ],
              ),
              child: Column(
                children: [
                  // QR Code placeholder
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: AppColors.border, width: 2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // QR pattern
                        GridView.builder(
                          physics:
                              const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                          itemCount: 81,
                          itemBuilder: (_, i) {
                            final filled = [
                              0, 1, 2, 3, 4, 5, 6, 9, 15, 18, 24, 27,
                              33, 36, 42, 45, 51, 54, 60, 63, 64, 65,
                              66, 67, 68, 69, 70, 20, 21, 22, 29, 30,
                              31, 47, 48, 49, 56, 57
                            ].contains(i);
                            return Container(
                              decoration: BoxDecoration(
                                color: filled
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            );
                          },
                        ),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text('🪔',
                                  style: TextStyle(fontSize: 20))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('Scan to Pay via any UPI App',
                      style: TextStyle(
                          fontSize: 13, color: AppColors.textMuted)),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => controller.copyToClipboard(
                        'agraseva@sbi', 'UPI ID'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.bgLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('UPI ID: ',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textMuted)),
                          const Text('agraseva@sbi',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                          const SizedBox(width: 10),
                          const Icon(Icons.copy,
                              size: 16, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    children: ['GPay', 'PhonePe', 'Paytm', 'BHIM']
                        .map((a) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.bgLight,
                                border:
                                    Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(a,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          // After payment note
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Text('After Payment',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.white)),
                  SizedBox(height: 8),
                  Text(
                    'Send payment screenshot on WhatsApp: +91 97557 39106 or email: agraseva1@gmail.com with your registered mobile number. Account activated within 24 hours.',
                    style: TextStyle(
                        color: Colors.white, fontSize: 12, height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title, price, duration, features;
  final bool isSelected, isPopular;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.duration,
    required this.features,
    required this.isSelected,
    required this.onTap,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: isSelected || isPopular
              ? AppColors.primaryGradient
              : null,
          color: isSelected || isPopular ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected ? Colors.transparent : AppColors.border),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('POPULAR',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800)),
              ),
            if (isPopular) const SizedBox(height: 4),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: isSelected || isPopular
                        ? Colors.white
                        : AppColors.textDark)),
            Text(price,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: isSelected || isPopular
                        ? Colors.white
                        : AppColors.primary)),
            Text(duration,
                style: TextStyle(
                    fontSize: 11,
                    color: isSelected || isPopular
                        ? Colors.white70
                        : AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}

class _BankRow extends StatelessWidget {
  final String label, value;
  final VoidCallback? onCopy;
  const _BankRow({required this.label, required this.value, this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textMuted))),
        Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark))),
        if (onCopy != null)
          GestureDetector(
            onTap: onCopy,
            child: const Icon(Icons.copy,
                size: 15, color: AppColors.primary),
          ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Divider(height: 1, color: AppColors.border),
      );
}
