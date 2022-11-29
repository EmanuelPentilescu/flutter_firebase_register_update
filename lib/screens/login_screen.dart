import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';

import 'home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(padding: const EdgeInsets.all(20),
          child: Column(
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
              loading? const CircularProgressIndicator(): Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      loading=true;
                    });
                    if(emailController.text=='' || passwordController.text=='') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:  Text("All fields are required"),
                        backgroundColor: Colors.red,));
                    }else{
                      User? user= await AuthService().login(emailController.text, passwordController.text, context);
                      if(user!=null)
                      {
                        print("Login in succesfull");
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen(user)), (route) => false);
                      }
                    }
                    setState(() {
                      loading=false;
                    });
                  },
                  child: const Text("Submit", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          )
      ),
    );
  }
}
