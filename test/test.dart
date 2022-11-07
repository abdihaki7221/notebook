import 'package:firebase_auth/firebase_auth.dart';
import 'package:notebook/services/auth/auth_exceptions.dart';
import 'package:notebook/services/auth/auth_provider.dart';
import 'package:notebook/services/auth/auth_user.dart';
import 'package:test/test.dart';

 void main() {
  group('Mock Authentication', (){
    final provider = MockAuthProvider();

    test('should not be initialized to begin with', (){
      expect(provider._isInitialized,false);
    });

    test('cannot logout if not initialized', (){
      expect(provider.logout(), throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test('shoud be initialized',()async{
      await provider.initialize();
      expect(provider._isInitialized, true);
    },
      timeout: const Timeout(Duration(seconds: 2)),
      );

  });
  
}
class NotInitializedException implements Exception{

}
class MockAuthProvider implements AuthProvider{
  AuthUser? _user;
  var _isInitialized =false;
  bool get isInitialized => _isInitialized;


  @override
  Future<AuthUser> createUser({required String email, required String password}) async{
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return login(email: email, password: password);
  }

  @override
  
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize()async  {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized=true;
  }

  @override
  Future<AuthUser> login({required String email, required String password}) {
   if (!isInitialized) throw NotInitializedException();
   if(email == 'foobar@gmail.com')throw UserNotFoundAuthException();
   if(password=='foobar')throw WrongPasswordAuthException();
   const user = AuthUser(isEmailVerified: false);
   _user=user;

   return Future.value(user); 
   
  }

  @override
  Future<void> logout() async{
   if(!isInitialized) throw NotInitializedException();
   if(_user ==null) throw UserNotFoundAuthException();
   await Future.delayed(const Duration(seconds: 1));
   _user = null;

   
     }

  @override
  Future<void> sendEmailVerification() async{
     if(!isInitialized) throw NotInitializedException();
     final user = _user;
     if(user ==null)throw UserNotFoundAuthException();
     const newUser = AuthUser(isEmailVerified: true);
     _user = newUser;
  }
    
  }