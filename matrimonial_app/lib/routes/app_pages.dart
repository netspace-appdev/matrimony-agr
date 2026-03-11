// lib/app/routes/app_pages.dart
import 'package:get/get.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
import '../modules/login/presentation/auth_screen.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/main_nav_screen.dart';
import '../modules/notice_board/notice_board_binding.dart';
import '../modules/notice_board/notice_board_screen.dart';
import '../modules/member_detail/member_detail_binding.dart';
import '../modules/member_detail/member_detail_screen.dart';
import '../modules/search/search_binding.dart';
import '../modules/search/search_screen.dart';
import '../modules/shortlist/shortlist_binding.dart';
import '../modules/shortlist/shortlist_screen.dart';
import '../modules/visitors/visitors_binding.dart';
import '../modules/visitors/visitors_screen.dart';
import '../modules/success_stories/success_stories_binding.dart';
import '../modules/success_stories/success_stories_screen.dart';
import '../modules/gallery/gallery_binding.dart';
import '../modules/gallery/gallery_screen.dart';
import '../modules/payment/payment_binding.dart';
import '../modules/payment/payment_screen.dart';
import '../modules/social_members/social_members_binding.dart';
import '../modules/social_members/social_members_screen.dart';
import '../modules/messages/messages_binding.dart';
import '../modules/messages/messages_screen.dart';
import '../modules/my_profile/my_profile_binding.dart';
import '../modules/my_profile/my_profile_screen.dart';
import '../modules/about/about_screen.dart';
import '../modules/terms/terms_screen.dart';
import '../modules/privacy/privacy_screen.dart';
import '../modules/contact/contact_binding.dart';
import '../modules/contact/contact_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () =>  SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () =>  AuthScreen(),
    //  binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.mainNav,
      page: () => const MainNavScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.noticeBoard,
      page: () => const NoticeBoardScreen(),
      binding: NoticeBoardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.memberDetail,
      page: () => const MemberDetailScreen(),
      binding: MemberDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () =>  SearchScreen(),
      binding: SearchBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.shortlist,
      page: () =>  ShortlistScreen(),
      binding: ShortlistBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.visitors,
      page: () => const VisitorsScreen(),
      binding: VisitorsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.successStories,
      page: () => const SuccessStoriesScreen(),
      binding: SuccessStoriesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.gallery,
      page: () => const GalleryScreen(),
      binding: GalleryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.socialMembers,
      page: () => const SocialMembersScreen(),
      binding: SocialMembersBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.messages,
      page: () =>  MessagesScreen(),
      binding: MessagesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.myProfile,
      page: () =>  MyProfileScreen(),
      binding: MyProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.terms,
      page: () => const TermsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.privacy,
      page: () => const PrivacyScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactScreen(),
      binding: ContactBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
