import 'package:firebase_auth/firebase_auth.dart';

class AutService {
  final firebaseAuth = FirebaseAuth.instance;

  Future sigInAnonymous() async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sifremiUnuttum(String email) async {
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {}
  }

  Future<String?> GirisYap(String email, String sifre) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: sifre);
      res = "basarili";
    } on FirebaseAuthException catch (eror) {}
    return res;
  }

  Future signOutAccount() async {
    await FirebaseAuth.instance.signOut();
  }
}
