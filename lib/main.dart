


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notebook/constants/routes.dart';
import 'package:notebook/firebase_options.dart';
import 'package:notebook/utilities/logout_dialog.dart';
import 'package:notebook/views/login_view.dart';
import 'package:notebook/views/register_view.dart';
import 'package:notebook/views/verify_email.dart';
import 'dart:developer' as devtools show log;

import 'views/notes_view.dart';






void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),

      // routes

      routes: {
        loginRoute :(context) => const LoginView(),
        registerRoute:(context) => const RegisterView(),
        notesRoute:(context) => const NotesView(),
      }
    ));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              
              if(user!=null){
                if(user.emailVerified){
                  return const NotesView();
              
                }else{
           
                  return const VerifyEmailView();
                }
              }else{
                return const LoginView();
              }
           
             
            default:return const Text('loading...');
          }
          
          
        },
      );
    
  }
}

  





  