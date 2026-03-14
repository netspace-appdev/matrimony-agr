// lib/app/modules/home/home_controller.dart

import 'package:agraseva/Api/services/dashboard_service.dart';
import 'package:get/get.dart';
import '../social_members/data/model/member_model.dart';
import 'data/model/dashboard_model.dart';

class HomeController extends GetxController {
  // ── Navigation ──────────────────────────────────────────────────
  final currentNavIndex = 0.obs;

  // ── Dashboard API state ─────────────────────────────────────────
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final dashboard = Rxn<DashboardModel>();

  // ── Social members (existing feature) ───────────────────────────
  //final members = <MemberModel>[].obs;

  @override
  void onInit() {
    super.onInit();
   // members.assignAll(SampleData.members);
    fetchDashboard();
  }

  // ── API call ─────────────────────────────────────────────────────
  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      print("🏠 Calling Dashboard API...");
      final response = await DashboardService.getDashboard();

      if (response.success && response.data != null) {
        dashboard.value = response.data;
        print("✅ Dashboard loaded: ${response.data!.result?.name}");
      } else {
        hasError.value = true;
        errorMessage.value = response.message ?? 'Failed to load dashboard';
        print("❌ Dashboard error: ${response.message}");
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Unexpected error: ${e.toString()}';
      print("❌ Dashboard exception: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ── Derived / convenience getters ─────────────────────────────────

  String get userName => dashboard.value?.result?.name ?? '';
  int get profileCompletion => dashboard.value?.result?.profileCompletion ?? 0;
  double get profileCompletionFraction => profileCompletion / 100.0;

  int get shortlistCount => dashboard.value?.result?.counts?.shortlist ?? 0;
  int get viewsCount     => dashboard.value?.result?.counts?.views ?? 0;
  int get viewsByMeCount => dashboard.value?.result?.counts?.viewsbyme ?? 0;

  /// Only active (status == 1) quick info items
  List<QuickInfo> get activeQuickInfo =>
      (dashboard.value?.result?.quickInfo ?? [])
          .where((q) => q.status == 1)
          .toList();

  /// All notification alerts
  List<NotificationAlert> get notificationAlerts =>
      dashboard.value?.result?.notificationAlert ?? [];

  /// Active notification alerts only (Status == 1)
  List<NotificationAlert> get activeAlerts =>
      notificationAlerts.where((a) => a.status == 1).toList();

  /// Suggested matches from API
  List<SuggestedMatches> get suggestedMatches =>
      dashboard.value?.result?.suggestedMatches ?? [];

  /// Notification content (HTML rich text)
  List<NotificationContent> get notificationContent =>
      dashboard.value?.result?.notificationContent ?? [];

  // ── Nav & member actions (unchanged) ─────────────────────────────
  void setNavIndex(int i) => currentNavIndex.value = i;

/*  void toggleShortlist(MemberModel m) {
    m.isShortlisted = !m.isShortlisted;
    members.refresh();
  }

  void toggleInterest(MemberModel m) {
    m.interestSent = !m.interestSent;
    members.refresh();
  }

  List<MemberModel> get shortlisted =>
      members.where((m) => m.isShortlisted).toList();*/
}