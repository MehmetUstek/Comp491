import 'package:comp491/view/dbQueries.dart';
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

  Future<User?> signIn(String email, String password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      
      return userCredential.user;
    } on FirebaseAuthException catch(e){
      throw FirebaseAuthException(code: "User not found");
    }
  }
  Future<String?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userFirebase = _firebaseAuth.currentUser;
      // if (findOne(where.eq('userUID', userFirebase!.uid),
      //         collectionType: CollectionType.UserCollection) ==
      //     null) {
      //   insertOne({
      //     'userUID': userFirebase.uid,
      //     'userEmail': userFirebase.email,
      //     'userName': userFirebase.displayName,
      //   }, collectionType: CollectionType.UserCollection);


      return "Signed In";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
  Future<String?> signInWithGoogle() async {
    try{
      final googleSignIn = await GoogleSignIn().signIn();
      final googleAuth = await googleSignIn!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      final userFirebase = _firebaseAuth.currentUser;
      // fetchUser(user?.uid).catchError((){
      //
      // });
      createUser(UserData(userUID: user?.uid,
          userEmail: user?.email,
          userName: user?.displayName));
      return "Signed in";
    } on FirebaseAuthException catch(e){
      return e.message;
    } on Exception catch(e){
      return e.toString();
    }
  }
}