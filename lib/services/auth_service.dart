import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> register(String email, String password, String name) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await cred.user!.sendEmailVerification();
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'name': name,
        'email': email,
        'notificationsEnabled': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!cred.user!.emailVerified) {
        await _auth.signOut();
        return "Please verify your email first.";
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}