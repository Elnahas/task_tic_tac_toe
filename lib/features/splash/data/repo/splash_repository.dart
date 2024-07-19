
import 'package:firebase_auth/firebase_auth.dart';

class SplashRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> signInAnonymously() async {
    try {
      
      await _auth.signInAnonymously();
      
    } catch (e) {
        throw "Failed to sign in anonymously: $e";
    }
  }


}