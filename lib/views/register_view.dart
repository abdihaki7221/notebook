
import 'package:flutter/material.dart';
import 'package:notebook/constants/routes.dart';
import 'package:notebook/services/auth/auth_exceptions.dart';
import 'package:notebook/services/auth/auth_service.dart';
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
        future:  AuthService.firebase().initialize(),

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
                await AuthService.firebase().createUser(email: email, password: password);
                if(!mounted)return;
                Navigator.of(context).pushNamed(verifyEmailRoute);

                
                AuthService.firebase().sendEmailVerification();

              } on WeakPasswordAuthException{
                await errorDialog(context,
                  'weak password',
                  );
              }on EmailAlreadyInUseAuthException{
                await errorDialog(context,
                  'Email already in use',
                  );
              }on InvalidEmailAuthException{
                 await errorDialog(context,
                  'This is an invalid email',
                  );
              }on GenericAuthException{
                await errorDialog(context, 'failed to register');
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



