import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  // For registering a new user
  static Future<String> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
       user = userCredential.user;
       await user!.updateDisplayName(name);
       await user.reload();
       user = auth.currentUser;
       user!.sendEmailVerification();

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } 
  }

  // For signing in an user (have already registered)
  static Future<String> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      if (user!.emailVerified == false )
      {
        return "Not verified";
      }
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }

  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }
}