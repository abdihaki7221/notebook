


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notebook/firebase_options.dart';
import 'package:notebook/views/login_view.dart';
import 'package:notebook/views/register_view.dart';
import 'package:notebook/views/verify_email.dart';






void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),

      // routes

      routes: {
        '/login/':(context) => const LoginView(),
        '/register/':(context) => const RegisterView(),
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
                  print("email verified");
                }else{
                  return const VerifyEmailView();
                }
              }else{
                return const LoginView();
              }
              return const Text("done");
             
            default:return const Text('loading...');
          }
          
          
        },
      );
    
  }
}

  