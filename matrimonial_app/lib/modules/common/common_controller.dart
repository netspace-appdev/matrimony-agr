// lib/app/common/common_controller.dart
//
// ── SETUP (once in main.dart or app_binding.dart) ─────────────────────────────
//
//   Get.put(CommonController(), permanent: true);
//
// ── USE anywhere ──────────────────────────────────────────────────────────────
//
//   final c = Get.find<CommonController>();
//
//   // dropdown lists  (bind with Obx)
//   c.gotraList   c.stateList   c.cityList
//
//   // selected display values
//   c.gotraDropdownValue   c.stateDropdownValue   c.cityDropdownValue
//
//   // selected IDs  ← send these to save APIs
//   c.gotraId   c.stateId   c.cityId
//
//   // callbacks  ← pass to onChanged
//   c.onGotraChanged(val!)
//   c.onStateChanged(val!)   // auto-loads cities
//   c.onCityChanged(val!)
//
//   // validation errors  ← pass to errorText
//   c.gotraError   c.stateError   c.cityError
//
// ─────────────────────────────────────────────────────────────────────────────

import 'package:agraseva/modules/login/data/models/gotra_list_model.dart';
import 'package:agraseva/modules/login/data/models/state_list_model.dart';
import 'package:get/get.dart';

import '../../Api/services/auth_service.dart';
import '../login/data/models/city_list_model.dart';

class CommonController extends GetxController {

  // ══════════════════════════════════════════════════════════════════
  //  LOADING FLAGS
  // ══════════════════════════════════════════════════════════════════
  final isGotraLoading = false.obs;
  final isStateLoading = false.obs;
  final isCityLoading  = false.obs;

  // ══════════════════════════════════════════════════════════════════
  //  RAW MODEL LISTS  — exact types from your existing models
  // ══════════════════════════════════════════════════════════════════
  List<GotraResult> gotraListModel = [];
  List<StateResult> stateListModel = [];
  List<CityResult> cityListModel  = [];

  // ══════════════════════════════════════════════════════════════════
  //  DISPLAY LISTS  — shown in dropdown UI
  // ══════════════════════════════════════════════════════════════════
  RxList<String> gotraList = <String>['Select Gotra'].obs;
  RxList<String> stateList = <String>['Select State'].obs;
  RxList<String> cityList  = <String>['Select City'].obs;

  // ══════════════════════════════════════════════════════════════════
  //  SELECTED DISPLAY VALUES
  // ══════════════════════════════════════════════════════════════════
  RxString gotraDropdownValue = 'Select Gotra'.obs;
  RxString stateDropdownValue = 'Select State'.obs;
  RxString cityDropdownValue  = 'Select City'.obs;

  // ══════════════════════════════════════════════════════════════════
  //  SELECTED IDs  ← use these in every save API call
  // ══════════════════════════════════════════════════════════════════
  String gotraId = '';
  String stateId = '';
  String cityId  = '';

  // ══════════════════════════════════════════════════════════════════
  //  VALIDATION ERRORS  ← bind to errorText in _DropdownField
  // ══════════════════════════════════════════════════════════════════
  final gotraError = RxnString();
  final stateError = RxnString();
  final cityError  = RxnString();

  // ══════════════════════════════════════════════════════════════════
  //  INIT
  // ══════════════════════════════════════════════════════════════════
  @override
  void onInit() {
    super.onInit();
    _fetchGotra();   // gotra → then state → chained
  }

