import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notebook/constants/routes.dart';
import 'package:notebook/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:notebook/utilities/error_dialog.dart';






class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text("Register"),

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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                if(!mounted)return;
                Navigator.of(context).pushNamed(verifyEmailRoute);
                final user = FirebaseAuth.instance.currentUser;
                user?.sendEmailVerification();
              } on FirebaseAuthException catch (e) {
                if(e.code == 'weak-password'){
                 await errorDialog(context,
                  'weak password',
                  );
                }else if(e.code == 'email-already-in-use'){
                 await errorDialog(context,
                  'Email already in use',
                  );
                  

                }else if(e.code == 'invalid-email'){
                await errorDialog(context,
                  'This is an invalid email',
                  );

                }else{
                  await errorDialog(context, 'error: ${e.code}');
                }
              }catch(e){
                 await errorDialog(context, e.toString(),
                  );
              }
      
      
      
            },
             child: const Text("register")),

             TextButton(onPressed: (){

              Navigator.pushNamedAndRemoveUntil(context, loginRoute, (route) => false);

             }, child: const Text("already registered? Login")
             ),
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



