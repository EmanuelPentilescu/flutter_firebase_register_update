import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/note.dart';
import 'package:flutter_firebase/screens/register_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

import 'add_note.dart';
import 'edit_note.dart';

class HomeScreen extends StatelessWidget {
  User user;
  HomeScreen(this.user);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                  (route) => false);
            },
            icon: Icon(Icons.logout),
            label: Text("Signout"),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
        onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNoteScreen(user)));
        },
      ),

      
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').where('userId', isEqualTo: user.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData) {
              if(snapshot.data!.docs.length>0){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                    NoteModel note= NoteModel.fromJson(snapshot.data!.docs[index]);
                    return Card(
                      color: Colors.teal,
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        title: Text(note.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        subtitle: Text(note.description, overflow: TextOverflow.ellipsis, maxLines: 2,),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNoteScreen(note)));
                        },
                      ),
                    );
                  }
                );
              }
            }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
      );
      // body: Container(
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //         child: Text("Add data to Firestore"),
      //         onPressed: () async {
      //           CollectionReference users = firestore.collection('users');
      //           // await users.add({
      //           //   'name': 'Raul'
      //           // });
      //
      //           await users.doc("flutter123").set({'name': "Google Flutter"});
      //         },
      //       ),
      //       ElevatedButton(
      //         child: Text("Read Data from firestore"),
      //         onPressed: () async {
      //           CollectionReference users = firestore.collection('users');
      //           // QuerySnapshot allResults= await users.get();
      //           // allResults.docs.forEach((DocumentSnapshot result) {
      //           //   print(result.data());
      //           // });
      //
      //           DocumentSnapshot result = await users.doc('flutter123').get();
      //           print("ID:${result.id} Data:${result.data()}");
      //
      //           users.doc("flutter123").snapshots().listen((result) {
      //             print(result.data());
      //           });
      //         },
      //       ),
      //       ElevatedButton(
      //         onPressed: () async {
      //           await firestore
      //               .collection('users')
      //               .doc("flutter123")
      //               .update({'name': "Flutter Firebase"});
      //         },
      //         child: Text("Update Data in Firestore"),
      //       ),
      //       ElevatedButton(
      //           onPressed: ()async{
      //             await firestore.collection('users').doc("flutter123").delete();
      //       },
      //           child: Text("Delete Data from Firestore"),)
      //     ],
      //   ),
      // ),
  }
}
