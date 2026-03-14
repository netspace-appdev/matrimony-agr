// lib/app/modules/login/presentation/auth_controller.dart
//
// ── CHANGES FROM ORIGINAL ─────────────────────────────────────────────────────
//  1. Added import for CommonController
//  2. onGotraChanged / onStateChanged / onCityChanged / getGotraRequest /
//     getStateRequest / getCityRequest → REMOVED (now in CommonController)
//  3. _register() reads gotraId, stateId, cityId from CommonController
//  4. _validateRegisterFields() reads dropdown values from CommonController
//  5. clearRegisterFields() calls common.resetDropdowns()
//  6. Everything else → UNCHANGED
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Api/services/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/storage_service.dart';
import '../../common/common_controller.dart';
import '../data/models/signInModel.dart';

class AuthController extends GetxController {

  // ── UI State ──────────────────────────────────────────────────────────────
  final isLoading       = false.obs;
  final isLogin         = true.obs;
  final obscurePass     = true.obs;
  final lookingFor      = 'Bride'.obs;
  final isTermCheck     = false.obs;
  final obscureConfirmPass = true.obs;

  // ── Field errors ──────────────────────────────────────────────────────────
  // Login
  final mobileError   = RxnString();
  final passwordError = RxnString();
  // Register
  final nameError             = RxnString();
  final lastNameError         = RxnString();
  final fatherError           = RxnString();
  final regMobileError        = RxnString();
  final regConfirmMobileError = RxnString();
  final regAddressError       = RxnString();
  final addressError          = RxnString();
  final confirmPassError      = RxnString();
  final termsError            = RxnString();
  // API banner
  final formError = RxnString();
  final firstNameError = RxnString();

  // ── Text controllers ──────────────────────────────────────────────────────
  final mobileController   = TextEditingController();
  final passwordController = TextEditingController();
  final userName           = TextEditingController();
  final userLastName       = TextEditingController();
  final userFather         = TextEditingController();
  final userMobile         = TextEditingController();
  final userConfirmMobile  = TextEditingController();
  final userAddress        = TextEditingController();
  final password           = TextEditingController();
  final confirmPassword    = TextEditingController();

  // ── Login response ────────────────────────────────────────────────────────
  var loginResponse = Rxn<SignInResponse>();

  final AuthService _authService = AuthService();

  // ── Convenience getter ────────────────────────────────────────────────────
  CommonController get common => Get.find<CommonController>();

  @override
  void onInit() {
    super.onInit();
    // CommonController (permanent) already loaded gotra + states in its onInit
    // Nothing to do here for dropdowns
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void toggleTab(bool value) {
    isLogin.value = value;
    _clearAllErrors();
  }

  void toggleObscure()        => obscurePass.value = !obscurePass.value;
  void toggleObscureConfirm() => obscureConfirmPass.value = !obscureConfirmPass.value;
  void setLookingFor(String v) => lookingFor.value = v;
  void toggleTerms()          => isTermCheck.value = !isTermCheck.value;

  // ── Submit dispatcher ─────────────────────────────────────────────────────
  void submit()   => _login();
  void register() => _register();

  // ── REGISTER ──────────────────────────────────────────────────────────────
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
        gotra:       common.gotraId,    // ← from CommonController
        fathername:  userFather.text.trim(),
        address:     userAddress.text.trim(),
        state:       common.stateId,   // ← from CommonController
        city:        common.cityId,    // ← from CommonController
        password:    password.text,
        date:        DateFormat('dd-MM-yyyy').format(DateTime.now()),
      );

