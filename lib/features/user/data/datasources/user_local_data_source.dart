import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserLocalDataSource {
  Stream<User?> autoStateChanges();
  User? getCurrentUser();
  Future<void> signOut();
  
}
 
class UserLocalDataSourceImp implements UserLocalDataSource {
 
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
 
  UserLocalDataSourceImp({
    required this.firebaseAuth,
    required this.facebookAuth,
    required this.googleSignIn,
   
  });
  @override
  Stream<User?> autoStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      firebaseAuth.signOut(),
      googleSignIn.signOut(),
      facebookAuth.logOut(),
    ]);
  }

  
}
