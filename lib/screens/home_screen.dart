import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
            onPressed: () async{
              await AuthService().signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text("Signout"),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text("U made it throw",textScaleFactor: 7,textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
