import 'package:agraseva/Api/services/master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'data/model/EducationResult.dart';
import 'data/model/MemberListModel.dart';
import 'data/model/heightListModel.dart';

/*
class SearchController extends GetxController {
  final ageMin = 21.0.obs;
  final ageMax = 32.0.obs;
  //final selectedEducation = 'Any Education'.obs;
  final selectedCity = 'Any'.obs;
  final results = <MemberListResultModel>[].obs;
  final hasSearched = false.obs;
  final searchController = TextEditingController();


  final manglik = ['yes' ,'no'];

  final cities = ['Any', 'Delhi', 'Mumbai', 'Jaipur', 'Indore', 'Bhopal', 'Ujjain'];

  final profileIdController = TextEditingController();
  final educationList          = <EducationResult>[].obs;
  final selectedEducation      = Rxn<EducationResult>();
  final isEducationLoading     = false.obs;
  final isManglik = Rxn<bool>();

  final selectedMaritalStatus = Rxn<String>();
  final maritalStatuses = <String>[
    'Never Married',
    'Divorced',
    'Widowed',
    'Awaiting Divorce',
  ];
  final heightList          = <HeightResult>[].obs;
  final selectedHeightFrom  = Rxn<HeightResult>();
  final selectedHeightTo    = Rxn<HeightResult>();
  final isHeightLoading     = false.obs;


  final isLoading   = false.obs;
  final errorMsg    = ''.obs;
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchEducationList(); // load on screen open
    _fetchHeightList();

  }

  Future<void> search() async {
    isLoading.value   = true;
    errorMsg.value    = '';
    hasSearched.value = true;

    final Map<String, dynamic> body = {
      'UserID'        : '',
      'gender'        : '',
      'gotra'         : '',
      'ProfileID'     : profileIdController.text.trim(),
      'occupation'    : '',
      'AgeFrom'       : ageMin.value.round().toString(),
      'AgeTo'         : ageMax.value.round().toString(),
      'MarriedStatus' : selectedMaritalStatus.value              ?? '',
      'Education'     : selectedEducation.value?.eId?.toString() ?? '',
      'ManglikStatus' : isManglik.value == null ? '' : (isManglik.value! ? 'Yes' : 'No'),
      'HeightFrom'    : selectedHeightFrom.value?.hId?.toString() ?? '',
      'HeightTo'      : selectedHeightTo.value?.hId?.toString()   ?? '',
    };

    try {
      final response = await MasterService.getMemberList(body);
      if (response.success && response.data != null) {
        final model = MemberListModel.fromJson(
            response.data as Map<String, dynamic>);

        print('✅ Member count: ${model.result?.length}');

        if (model.responseCode == 200 && model.result != null) {
          results.assignAll(model.result!);   // ✅ direct assign
        } else {
          results.clear();
          errorMsg.value = model.message ?? 'No results found';
        }
      } else {
        errorMsg.value = response.message ?? 'Something went wrong';
      }
    } catch (e, stack) {
      debugPrint('Search error: $e\n$stack');
      errorMsg.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }


  void reset() {
    searchController.clear();
    profileIdController.clear();
    ageMin.value                = 18;
    ageMax.value                = 35;
    ageMax.value       = 0;
    ageMin.value         = 0;
    selectedMaritalStatus.value = null;
    selectedEducation.value     = null;
    selectedHeightFrom.value    = null;
    selectedHeightTo.value      = null;
    isManglik.value             = null;
  //  selectedGotra.value         = null;
  //  selectedCity.value          = null;
    results.clear();
    hasSearched.value = false;
    errorMsg.value    = '';
  }

  Future<void> _fetchEducationList() async {
    isEducationLoading.value = true;
    try {
      final response = await MasterService.getEducation();

      print("🎓 response.success  : ${response.success}");
      print("🎓 response.data     : ${response.data}");
      print("🎓 response.data type: ${response.data?.runtimeType}");

      if (response.success && response.data != null) {
        // response.data is the Map<String,dynamic> passed from the service
        final model = EducationListModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        print("🎓 model.responseCode: ${model.responseCode}");
        print("🎓 model.result count: ${model.result?.length}");

        if (model.responseCode == 200 && model.result != null) {
          educationList.assignAll(model.result!);
        } else {
          print("⚠️ Unexpected responseCode: ${model.responseCode}");
        }
      } else {
        print("⚠️ API call failed or data is null");
      }
    } catch (e, stack) {
      debugPrint('❌ Education fetch error: $e');
      debugPrint('❌ Stack: $stack');
    } finally {
      isEducationLoading.value = false;
    }
  }
  // ── Fetch height list from API ───────────────────────────────────────────────
  Future<void> _fetchHeightList() async {
    isHeightLoading.value = true;
    try {
      final response = await MasterService.getHeight();
      if (response.success && response.data != null) {
        final model = HeightListModel.fromJson(
            response.data as Map<String, dynamic>);
        if (model.responseCode == 200 && model.result != null) {
          // Sort by h_id so the list is in natural height order
          final sorted = model.result!
            ..sort((a, b) => (a.hId ?? 0).compareTo(b.hId ?? 0));
          heightList.assignAll(sorted);
        }
      }
    } catch (e) {
      debugPrint('Height fetch error: $e');
    } finally {
      isHeightLoading.value = false;
    }
  }


  void viewProfile(MemberListResultModel m) => Get.toNamed(AppRoutes.memberDetail, arguments: m);
}
*/
import 'package:agraseva/Api/services/master_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import 'data/model/EducationResult.dart';
import 'data/model/MemberListModel.dart';
import 'data/model/heightListModel.dart';

