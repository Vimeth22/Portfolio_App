import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserCredential?> signup(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }

  static Future<UserCredential?> login(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final credential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }
}
