// lib/app/modules/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                ),
                child: const Center(child: Text('🪔', style: TextStyle(fontSize: 52))),
              ),
              const SizedBox(height: 28),
              const Text('Agraseva',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 42,
                      color: Colors.white,
                      letterSpacing: 1)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'AGRAWAL SAMAJ MATRIMONIAL',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 40),
              Container(width: 50, height: 2, color: Colors.white.withOpacity(0.35)),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Connecting Agrawal families with trust, tradition & technology',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white, height: 1.6),
                ),
              ),
              const SizedBox(height: 60),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
              const SizedBox(height: 16),
              const Text('www.agraseva.com',
                  style: TextStyle(color: Colors.white60, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
