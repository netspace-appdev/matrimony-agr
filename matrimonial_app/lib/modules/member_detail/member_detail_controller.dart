// lib/app/modules/member_detail/member_detail_controller.dart

import 'package:agraseva/Api/services/master_service.dart';
import 'package:agraseva/Api/services/shortlist_service.dart';
import 'package:get/get.dart';
import 'data/model/memberDetailModel.dart';

class MemberDetailController extends GetxController {

  // ── Observable state ──────────────────────────────────────────────────────
  final isLoading      = true.obs;
  final errorMessage   = ''.obs;
  final memberData     = Rx<MemberDetailModel?>(null);

  final tabIndex       = 0.obs;
  final isShortlisted  = false.obs;
  final interestedIds  = <int>{}.obs;   // tracks interest per member ID

  // ── Convenience getter ────────────────────────────────────────────────────
  MemberDetailModel? get member => memberData.value;
  final tabs = ['Personal', 'Career', 'Family', 'Religion','Photos'];
  // ── Load profile ──────────────────────────────────────────────────────────
  Future<void> loadMemberDetail({int? myProfileId}) async {
    isLoading.value    = true;
    errorMessage.value = '';

    print('📤 loadMemberDetail → myProfileId: $myProfileId');

    final response = await MasterService.fetchMemberDetail(
      myProfileId: myProfileId.toString(),
    );

    if (response.success && response.data != null) {
      memberData.value    = response.data;
      isShortlisted.value =
      (response.data!.isUserShortlisted?.toLowerCase() == 'yes');
    } else {
      errorMessage.value = response.message ?? 'Failed to load profile';
    }

    isLoading.value = false;
  }

  Future<void> refresh({int? myProfileId}) =>
      loadMemberDetail(myProfileId: myProfileId);

  // ── Tab ───────────────────────────────────────────────────────────────────
  void setTab(int index) => tabIndex.value = index;

  // ── Shortlist ─────────────────────────────────────────────────────────────
  void toggleShortlist() {
    isShortlisted.value = !isShortlisted.value;
    // TODO: call shortlist toggle API here
  }

  // ── Interest (per member ID) ──────────────────────────────────────────────
  bool isInterested(int? mId) => mId != null && interestedIds.contains(mId);

  Future<void> toggleInterest(int? mId) async {
    if (mId == null) return;

    final wasInterested = isInterested(mId);

    // Optimistic update — update UI immediately
    if (wasInterested) {
      interestedIds.remove(mId);
    } else {
      interestedIds.add(mId);
    }

    // Call API
    final response = await ShortlistService.addToShortlist(
      toProfileId: mId.toString(),
    );

    print('📥 addToShortlist response: ${response.message}');

    if (!response.success) {
      // Revert on failure
      if (wasInterested) {
        interestedIds.add(mId);
      } else {
        interestedIds.remove(mId);
      }
      Get.snackbar(
        'Error',
        response.message ?? 'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.surface,
      );
    }
  }
}