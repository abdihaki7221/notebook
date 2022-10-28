import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notebook/constants/routes.dart';
import 'package:notebook/main.dart';
import '../firebase_options.dart';
import 'dart:developer' as devtools show  log;

import '../utilities/error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),

      ),
      body: FutureBuilder(
        future:  Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
                ),

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:

            return Column(
          children: [
            TextField( controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter email'),
            
            ),
            TextField( controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter password'),
            ),
            TextButton(onPressed: ()async{
             
      
              final email = _email.text;
              final password = _password.text;

              
      
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        
          if(!mounted)return;
          Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);
        } on FirebaseAuthException catch (e) {
          if(e.code == 'user-not-found'){
            await errorDialog(context,
             'User not found');
          }else if(e.code =='wrong-password'){
            await errorDialog(context,
             'Wrong password');
          }else if(e.code == 'invalid-email'){
            await  errorDialog(context,
             'Invalid email');
          }else{
            await errorDialog(context, 'error ${e.code}');
          }


        }catch (e){
          await errorDialog(context, e.toString(),
          );
        }
      
      
      
            },
             child: const Text("Login")),

             TextButton(onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
               
             }, child: const Text("Not registered? Register here."))
          ],
        );
              
              
            default:
              return const Text("loading..");

          }
          
        },
         
      ),
    );
  }
}



