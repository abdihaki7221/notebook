import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../utilities/logout_dialog.dart';

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
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                 
                  
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