class SearchController extends GetxController {
  // ── Filter state ──────────────────────────────────────────────────────────
  final ageMin = 18.0.obs;
  final ageMax = 35.0.obs;
  final selectedCity = 'Any'.obs;

  final manglik = ['yes', 'no'];
  final cities  = ['Any', 'Delhi', 'Mumbai', 'Jaipur', 'Indore', 'Bhopal', 'Ujjain'];

  final profileIdController = TextEditingController();
  final searchController    = TextEditingController();

  final educationList      = <EducationResult>[].obs;
  final selectedEducation  = Rxn<EducationResult>();
  final isEducationLoading = false.obs;

  final isManglik = Rxn<bool>();

  final selectedMaritalStatus = Rxn<String>();
  final maritalStatuses = <String>[
    'Never Married', 'Divorced', 'Widowed', 'Awaiting Divorce',
  ];

  final heightList         = <HeightResult>[].obs;
  final selectedHeightFrom = Rxn<HeightResult>();
  final selectedHeightTo   = Rxn<HeightResult>();
  final isHeightLoading    = false.obs;

  // ── Result state ──────────────────────────────────────────────────────────
  final results     = <MemberListResultModel>[].obs;
  final hasSearched = false.obs;
  final isLoading   = false.obs;
  final errorMsg    = ''.obs;

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    search();
    _fetchEducationList();
    _fetchHeightList();
  }

  @override
  void onClose() {
    searchController.dispose();
    profileIdController.dispose();
    super.onClose();
  }

  // ── Search ────────────────────────────────────────────────────────────────
  Future<void> search() async {
    isLoading.value   = true;
    errorMsg.value    = '';
    hasSearched.value = true;

    final String profileId = profileIdController.text.trim();
    final bool searchingById = profileId.isNotEmpty;

    try {
      final response = await MasterService.getMemberList(
        {},
        profileID:     profileId,
        // ✅ When searching by ProfileID, don't send age/other filters
        //    as the API returns empty when both are present
        ageFrom:       searchingById ? '' : ageMin.value.round().toString(),
        ageTo:         searchingById ? '' : ageMax.value.round().toString(),
        marriedStatus: searchingById ? '' : selectedMaritalStatus.value ?? '',
        education:     searchingById ? '' : selectedEducation.value?.eId?.toString() ?? '',
        manglikStatus: searchingById ? '' : (isManglik.value == null
            ? ''
            : (isManglik.value! ? 'Yes' : 'No')),
        heightFrom:    searchingById ? '' : selectedHeightFrom.value?.hId?.toString() ?? '',
        heightTo:      searchingById ? '' : selectedHeightTo.value?.hId?.toString()   ?? '',
      );

      if (response.success && response.data != null) {
        final model = MemberListModel.fromJson(
            response.data as Map<String, dynamic>);

        print('✅ Member count: ${model.result?.length}');

        if (model.responseCode == 200 && model.result != null) {
          results.assignAll(model.result!);
        } else {
          results.clear();
          errorMsg.value = model.message ?? 'No results found';
        }
      } else {
        results.clear();
        errorMsg.value = response.message ?? 'Something went wrong';
      }
    } catch (e, stack) {
      debugPrint('Search error: $e\n$stack');
      errorMsg.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
/*
  Future<void> search() async {
    isLoading.value   = true;
    errorMsg.value    = '';
    hasSearched.value = true;

    try {
      // ✅ Pass all filters as named params — service uses these to build the request body
      final response = await MasterService.getMemberList(
        {},
        profileID:     profileIdController.text.trim(),
        ageFrom:       ageMin.value.round().toString(),
        ageTo:         ageMax.value.round().toString(),
        marriedStatus: selectedMaritalStatus.value ?? '',
        education:     selectedEducation.value?.eId?.toString() ?? '',
        manglikStatus: isManglik.value == null
            ? ''
            : (isManglik.value! ? 'Yes' : 'No'),
        heightFrom:    selectedHeightFrom.value?.hId?.toString() ?? '',
        heightTo:      selectedHeightTo.value?.hId?.toString()   ?? '',
      );

      if (response.success && response.data != null) {
        final model = MemberListModel.fromJson(
            response.data as Map<String, dynamic>);

        print('✅ Member count: ${model.result?.length}');

        if (model.responseCode.toString() == '200' && model.result != null) {
          results.assignAll(model.result!);
        } else {
          results.clear();
          errorMsg.value = model.message ?? 'No results found';
        }
      } else {
        results.clear();
        errorMsg.value = response.message ?? 'Something went wrong';
      }
    } catch (e, stack) {
      debugPrint('Search error: $e\n$stack');
      errorMsg.value = 'Something went wrong. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
*/

  // ── Reset ─────────────────────────────────────────────────────────────────
  void reset() {
    searchController.clear();
    profileIdController.clear();
    ageMin.value                = 18;   // ✅ only set once, no 0 override
    ageMax.value                = 35;
    selectedMaritalStatus.value = null;
    selectedEducation.value     = null;
    selectedHeightFrom.value    = null;
    selectedHeightTo.value      = null;
    isManglik.value             = null;
    results.clear();
    hasSearched.value = false;
    errorMsg.value    = '';
  }

  // ── Navigate to profile ───────────────────────────────────────────────────
  void viewProfile(MemberListResultModel m) {
    Get.toNamed(
      AppRoutes.memberDetail,
      arguments: {'profileId': m.mId.toString(), 'myProfileId': '1'},
    );
  }

  // ── Education list ────────────────────────────────────────────────────────
  Future<void> _fetchEducationList() async {
    isEducationLoading.value = true;
    try {
      final response = await MasterService.getEducation();
      if (response.success && response.data != null) {
        final model = EducationListModel.fromJson(
            response.data as Map<String, dynamic>);
        if (model.responseCode == 200 && model.result != null) {
          educationList.assignAll(model.result!);
        }
      }
    } catch (e, stack) {
      debugPrint('❌ Education fetch error: $e\n$stack');
    } finally {
      isEducationLoading.value = false;
    }
  }

  // ── Height list ───────────────────────────────────────────────────────────
  Future<void> _fetchHeightList() async {
    isHeightLoading.value = true;
    try {
      final response = await MasterService.getHeight();
      if (response.success && response.data != null) {
        final model = HeightListModel.fromJson(
            response.data as Map<String, dynamic>);
        if (model.responseCode == 200 && model.result != null) {
          final sorted = model.result!
            ..sort((a, b) => (a.hId ?? 0).compareTo(b.hId ?? 0));
          heightList.assignAll(sorted);
        }
      }
    } catch (e) {
      debugPrint('Height fetch error: $e');
    } finally {
      isHeightLoading.value = false;
    }
  }
}