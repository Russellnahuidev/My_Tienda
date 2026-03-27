import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_tienda/services/firestore_services.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //Get current user
  static User? get currentUser => _auth.currentUser;

  // Get current user stream
  static Stream<User?> get authStateCchanges => _auth.authStateChanges();

  //Sign up with email and password
  static Future<AuthResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await result.user?.updateDisplayName(name);
      await result.user?.reload();

      //Created user document in Firestore and await for completion
      if (result.user != null) {
        final firestoreSuccess = await FirestoreServices.createUserDocument(
          uid: result.user!.uid,
          email: email,
          name: name,
        );
        if (firestoreSuccess) {
          //If firestore creation fails, we still return succes for auth
          //but log the error (user can still use the app)
          print(
            'Warning: failed to create user document in Firestore for user ${result.user!.email}',
          );
        }
      }
      return AuthResult(
        succes: true,
        user: result.user,
        message: 'Account created successfully',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(succes: false, message: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
        succes: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  //Sign in with email and password
  static Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return AuthResult(
        succes: true,
        user: result.user,
        message: 'Signed in Successfully',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(succes: false, message: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
        succes: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  //send password reset email
  static Future<AuthResult> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return AuthResult(
        succes: true,
        message: 'Password reset email sent successfully',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(succes: false, message: _getErrorMessage(e.code));
    } catch (e) {
      return AuthResult(
        succes: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  //Sign out
  static Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();

      return AuthResult(succes: true, message: 'Signed out Successfully');
    } catch (e) {
      return AuthResult(
        succes: false,
        message: 'Failed to sign out. Please try again.',
      );
    }
  }

  //check if user is signed in
  static bool get isSignedIn => _auth.currentUser != null;

  //Get user email
  static String? get userEmail => _auth.currentUser?.email;

  //Get user display name
  static String? get userDisplayEmail => _auth.currentUser?.displayName;

  //Get user ID
  static String? get userId => _auth.currentUser?.uid;

  //Helper method to get user-friendly error messages
  static String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operations-not-allwed':
        return 'Email/password accounts are not enabled.';
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

class AuthResult {
  final bool succes;
  final User? user;
  final String message;

  AuthResult({required this.succes, this.user, required this.message});
}