      if (result.success) {
        toggleTab(true);
        StorageService.put(StorageService.USER_ID,
            result.data['matri_id']?.toString() ?? '');
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

  // ── LOGIN ─────────────────────────────────────────────────────────────────
  Future<void> _login() async {
    if (!_validateLoginFields()) return;

    isLoading.value = true;
    formError.value = null;

    try {
      final result = await _authService.signInApi(
        mobile:   mobileController.text.trim(),
        password: passwordController.text,
      );

      if (result.success && result.data != null) {
        loginResponse.value = SignInResponse.fromJson(result.data);

        if (loginResponse.value?.result == null) {
          formError.value = 'Invalid response from server';
          return;
        }

        final user = loginResponse.value!.result!.first;

        StorageService.put(StorageService.USER_ID,      user.mId?.toString()     ?? '');
        StorageService.put(StorageService.MATRI_ID,     user.matriId             ?? '');
        StorageService.put(StorageService.TOKEN,        user.token               ?? '');
        StorageService.put(StorageService.FIRST_NAME,   user.fName               ?? '');
        StorageService.put(StorageService.LAST_NAME,    user.lName               ?? '');
        StorageService.put(StorageService.GENDER,       user.gender              ?? '');
        StorageService.put(StorageService.MOBILE,       user.contact             ?? '');
        StorageService.put(StorageService.FATHER_NAME,  user.fatherName          ?? '');
        StorageService.put(StorageService.GOTRA,        user.gotra               ?? '');
        StorageService.put(StorageService.ADDRESS,      user.address             ?? '');
        StorageService.put(StorageService.STATE_ID,     user.stateId?.toString() ?? '');
        StorageService.put(StorageService.DIST_ID,      user.distId?.toString()  ?? '');
        StorageService.put(StorageService.PROFILE_PHOTO,user.profilePhoto        ?? '');
        StorageService.put(StorageService.MEMBER_TYPE,  user.memberType          ?? '');
        StorageService.put(StorageService.VISIT_COUNT,  user.visitCount?.toString() ?? '');

        print("✅ Login Saved → ID:${user.mId} | Name:${user.fName} ${user.lName}");

        Get.snackbar('Success', loginResponse.value?.message ?? 'Login Successful',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.red);

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

  // ── Clear register fields ─────────────────────────────────────────────────
  void clearRegisterFields() {
    userName.clear();
    userLastName.clear();
    userFather.clear();
    userMobile.clear();
    userConfirmMobile.clear();
    userAddress.clear();
    password.clear();
    confirmPassword.clear();
    isTermCheck.value = false;

    common.resetDropdowns();   // ← resets gotra/state/city in CommonController

    nameError.value             = null;
    lastNameError.value         = null;
    fatherError.value           = null;
    regMobileError.value        = null;
    regConfirmMobileError.value = null;
    regAddressError.value       = null;
    passwordError.value         = null;
    confirmPassError.value      = null;
    termsError.value            = null;
  }

  // ── Validation ────────────────────────────────────────────────────────────
  bool _validateLoginFields() {
    bool valid = true;
    final mobile = mobileController.text.trim();
    final pass   = passwordController.text;

    if (mobile.isEmpty) {
      mobileError.value = 'Mobile number is required';
      valid = false;
    } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(mobile)) {
      mobileError.value = 'Enter a valid 10-digit mobile number';
      valid = false;
    } else {
      mobileError.value = null;
    }

    if (pass.isEmpty) {
      passwordError.value = 'Password is required';
      valid = false;
    } else if (pass.length < 5) {
      passwordError.value = 'Password must be at least 5 characters';
      valid = false;
    } else {
      passwordError.value = null;
    }

    return valid;
  }

  bool _validateRegisterFields() {
    bool ok = true;

    if (userName.text.trim().isEmpty) {
      nameError.value = 'Full name is required';        ok = false;
    }
    if (userLastName.text.trim().isEmpty) {
      lastNameError.value = 'Last name is required';    ok = false;
    }
    if (userFather.text.trim().isEmpty) {
      fatherError.value = 'Father name is required';    ok = false;
    }
    if (userMobile.text.trim().isEmpty) {
      regMobileError.value = 'Mobile number is required'; ok = false;
    }
    if (userAddress.text.trim().isEmpty) {
      regAddressError.value = 'Address is required';    ok = false;
    }

    // ── Dropdown validation via CommonController ──────────────────
    if (common.gotraDropdownValue.value == 'Select Gotra') {
      common.gotraError.value = 'Please select your gotra'; ok = false;
    }
    if (common.stateDropdownValue.value == 'Select State') {
      common.stateError.value = 'Please select your state'; ok = false;
    }
    if (common.cityDropdownValue.value == 'Select City') {
      common.cityError.value = 'Please select your city';   ok = false;
    }

    if (password.text.isEmpty) {
      passwordError.value = 'Password is required';     ok = false;
    }
    if (!isTermCheck.value) {
      termsError.value = 'Please accept Terms & Conditions'; ok = false;
    }

    return ok;
  }

  void _clearAllErrors() {
    mobileError.value    = null;
    passwordError.value  = null;
    firstNameError.value = null;
    lastNameError.value  = null;
    formError.value      = null;
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    userName.dispose();
    userLastName.dispose();
    userFather.dispose();
    userMobile.dispose();
    userConfirmMobile.dispose();
    userAddress.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}