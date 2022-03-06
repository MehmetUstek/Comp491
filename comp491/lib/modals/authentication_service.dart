import 'package:comp491/modals/dbQueries.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'User.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
}

  Future<String?> signIn(String email, String password) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  Future<String?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userFirebase = _firebaseAuth.currentUser;
      if (findOne(where.eq('userUID', userFirebase!.uid),
              collectionType: CollectionType.UserCollection) ==
          null) {
        insertOne({
          'userUID': userFirebase.uid,
          'userEmail': userFirebase.email,
          'userName': userFirebase.displayName,
        }, collectionType: CollectionType.UserCollection);
      }

      return "Signed In";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  Future<String?> signInWithGoogle() async {
    try{
      final user = await GoogleSignIn().signIn();
      final googleAuth = await user!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      final userFirebase = _firebaseAuth.currentUser;
      if (findOne(where.eq('userUID', userFirebase!.uid),
              collectionType: CollectionType.UserCollection) ==
          null) {
        insertOne({
          'userUID': userFirebase.uid,
          'userEmail': userFirebase.email,
          'userName': userFirebase.displayName,
        }, collectionType: CollectionType.UserCollection);
      }
      return "Signed in";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}