  // ══════════════════════════════════════════════════════════════════
  //  GOTRA API   →  AuthService.getGotra()
  // ══════════════════════════════════════════════════════════════════
  Future<void> _fetchGotra() async {
    try {
      isGotraLoading.value = true;
      print("📤 [CommonController] GOTRA API");

      final response  = await AuthService.getGotra();
      final jsonData  = response.data;

      print("📥 GOTRA: $jsonData");

      if (jsonData['response_code'] == 200) {
        final model = GotraListModel.fromJson(jsonData);
        gotraListModel = model.result ?? [];

        gotraList.assignAll([
          'Select Gotra',
          ...gotraListModel.map((i) => i.gotra ?? '').where((s) => s.isNotEmpty),
        ]);

        print("✅ Gotra loaded: ${gotraListModel.length}");
        print("📋 ${gotraListModel.map((i) => '${i.gotra}(${i.gId})').toList()}");

        // Chain: load states after gotra
        await _fetchStates();

      } else {
        print("❌ Gotra error: ${jsonData['message']}");
      }
    } catch (e) {
      print("❌ Gotra exception: $e");
    } finally {
      isGotraLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════════════
  //  STATE API   →  AuthService.getState()
  // ══════════════════════════════════════════════════════════════════
  Future<void> _fetchStates() async {
    try {
      isStateLoading.value = true;
      print("📤 [CommonController] STATE API");

      final response = await AuthService.getState();
      final jsonData = response.data;

      print("📥 STATE: $jsonData");

      if (jsonData['response_code'] == 200) {
        final model = StateListModel.fromJson(jsonData);
        stateListModel = model.result ?? [];

        stateList.assignAll([
          'Select State',
          ...stateListModel.map((i) => i.state ?? '').where((s) => s.isNotEmpty),
        ]);

        print("✅ States loaded: ${stateListModel.length}");
        print("📋 ${stateListModel.map((i) => '${i.state}(${i.stateId})').toList()}");

      } else {
        print("❌ State error: ${jsonData['message']}");
      }
    } catch (e) {
      print("❌ State exception: $e");
    } finally {
      isStateLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════════════
  //  CITY API   →  AuthService.getCity(stateId)
  //  Called automatically when state is selected
  // ══════════════════════════════════════════════════════════════════
  Future<void> fetchCities(String stateIdValue) async {
    try {
      isCityLoading.value = true;

      // Reset city before loading
      cityListModel = [];
      cityList.assignAll(['Select City']);
      cityDropdownValue.value = 'Select City';
      cityId = '';

      print("📤 [CommonController] CITY API  |  StateID: $stateIdValue");

      final response = await AuthService.getCity(stateIdValue);
      if (response == null) return;

      final jsonData = response.data;

      print("📥 CITY: $jsonData");

      if (jsonData['response_code'] == 200) {
        final model = CityListModel.fromJson(jsonData);
        cityListModel = model.result ?? [];

        cityList.assignAll([
          'Select City',
          ...cityListModel.map((i) => i.district ?? '').where((s) => s.isNotEmpty),
        ]);

        print("✅ Cities loaded: ${cityListModel.length}");
        print("📋 ${cityListModel.map((i) => '${i.district}(${i.distId})').toList()}");

      } else {
        print("❌ City error: ${jsonData['message']}");
      }
    } catch (e) {
      print("❌ City exception: $e");
    } finally {
      isCityLoading.value = false;
    }
  }

  // ══════════════════════════════════════════════════════════════════
  //  SELECTION CALLBACKS
  //  Same logic as AuthController — but now shared
  // ══════════════════════════════════════════════════════════════════

  void onGotraChanged(String gotraName) {
    gotraDropdownValue.value = gotraName;
    gotraError.value         = null;

    // ✅ look up gId from gotraListModel
    final match = gotraListModel.firstWhereOrNull((i) => i.gotra == gotraName);
    if (match != null) {
      gotraId = match.gId?.toString() ?? '';
      print("✅ Gotra → name: $gotraName  |  id: $gotraId");
    }
  }

  void onStateChanged(String stateName) {
    stateDropdownValue.value = stateName;
    stateError.value         = null;

    // ✅ look up stateId from stateListModel
    final match = stateListModel.firstWhereOrNull((i) => i.state == stateName);
    if (match != null) {
      stateId = match.stateId?.toString() ?? '';
      print("✅ State → name: $stateName  |  id: $stateId");
      fetchCities(stateId);   // ✅ auto-load cities
    }
  }

  void onCityChanged(String cityName) {
    cityDropdownValue.value = cityName;
    cityError.value         = null;

    // ✅ look up distId from cityListModel
    final match = cityListModel.firstWhereOrNull((i) => i.district == cityName);
    if (match != null) {
      cityId = match.distId?.toString() ?? '';
      print("✅ City → name: $cityName  |  id: $cityId");
    }
  }

  // ══════════════════════════════════════════════════════════════════
  //  VALIDATION  — call before any save API
  // ══════════════════════════════════════════════════════════════════
  bool validateGotra() {
    if (gotraId.isEmpty) { gotraError.value = 'Please select your gotra'; return false; }
    gotraError.value = null;
    return true;
  }

  bool validateState() {
    if (stateId.isEmpty) { stateError.value = 'Please select your state'; return false; }
    stateError.value = null;
    return true;
  }

  bool validateCity() {
    if (cityId.isEmpty) { cityError.value = 'Please select your city'; return false; }
    cityError.value = null;
    return true;
  }

  // ══════════════════════════════════════════════════════════════════
  //  RESET  — call after form submit
  // ══════════════════════════════════════════════════════════════════
  void resetDropdowns() {
    gotraDropdownValue.value = 'Select Gotra';
    stateDropdownValue.value = 'Select State';
    cityDropdownValue.value  = 'Select City';
    gotraId = '';
    stateId = '';
    cityId  = '';
    gotraError.value = null;
    stateError.value = null;
    cityError.value  = null;
    cityListModel    = [];
    cityList.assignAll(['Select City']);
  }
}
