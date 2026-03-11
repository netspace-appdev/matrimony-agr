

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../Api/services/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/storage_service.dart';
import '../data/models/city_list_model.dart';
import '../data/models/gotra_list_model.dart';
import '../data/models/signInModel.dart';
import '../data/models/state_list_model.dart';

class AuthController extends GetxController {
  // ─── Text Controllers ────────────────────────────────────────────────────



  // ─── UI State ────────────────────────────────────────────────────────────
  final isLoading  = false.obs;
  final isLogin    = true.obs;
  final obscurePass = true.obs;
  final lookingFor = 'Bride'.obs;
  RxBool isTermCheck = false.obs;



  // ─── Field Errors (shown inside TextField via errorText) ─────────────────

  // ─── Field errors ─────────────────────────────────────────────────────────
  // Login
  final mobileError   = RxnString();
  final passwordError = RxnString();
  // Register
  final nameError        = RxnString();
  final fatherError      = RxnString();
  final regMobileError   = RxnString();
  final regAddressError   = RxnString();
  final regConfirmMobileError   = RxnString();
  final gotraError       = RxnString();
  final addressError          = RxnString();
  final stateError       = RxnString();
  final cityError        = RxnString();
  final confirmPassError = RxnString();
  final termsError       = RxnString();
  // API / server banner
  final formError = RxnString();

  final firstNameError = RxnString();
  final lastNameError  = RxnString();

 // RxBool isLoading = false.obs;

  List<String> gotraList = [];
  List<String> stateList = [];
  List<String> cityList = [];

  List<dynamic> gotraListModel = [];
  List<dynamic> stateListModel = [];
  List<dynamic> cityListModel = [];

  String gotraId = "";
  String stateId = "";
  String cityId = "";

  final AuthService _authService = AuthService();

  TextEditingController userName = TextEditingController();
  TextEditingController userLastName = TextEditingController();
  TextEditingController userFather = TextEditingController();
  TextEditingController userMobile = TextEditingController();
  TextEditingController userConfirmMobile = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final mobileController    = TextEditingController();
  final passwordController  = TextEditingController();

  /// DROPDOWN VALUES

  RxString gotraDropdownValue = "Select Gotra".obs;
  RxString stateDropdownValue = "Select State".obs;
  RxString cityDropdownValue = "Select City".obs;
  RxString genderDropdownValue = "Male".obs;
  var loginResponse = Rxn<SignInResponse>();

  final obscureConfirmPass = true.obs;
  void toggleObscureConfirm() => obscureConfirmPass.value = !obscureConfirmPass.value;

  @override
  void onInit() {
    super.onInit();

    /// Default dropdown values
    gotraList.add("Select Gotra");
    stateList.add("Select State");
    cityList.add("Select City");
    getGotraRequest();
  }




  // ─── Helpers ─────────────────────────────────────────────────────────────
  void toggleTab(bool value) {
    isLogin.value = value;
    _clearAllErrors();
  }

  void toggleObscure() => obscurePass.value = !obscurePass.value;
  void setLookingFor(String value) => lookingFor.value = value;

  // ─── Submit dispatcher ───────────────────────────────────────────────────
  void submit() {
    if (isLogin.value) {
      _login();
    } else {
   //   _register();
    }
  }

  void register() {
   // if (registerFormKey.currentState!.validate()) {
      _register();
   // }
  }

  void onGotraChanged(String gotraName) {
    gotraDropdownValue.value = gotraName;
    gotraError.value         = null;
    final match = gotraListModel.firstWhereOrNull(
            (i) => i.gotra == gotraName);
    if (match != null) gotraId = match.gId?.toString() ?? '';
  }

  void onCityChanged(String cityName) {
    cityDropdownValue.value = cityName;
    cityError.value = null;

    final match = cityListModel.firstWhereOrNull(
          (i) => (i.district ?? '') == cityName,
    );

    if (match != null) {
      cityId = match.distId?.toString() ?? '';
    }
  }

  void toggleTerms() {
    isTermCheck.value = !isTermCheck.value;
  }

