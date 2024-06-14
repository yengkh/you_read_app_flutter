import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthorService {
  // Google Sign in
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process (opens the page that allows the user to select an account)
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        // If the user cancels the sign-in process
        return null;
      }

      // Obtain authentication details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential for the user
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Finally, sign in with the credential and return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle error (e.g., log it, show a message to the user)
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      return null;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
