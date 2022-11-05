import 'package:flutter/material.dart';
import 'package:notebook/constants/routes.dart';
import 'package:notebook/services/auth/auth_service.dart';
import 'package:notebook/views/login_view.dart';
import 'package:notebook/views/register_view.dart';
import 'package:notebook/views/verify_email.dart';
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
        verifyEmailRoute:(context) => const VerifyEmailView(),
      }
    ));
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              
              if(user!=null){
                if(user.isEmailVerified){
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

  





  