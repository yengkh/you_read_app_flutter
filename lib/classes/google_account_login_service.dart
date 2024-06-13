import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthorService {
  // Google Sign in
  static singInWithGoogle() async {
    // Begin Interactive sign in process it open the page that allow user to select accont
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain Auth deatil from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
