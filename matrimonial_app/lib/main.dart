  // lib/main.dart
import 'package:agraseva/modules/login/presentation/auth_controller.dart';
import 'package:agraseva/routes/app_pages.dart';
import 'package:agraseva/routes/app_routes.dart';
import 'package:agraseva/theme/app_theme.dart';
import 'package:agraseva/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'modules/common/common_controller.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await StorageService.init();

  runApp(const AgrasevaApp());
  Get.put(CommonController(), permanent: true);

}

class AgrasevaApp extends StatelessWidget {
  const AgrasevaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Agraseva',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,

      //  getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}
