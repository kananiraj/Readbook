import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth=FirebaseAuth.instance;
final googleSignIn=GoogleSignIn();

Future<bool?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
            
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      
        UserCredential result = await auth.signInWithCredential(credential);
      
        User? user = auth.currentUser;
        user = result.user;
      
        print(user.uid);
      
        return Future.value(true);
      }
  } on PlatformException catch (e) {
      print(e);
  }
}

Future<void> logOut() async {
  await FirebaseAuth.instance.signOut();
  await googleSignIn.signOut();
}