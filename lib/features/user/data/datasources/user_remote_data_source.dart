import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRemoteDataSource {
  Future<Unit> signInWithGoogle();
  Future<Unit> signInWithFacebook();
  Future<Unit> signInAnonymously();
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FacebookAuth facebookAuth;
  UserRemoteDataSourceImp({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.facebookAuth,
  });
  @override
  Future<Unit> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn(
      
    );

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        await firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );

        return Future.value(unit);
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google Id Token');
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<Unit> signInWithFacebook() async {
    final result = await facebookAuth.login();

    final userData = await facebookAuth.getUserData();
    print('userData: $userData');
    final facebookAuthCredentials =
        await FacebookAuthProvider.credential(result.accessToken!.token);
    await firebaseAuth.signInWithCredential(facebookAuthCredentials);
    // print(firebaseAuth.currentUser!.displayName);
    // print(firebaseAuth.currentUser!.phoneNumber);
    // print(firebaseAuth.currentUser!.photoURL);
    // print(firebaseAuth.currentUser!.providerData);
    // print(userData['picture']['data']['url']);
    //upload user data to server
    return Future.value(unit);
  }

  @override
  Future<Unit> signInAnonymously() async {
    await firebaseAuth.signInAnonymously();
    return Future.value(unit);
  }
}
