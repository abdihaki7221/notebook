import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notebook/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body:Column(
          children: [
            const Text("we've sent you an email verification."),
            const Text("verify your email address"),
            TextButton(onPressed: ()async{
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
              
    
            },
            child: const Text("send email verification"),
            ),
            TextButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              
              if(!mounted)return;
              Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
              

            }, child: const Text("Back"))
          ],
        ),
    );
  }
}



   