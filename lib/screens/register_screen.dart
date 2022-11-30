import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';
import 'login_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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

              TextField(
                obscureText: true,
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30,),

              loading? const CircularProgressIndicator() : Container(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ElevatedButton(
                  onPressed: () async {
                      setState(() {
                        loading=true;
                      });
                      if(emailController.text=='' || passwordController.text=='') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("All fields are required"),
                          backgroundColor: Colors.red,));
                      }else if(passwordController.text !=confirmPasswordController.text){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password don't match"), backgroundColor: Colors.red,));
                      }else{
                         User? result = await AuthService().register(emailController.text, passwordController.text, context);
                         if(result!=null)
                           {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen(result)), (route) => false);
                           }
                      }
                      setState(() {
                        loading=false;
                      });
                  },
                  child: const Text("Submit",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ),
              ),
              const SizedBox(height: 20,),
              TextButton(
                  onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
                  child: const Text("Already have a account? Login Here"),
              ),
              const SizedBox(height: 20,),

              loading? const CircularProgressIndicator(): SignInButton(
                  Buttons.Google,
                  text: "Continue with Google",
                  onPressed: ()async{
                    setState(() {
                      loading=true;
                    });
                    User? user= await AuthService().signInWithGoogle();
                    if(user!=null)
                      {
                        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context)=> HomeScreen(user)), (route) => false);

                      }
                    setState(() {
                      loading=false;
                    });
                  },
              ),
            ],
          ),
        )
    );
  }
}
