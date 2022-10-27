


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notebook/firebase_options.dart';
import 'package:notebook/views/login_view.dart';
import 'package:notebook/views/register_view.dart';
import 'package:notebook/views/verify_email.dart';
import 'dart:developer' as devtools show log;






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
        '/login/':(context) => const LoginView(),
        '/register/':(context) => const RegisterView(),
        '/notes/':(context) => const NotesView(),
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

  enum MenuAction{logout}


  class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Mynotes'),

        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async{
            switch (value){
              case MenuAction.logout:
                final shouldDialog = await logoutDialog(context);

                if(shouldDialog){
                  await FirebaseAuth.instance.signOut();
                    if(!mounted)return;
                    Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false);
                 
                  
                }
                
            }

          
              
            },itemBuilder: (context){
            return const[
              PopupMenuItem<MenuAction>( value: MenuAction.logout,child: Text('logout')
              )

            ];
          })
        ],

      ),
    );
  }
}

Future<bool>logoutDialog(BuildContext context){
  return showDialog<bool>(context: context,
   builder: (context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);

        }, child: const Text('cancel')),
      
       TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, child: const Text('Logout')),


      ],
      
    );
  },
  ).then((value) => value?? false);

}

  