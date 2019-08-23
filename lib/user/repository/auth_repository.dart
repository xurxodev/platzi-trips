import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<FirebaseUser> signInFirebase() => _firebaseAuthAPI.signIn();

  void signOut() {
    _firebaseAuthAPI.signOut();
  }
}
