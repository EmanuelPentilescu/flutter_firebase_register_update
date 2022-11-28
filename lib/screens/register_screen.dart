import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';
//import 'package:flutter/services.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),

            TextField(
              obscureText: true,
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),

            Container(
              height: 50,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ElevatedButton(
                onPressed: () async {
                    if(emailController.text=='' || passwordController.text=='') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("All fields are required"),
                        backgroundColor: Colors.red,));
                    }else if(passwordController.text !=confirmPasswordController.text){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password don't match"), backgroundColor: Colors.red,));
                    }else{
                       User? result = await AuthService().register(emailController.text, passwordController.text);
                       if(result!=null)
                         {
                           print("Succes\n");
                           print(result.email);
                         }
                    }
                },
                child: const Text("Submit",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 20,),
            TextButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
                child: const Text("Already have a account? Login Here")),
          ],
        )
    );
  }
}
