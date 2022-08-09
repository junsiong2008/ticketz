import 'package:ticketz/models/application_user.dart';
import 'package:ticketz/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthStateProvider extends ChangeNotifier {
  AuthenticationService authenticationService = AuthenticationService();
  String? errorString;
  bool loading = false;

  Stream<ApplicationUser?>? get getUserStream =>
      authenticationService.getUserStream();

  ApplicationUser? get getCurrentUser => authenticationService.getCurrentUser();
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    clearErrorString();
    loading = true;
    try {
      await authenticationService.signInWithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          setErrorString('The email address is not valid.');
          break;

        case 'user-disabled':
          setErrorString('The user has been disabled');
          break;

        case 'user-not-found':
          setErrorString('No user with the given email is found.');
          notifyListeners();
          break;

        case 'wrong-password':
          setErrorString('Password is invalid.');
          break;

        default:
          setErrorString('Unknown error.');
      }
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void signOut() async {
    await authenticationService.signOut();
    notifyListeners();
  }

  void clearErrorString() {
    errorString = null;
    notifyListeners();
  }

  void setErrorString(String error) {
    errorString = error;
    notifyListeners();
  }
}
