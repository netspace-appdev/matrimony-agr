// lib/app/modules/shortlist/shortlist_controller.dart
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Api/services/shortlist_service.dart';
import '../../routes/app_routes.dart';
import 'data/model/shortlist_model.dart';

class ShortlistController extends GetxController {
  final _box = GetStorage();

  // ── State ──
  final shortlisted  = <ShortListResultModel>[].obs;
  final isLoading    = false.obs;
  final errorMessage = ''.obs;

  // Logged-in user's profile ID (stored after login)
  String get myProfileId => (_box.read('m_id') ?? '1').toString();

  // ──────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    fetchShortlist();
    onRefresh();
  }

  // ──────────────────────────────────────────────
  // Fetch shortlist from API
  // ──────────────────────────────────────────────
  Future<void> fetchShortlist() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ShortlistService.getMyShortlist(profileId: myProfileId);

      // ✅ Never force-unwrap — always use ?? [] fallback
      shortlisted.assignAll(response.data ?? []);

      print("✅ shortlisted count: ${shortlisted.length}");

    } catch (e) {
      print("❌ fetchShortlist error: $e");
      errorMessage(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading(false);
    }
  }
  // ──────────────────────────────────────────────
  // Remove from shortlist (optimistic UI + API)
  // ──────────────────────────────────────────────
  Future<void> removeShortlist(ShortListResultModel member) async {
    final index = shortlisted.indexOf(member);
    shortlisted.remove(member);

    try {
      final response = await ShortlistService.removeFromShortlist(
       // myProfileId: myProfileId,
        profileId:   member.mId?.toString() ?? '',
      );

      if (!response.success) {
        if (index >= 0) shortlisted.insert(index, member);
        Get.snackbar(
          'Error',
          'Failed to remove from shortlist. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      if (index >= 0) shortlisted.insert(index, member);
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ──────────────────────────────────────────────
  // Navigate to member detail
  // ──────────────────────────────────────────────
  void viewProfile(ShortListResultModel member) {
    Get.toNamed(AppRoutes.memberDetail, arguments: member);
  }

  // ──────────────────────────────────────────────
  // Pull-to-refresh
  // ──────────────────────────────────────────────
  Future<void> onRefresh() async => fetchShortlist();
}