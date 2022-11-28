import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;

  //Register AuthService

  Future<User?> register(String email, String password) async{
    UserCredential userCredential= await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }


}