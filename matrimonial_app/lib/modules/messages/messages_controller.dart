// lib/app/modules/messages/messages_controller.dart
import 'package:get/get.dart';
import '../../Api/services/messagesService.dart';
import 'data/model/whoVisitListModel.dart';


class MessagesController extends GetxController {
  // ── State ─────────────────────────────────────────────────────────────────
  final isLoading   = true.obs;
  final errorMsg    = ''.obs;
  final visitors    = <WhoVisitResult>[].obs;
  final searchQuery = ''.obs;

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    loadWhoVisitList();
  }

  // ── Filtered list ─────────────────────────────────────────────────────────
  List<WhoVisitResult> get filtered {
    if (searchQuery.value.isEmpty) return visitors;
    final q = searchQuery.value.toLowerCase();
    return visitors.where((v) =>
    v.fullName.toLowerCase().contains(q) ||
        (v.cityName?.toLowerCase().contains(q) == true) ||
        (v.education?.toLowerCase().contains(q) == true) ||
        (v.gotraName?.toLowerCase().contains(q) == true)
    ).toList();
  }

  void setSearch(String q) => searchQuery.value = q;

  // ── Load who visit list ───────────────────────────────────────────────────
  Future<void> loadWhoVisitList() async {
    isLoading.value = true;
    errorMsg.value  = '';

    final response = await MessagesService.getWhoVisitList();

    if (response.success && response.data != null) {
      visitors.assignAll(response.data!.result ?? []);
    } else {
      errorMsg.value = response.message ?? 'Failed to load visitors';
    }

    isLoading.value = false;
  }

  Future<void> refresh() => loadWhoVisitList();
}