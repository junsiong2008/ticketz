import 'package:ticketz/models/application_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Firebase User in realtime stream
  Stream<ApplicationUser?>? getUserStream() =>
      _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);

  // Get current user
  ApplicationUser? getCurrentUser() {
    return _userFromFirebaseUser(_firebaseAuth.currentUser);
  }

  ApplicationUser? _userFromFirebaseUser(User? user) {
    if (user == null) {
      return null;
    } else {
      return ApplicationUser(email: user.email, uid: user.uid);
    }
  }

  // Sign in with Email
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final UserCredential credential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = credential.user;

    return user;
  }

  // Sign Out
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
