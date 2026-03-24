import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollections = 'users';

  //Create user document in Firestore
  static Future<bool> createUserDocument({
    required final String uid,
    required final String email,
    required final String name,
  }) async {
    try {
      final userpreferences = {
        'uid': uid,
        'email': email,
        'name': name,
        'displayName': name,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isActive': true,
        'profileImageUrl': null,
        'phoneNumber': null,
        'dateOfBirth': null,
        'gender': null,
        'addresses': [],
        'preferences': {
          'notifications': true,
          'emailUpdates': true,
          'darkMode': false,
        },
      };

      await _firestore
          .collection(_usersCollections)
          .doc(uid)
          .set(userpreferences);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Get user document fron firestore
  static Future<Map<String, dynamic>?> getUserDocument(String uid) async {
    try {
      final doc = await _firestore.collection(_usersCollections).doc(uid).get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Update user document
  static Future<bool> updateUserDocument({
    required String uid,
    required Map<String, dynamic> preferences,
  }) async {
    try {
      preferences['updateAt'] = FieldValue.serverTimestamp();

      await _firestore
          .collection(_usersCollections)
          .doc(uid)
          .update(preferences);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update user profile
  static Future<bool> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    String? dateOfBirth,
    String? gender,
    String? profileImageUrl,
  }) async {
    try {
      //Check if user document exists first
      final docExists = await userDocumentExist(uid);

      if (!docExists) {
        //Create user document if it doesn't exist
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final createSuccess = await createUserDocument(
            uid: uid,
            email: user.email ?? '',
            name: name ?? user.displayName ?? 'User',
          );

          if (!createSuccess) {
            print('Failed to create user document');
            return false;
          } else {
            print('No authenticated user fund');
            return false;
          }
        }
      }

      final Map<String, dynamic> updateDate = {
        'updateAt': FieldValue.serverTimestamp(),
      };
      if (name != null) {
        updateDate['name'] = name;
        updateDate['displayName'] = name;
      }
      if (phoneNumber != null) updateDate['phoneNumber'] = phoneNumber;
      if (dateOfBirth != null) updateDate['dateOfBirth'] = dateOfBirth;
      if (gender != null) updateDate['gender'] = gender;
      if (profileImageUrl != null) {
        updateDate['profileImageUrl'] = profileImageUrl;
      }

      //use set with merge to handle both create and update scenarios
      await _firestore
          .collection(_usersCollections)
          .doc(uid)
          .set(updateDate, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }

  // Add user address
  static Future<bool> addUserAddress({
    required String uid,
    required Map<String, dynamic> address,
  }) async {
    try {
      await _firestore.collection(_usersCollections).doc(uid).update({
        'addresses': FieldValue.arrayUnion([address]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update user preferences
  static Future<bool> updateUserPreferences({
    required String uid,
    required Map<String, dynamic> preferences,
  }) async {
    try {
      await _firestore.collection(_usersCollections).doc(uid).update({
        'preferences': preferences,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete suer document (for account deletion)
  static Future<bool> deleteUserDocument({required String uid}) async {
    try {
      await _firestore.collection(_usersCollections).doc(uid).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  // check if user documents exist
  static Future<bool> userDocumentExist(String uid) async {
    try {
      final doc = await _firestore.collection(_usersCollections).doc(uid).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  //get user stream for real-time updates
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
    String uid,
  ) {
    return _firestore.collection(_usersCollections).doc(uid).snapshots();
  }
}
