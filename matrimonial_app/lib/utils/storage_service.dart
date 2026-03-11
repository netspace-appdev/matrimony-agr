import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();


  static Future<void> init() async {
    await GetStorage.init();
  }
// ── Add these keys to your StorageService class ──────────────────────────────
  // existing keys (keep these)
  static const String USER_ID      = 'user_id';
  static const String TOKEN        = 'token';

  // ── new keys to add ────────────────────────────────────────────────────────
  static const String MATRI_ID     = 'matri_id';
  static const String FIRST_NAME   = 'first_name';
  static const String LAST_NAME    = 'last_name';
  static const String GENDER       = 'gender';
  static const String MOBILE       = 'mobile';
  static const String FATHER_NAME  = 'father_name';
  static const String GOTRA        = 'gotra';
  static const String ADDRESS      = 'address';
  static const String STATE_ID     = 'state_id';
  static const String DIST_ID      = 'dist_id';
  static const String PROFILE_PHOTO = 'profile_photo';
  static const String MEMBER_TYPE  = 'member_type';
  static const String VISIT_COUNT  = 'visit_count';

  // ── handy getters ──────────────────────────────────────────────────────────
  static String get myUserId      => get(USER_ID)       ?? '';
  static String get myMatriId     => get(MATRI_ID)      ?? '';
  static String get myToken       => get(TOKEN)         ?? '';
  static String get myFirstName   => get(FIRST_NAME)    ?? '';
  static String get myLastName    => get(LAST_NAME)     ?? '';
  static String get myFullName    => '${get(FIRST_NAME) ?? ''} ${get(LAST_NAME) ?? ''}'.trim();
  static String get myGender      => get(GENDER)        ?? '';
  static String get myMobile      => get(MOBILE)        ?? '';
  static String get myProfilePhoto => get(PROFILE_PHOTO) ?? '';
  static String get myMemberType  => get(MEMBER_TYPE)   ?? '';
  static bool   get isLoggedIn    => (get(TOKEN) ?? '').isNotEmpty;



  static void put(String key, String value) {
    _storage.write(key, value);
  }
  static String? get(String key) {
    return _storage.read(key);
  }
  static clear() {
    _storage.erase();

  }
  static void delete(String key) {
    _storage.remove(key);
  }

}
