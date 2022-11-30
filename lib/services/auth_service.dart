import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


void showOTPDialog({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed,
})
{
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Enter OTP"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: codeController,
            )
          ],
        ),
        actions: <Widget>[
          TextButton(
              onPressed: (){},
              child: Text("Done"),)
        ],
      )
  );
}
class AuthService{
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;

  ///Register AuthService

  Future<User?> register(String email, String password, BuildContext context) async{
    try {
      UserCredential userCredential= await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    }catch(e){
      print(e);
    }

  }

  ///Login
  Future<User?> login(String email, String password, BuildContext context) async{
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    }catch(e){
      print(e);
    }
  }


  ///Google Sign In

  Future<User?> signInWithGoogle()async{
    try{
    //trigger the auth dialog
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser!=null) {
      //Obtain the auth detalis
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      //Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      //Once signed in return the user data to firebase
      UserCredential userCredential = await firebaseAuth.signInWithCredential(
          credential);
      return userCredential.user;
    }
    }catch(e){
      print(e);
    }
  }

  ///SignOut

  Future signOut()async{
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
    print("Logout succsefull");
  }

  ///PhoneSignIn
  //
  // Future phoneSignIn(BuildContext context, String phoneNumber) async{
  //   TextEditingController codeController= TextEditingController();
  //     await firebaseAuth.verifyPhoneNumber(
  //         phoneNumber: phoneNumber,
  //         verificationCompleted: (PhoneAuthCredential credential) async{
  //           await firebaseAuth.signInWithCredential(credential);
  //         },
  //         verificationFailed: (e) {
  //           print(e);
  //         },
  //       codeSent: ((String verificationId, int? resendToken) async{
  //           showOTPDialog(
  //               context: context,
  //               codeController: codeController,
  //               onPressed: ()async{
  //                     PhoneAuthCredential credential= PhoneAuthProvider.credential(
  //                         verificationId: verificationId,
  //                         smsCode: codeController.text.trim(),
  //                     );
  //                     await firebaseAuth.signInWithCredential(credential);
  //                     Navigator.pop(context);
  //                     Navigator.pop(context);
  //               });
  //       }),
  //       codeAutoRetrievalTimeout: (String verificationId){
  //
  //       },
  //     );
  // }
}