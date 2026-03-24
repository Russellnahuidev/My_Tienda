import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_tienda/services/firebase_auth_service.dart';
import 'package:my_tienda/services/firestore_services.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = true.obs;
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoading = false.obs;
  final Rx<Map<String, dynamic>?> _userDcoment = Rx<Map<String, dynamic>?>(
    null,
  );

  bool get isfirsTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;
  User? get user => _user.value;
  bool get isLoading => _isLoading.value;
  String? get userEmail => _user.value?.email;
  String? get userDisplayName => _user.value?.displayName;
  Map<String, dynamic>? get userDocument => _userDcoment.value;
  String? get userName =>
      _userDcoment.value?['name'] ?? _user.value?.displayName;
  String? get userPhone => _userDcoment.value?['phoneNumber'];
  List<dynamic> get userAddresses => _userDcoment.value?['addresses'];
  Map<String, dynamic>? get userPreferences =>
      _userDcoment.value?['preferences'];

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
    _listenToAuthChanges();
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    //check Firebase aut state instead of local storage
    _user.value = FirebaseAuthService.currentUser;
    _isLoggedIn.value = FirebaseAuthService.isSignedIn;

    //Load user document if user is already signed in
    if (_user.value != null) {
      _loadUserDocument(_user.value!.uid);
    }
  }

  //Load user document from Firestore
  Future<void> _loadUserDocument(String uid) async {
    try {
      final userDoc = await FirestoreServices.getUserDocument(uid);
      _userDcoment.value = userDoc;
    } catch (e) {
      print('Error Loading user document: $e');
    }
  }

  void _listenToAuthChanges() {
    FirebaseAuthService.authStateCchanges.listen((User? user) {
      _user.value = user;
      _isLoggedIn.value = user != null;

      if (user != null) {
        //Load user document from Firestore
        _loadUserDocument(user.uid);
      } else {
        //Clear user document when signed out
        _userDcoment.value = null;
      }
    });
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  //Sign up with email and password
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    _isLoading.value = true;
    try {
      final result = await FirebaseAuthService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );

      //If sign-up is successful, load user document immediately
      if (result.succes && result.user != null) {
        //Add a small delay to ensure Firestore document is fully created
        await Future.delayed(Duration(milliseconds: 500));
        await _loadUserDocument(result.user!.uid);
      }
      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  //Sign in with email and password
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading.value = true;
    try {
      final result = await FirebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //If sign-up is successful, load user document immediately
      if (result.succes && result.user != null) {
        //Add a small delay to ensure Firestore document is fully created
        await _loadUserDocument(result.user!.uid);
      }
      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  //Send password reset email
  Future<AuthResult> sendPasswordResetEmail({required String email}) async {
    _isLoading.value = true;
    try {
      final result = await FirebaseAuthService.sendPasswordResetEmail(
        email: email,
      );

      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  //Sign out
  Future<AuthResult> signOut() async {
    _isLoading.value = true;
    try {
      final result = await FirebaseAuthService.signOut();

      return result;
    } finally {
      _isLoading.value = false;
    }
  }

  //upadate user profile in Firestore
  Future<bool> updateUserProfile({
    String? name,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? profileImageUrl,
  }) async {
    if (_user.value == null) return false;

    _isLoading.value = true;
    try {
      final success = await FirestoreServices.updateUserProfile(
        uid: _user.value!.uid,
        name: name,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
        profileImageUrl: profileImageUrl,
      );

      if (success) {
        //Reload user document to get update data
        await _loadUserDocument(_user.value!.uid);
      }

      return success;
    } finally {
      _isLoading.value = false;
    }
  }

  //Add User Address
  Future<bool> addUserAddress(Map<String, dynamic> address) async {
    if (_user.value == null) return false;

    _isLoading.value = true;
    try {
      final success = await FirestoreServices.addUserAddress(
        uid: _user.value!.uid,
        address: address,
      );

      if (success) {
        //Reload user document to get update data
        await _loadUserDocument(_user.value!.uid);
      }

      return success;
    } finally {
      _isLoading.value = false;
    }
  }

  //Update user preferences
  Future<bool> updateUserPreferences(Map<String, dynamic> preferences) async {
    if (_user.value == null) return false;

    _isLoading.value = true;
    try {
      final success = await FirestoreServices.updateUserPreferences(
        uid: _user.value!.uid,
        preferences: preferences,
      );

      if (success) {
        //Reload user document to get update data
        await _loadUserDocument(_user.value!.uid);
      }

      return success;
    } finally {
      _isLoading.value = false;
    }
  }
}