  Future<void> getGotraRequest() async {
    isLoading.value = true;

    final response = await AuthService.getGotra();

    if (response != null) {
      final jsonData = response.data;

      if (jsonData['response_code'] == 200) {

        var model = GotraListModel.fromJson(jsonData);

        gotraListModel = model.result!;

        gotraList.clear();
        gotraList.add("Select Gotra");

        for (var i in gotraListModel) {
          gotraList.add(i.gotra);
        }

        await getStateRequest();

      } else {
        Get.snackbar("Error", jsonData['message']);
      }
    }

    isLoading.value = false;
  }

  Future<void> getStateRequest() async {

    final response = await AuthService.getState();

    if (response != null) {
      final jsonData = response.data;

      if (jsonData['response_code'] == 200) {

        var model = StateListModel.fromJson(jsonData);

        stateListModel = model.result!;

        stateList.clear();
        stateList.add("Select State");

        for (var i in stateListModel) {
          stateList.add(i.state);
        }

      } else {
        Get.snackbar("Error", jsonData['message']);
      }
    }
  }

  Future<void> getCityRequest(String stateId) async {

    final response = await AuthService.getCity(stateId);

    if (response != null) {
      final jsonData = response.data;

      if (jsonData['response_code'] == 200) {

        var model = CityListModel.fromJson(jsonData);

        cityListModel = model.result!;

        cityList.clear();
        cityList.add("Select City");

        for (var i in cityListModel) {
          cityList.add(i.district);
        }

      } else {
        Get.snackbar("Error", jsonData['message']);
      }
    }
  }

  void onStateChanged(String stateName) {
    stateDropdownValue.value = stateName;
    stateError.value  = null;

    // Find matching ID from model
    final match = stateListModel.firstWhereOrNull(
            (i) => i.state == stateName);
    if (match != null) {
      stateId = match.stateId?.toString() ?? '';
      getCityRequest(stateId);
    }
  }

