import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notebook/firebase_options.dart';
import 'dart:developer' as devtools show log;






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
                final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                if(e.code == 'weak-password'){
                  devtools.log('Weak password');
                }else if(e.code == 'email-already-in-use'){
                  devtools.log("email already in use");
                  

                }else if(e.code == 'invalid-email'){
                devtools.log('invalid email');

                }
              }
      
      
      
            },
             child: const Text("register")),

             TextButton(onPressed: (){

              Navigator.pushNamedAndRemoveUntil(context, '/login/', (route) => false);

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