  // REGISTER  →  sends exact API keys
  // =========================================================================
  Future<void> _register() async {

    print("Register clicked");

    if (!_validateRegisterFields()) {
      print("Validation failed");
      return;
    }

    print("Validation success");

    isLoading.value = true;
    formError.value = null;

    try {
      final result = await AuthService.registerUser(
        name:        userName.text.trim(),
        lastname:    userLastName.text.trim(),
        mobileno:    userMobile.text.trim(),
        alternateno: userConfirmMobile.text.trim(),
        gender:      lookingFor.value == 'Bride' ? 'female' : 'male',
        gotra:       gotraId,
        fathername:  userFather.text.trim(),
        address:     userAddress.text.trim(),
        state:       stateId,
        city:        cityId,
        password:    password.text,
        date:       DateFormat('dd-MM-yyyy').format(DateTime.now()),   // format: d-MM-yyyy  e.g. 5-03-2016
      );

      if (result.success) {
        toggleTab(true);


        StorageService.put(StorageService.USER_ID, result.data['matri_id']?.toString() ?? "");
        //StorageService.put(StorageService., result.data['insert_id']?.toString() ?? "");
       // StorageService.put(StorageService.TOKEN, data['token']?.toString() ?? "");



        Get.snackbar('Account Created 🎉', result.message ?? 'Please sign in.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: Colors.green);
        clearRegisterFields();
      } else {
        formError.value = result.message;
      }
    } catch (e) {
      formError.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _login() async {
    if (!_validateLoginFields()) return;

    isLoading.value = true;
    formError.value = null;

    try {
      final result = await _authService.signInApi(
        mobile: mobileController.text.trim(),
        password: passwordController.text,
      );

      if (result.success && result.data != null) {

        /// Convert API response to model
        loginResponse.value  = SignInResponse.fromJson(result.data);

        if (loginResponse.value?.result == null) {
          formError.value = "Invalid response from server";
          return;
        }



        /// Save user data
        StorageService.put(StorageService.USER_ID, loginResponse.value?.result?.first.mId?.toString() ?? '');
        StorageService.put(StorageService.MATRI_ID, loginResponse.value?.result?.first.matriId ?? '');
        StorageService.put(StorageService.TOKEN, loginResponse.value?.result?.first.token ?? '');
        StorageService.put(StorageService.FIRST_NAME, loginResponse.value?.result?.first.fName ?? '');
        StorageService.put(StorageService.LAST_NAME, loginResponse.value?.result?.first.lName ?? '');
        StorageService.put(StorageService.GENDER, loginResponse.value?.result?.first.gender ?? '');
        StorageService.put(StorageService.MOBILE, loginResponse.value?.result?.first.contact ?? '');
        StorageService.put(StorageService.FATHER_NAME, loginResponse.value?.result?.first.fatherName ?? '');
        StorageService.put(StorageService.GOTRA, loginResponse.value?.result?.first.gotra ?? '');
        StorageService.put(StorageService.ADDRESS, loginResponse.value?.result?.first.address ?? '');
        StorageService.put(StorageService.STATE_ID, loginResponse.value?.result?.first.stateId?.toString() ?? '');
        StorageService.put(StorageService.DIST_ID, loginResponse.value?.result?.first.distId?.toString() ?? '');
        StorageService.put(StorageService.PROFILE_PHOTO, loginResponse.value?.result?.first.profilePhoto ?? '');
        StorageService.put(StorageService.MEMBER_TYPE, loginResponse.value?.result?.first.memberType ?? '');
        StorageService.put(StorageService.VISIT_COUNT, loginResponse.value?.result?.first.visitCount?.toString() ?? '');

        /// Debug log
        print(
            "✅ Login Saved → ID:${loginResponse.value?.result?.first.mId} | Name:${loginResponse.value?.result?.first.fName} ${loginResponse.value?.result?.first.lName}");
        String userId = StorageService.get(StorageService.USER_ID) ?? "";
        print('fhighfg${userId}');

        /// Success snackbar
        Get.snackbar(
          "Success",
          loginResponse.value?.message ?? "Login Successful",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.red,
        );

        /// Navigate to home
        Get.offAllNamed(AppRoutes.mainNav);

      } else {
        formError.value = result.message ?? "Login failed";
      }

    } catch (e) {
      formError.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }


/*
  Future<void> _login() async {
    if (!_validateLoginFields()) return;

    isLoading.value = true;
    formError.value = null;

    try {
      final result = await _authService.signInApi(
        mobile: mobileController.text.trim(),
        password: passwordController.text,
      );

      if (result.success && result.data != null) {
        final data = result.data as Map<String, dynamic>;

        // ── result is a List — get first item ──────────────────────────────
        final List<dynamic> resultList = data['result'] ?? [];
        if (resultList.isEmpty) {
          formError.value = 'Invalid response from server';
          return;
        }

        final Map<String, dynamic> user =
        Map<String, dynamic>.from(resultList[0]);

        // ── Save all fields to StorageService ──────────────────────────────
        StorageService.put(StorageService.USER_ID,     user['m_id']?.toString()        ?? '');
        StorageService.put(StorageService.MATRI_ID,    user['matri_id']?.toString()     ?? '');
        StorageService.put(StorageService.TOKEN,       user['token']?.toString()        ?? '');
        StorageService.put(StorageService.FIRST_NAME,  user['f_name']?.toString()       ?? '');
        StorageService.put(StorageService.LAST_NAME,   user['l_name']?.toString()       ?? '');
        StorageService.put(StorageService.GENDER,      user['gender']?.toString()       ?? '');
        StorageService.put(StorageService.MOBILE,      user['contact']?.toString()      ?? '');
        StorageService.put(StorageService.FATHER_NAME, user['father_name']?.toString()  ?? '');
        StorageService.put(StorageService.GOTRA,       user['gotra']?.toString()        ?? '');
        StorageService.put(StorageService.ADDRESS,     user['address']?.toString()      ?? '');
        StorageService.put(StorageService.STATE_ID,    user['state_id']?.toString()     ?? '');
        StorageService.put(StorageService.DIST_ID,     user['dist_id']?.toString()      ?? '');
        StorageService.put(StorageService.PROFILE_PHOTO, user['ProfilePhoto']?.toString() ?? '');
        StorageService.put(StorageService.MEMBER_TYPE, user['MemberType']?.toString()   ?? '');
        StorageService.put(StorageService.VISIT_COUNT, user['VisitCount']?.toString()   ?? '');

        // Debug log
        print('✅ Login saved — m_id: ${user['m_id']}, matri_id: ${user['matri_id']}, name: ${user['f_name']} ${user['l_name']}');

        Get.snackbar(
          "Success",
          result.message ?? "Login Successful",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.red,
        );

        Get.offAllNamed(AppRoutes.mainNav);

      } else {
        formError.value = result.message ?? 'Login failed';
      }

    } catch (e) {
      formError.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
*/

  void clearRegisterFields() {

    userName.clear();
    userLastName.clear();
    userFather.clear();
    userMobile.clear();
    userConfirmMobile.clear();
    userAddress.clear();

    password.clear();
    confirmPassword.clear();

    gotraDropdownValue.value = "Select Gotra";
    stateDropdownValue.value = "Select State";
    cityDropdownValue.value = "Select City";

    isTermCheck.value = false;

    // clear IDs
    gotraId = "";
    stateId = "";
    cityId = "";

    // clear errors
    nameError.value = null;
    lastNameError.value = null;
    fatherError.value = null;
    regMobileError.value = null;
    regConfirmMobileError.value = null;
    gotraError.value = null;
    addressError.value = null;
    stateError.value = null;
    cityError.value = null;
    passwordError.value = null;
    confirmPassError.value = null;
    termsError.value = null;
  }
  // ─── Validation ───────────────────────────────────────────────────────────
  bool _validateLoginFields() {
    bool valid = true;

    final mobile   = mobileController.text.trim();
    final password = passwordController.text;

    if (mobile.isEmpty) {
      mobileError.value = 'Mobile number is required';
      valid = false;
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(mobile)) {
      mobileError.value = 'Enter a valid 10-digit mobile number';
      valid = false;
    } else {
      mobileError.value = null;
    }

    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      valid = false;
    } else if (password.length < 5) {
      passwordError.value = 'Password must be at least 5 characters';
      valid = false;
    } else {
      passwordError.value = null;
    }

    return valid;
  }

  void _clearAllErrors() {
    mobileError.value    = null;
    passwordError.value  = null;
    firstNameError.value = null;
    lastNameError.value  = null;
    formError.value      = null;
  }

  // ─── Dispose ──────────────────────────────────────────────────────────────
  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  bool _validateRegisterFields() {
    bool ok = true;

    if (userName.text.trim().isEmpty) {
      print("Name failed");
      nameError.value = 'Full name is required';
      ok = false;
    }

    if (userLastName.text.trim().isEmpty) {
      print("Last name failed");
      lastNameError.value = 'Last name is required';
      ok = false;
    }

    if (userFather.text.trim().isEmpty) {
      print("Father name failed");
      fatherError.value = 'Father name is required';
      ok = false;
    }

    if (userMobile.text.trim().isEmpty) {
      print("Mobile failed");
      regMobileError.value = 'Mobile number is required';
      ok = false;
    }
    if (userAddress.text.trim().isEmpty) {

      regAddressError.value = 'Address is required';
      ok = false;
    }

    if (gotraDropdownValue.value == 'Select Gotra') {
      print("Gotra failed");
      gotraError.value = 'Please select your gotra';
      ok = false;
    }

    if (stateDropdownValue.value == 'Select State') {
      print("State failed");
      stateError.value = 'Please select your state';
      ok = false;
    }

    if (cityDropdownValue.value == 'Select City') {
      print("City failed");
      cityError.value = 'Please select your city';
      ok = false;
    }

    if (password.text.isEmpty) {
      print("Password failed");
      passwordError.value = 'Password is required';
      ok = false;
    }

    if (!isTermCheck.value) {
      print("Terms not checked");
      termsError.value = 'Please accept Terms & Conditions';
      ok = false;
    }

    return ok;
  }

  // ─── On success: save prefs & navigate ────────────────────────────────────
 /* Future<void> _onLoginSuccess(Result member) async {
    await FirebaseAnalytics.instance.setUserId(
      id: member.mId?.toString() ?? '',
    );

    await Future.wait([
      Constant.prefs!.setBool('loggedIn', true),
      Constant.prefs!.setString('ProfileID', member.mId ?? ''),
      Constant.prefs!.setString('contact', member.contact ?? ''),
      Constant.prefs!.setString('token', member.token ?? ''),
      Constant.prefs!.setString('name', '${member.fName} ${member.lName}'),
      Constant.prefs!.setString('gender', member.gender ?? ''),
      Constant.prefs!.setString('gotra', member.gotra ?? ''),
      Constant.prefs!.setString('userStatus', member.status ?? ''),
      Constant.prefs!.setString('memberType', member.memberType ?? ''),
    ]);

    Get.offAll(() => HomeScreen());
  }*/
}
