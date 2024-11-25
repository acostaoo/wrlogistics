import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:cache/cache.dart';

part 'phone_repository.dart';

class SignUpWithEmailAndPasswordFailure implements Exception{
  const SignUpWithEmailAndPasswordFailure([
    this.message = "Ha sucedido un error.",
  ]); 

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code){
    switch(code){
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Email inválido');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('Usuario deshabilitado.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('Ya existe una cuenta asociada a este Email.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('Operación no permitida.');
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('Por favor utiliza una contraseña más fuerte.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
  final String message;
}
class LoginWithEmailAndPasswordFailure implements Exception{
  const LoginWithEmailAndPasswordFailure([
    this.message = 'Ha ocurrido un error.',
  ]);
factory LoginWithEmailAndPasswordFailure.fromCode(String code){
  switch(code){
    case 'invalid-email':
      return const LoginWithEmailAndPasswordFailure('Email inválido.');
    case 'user-disabled':
      return const LoginWithEmailAndPasswordFailure('Usuario deshabilitado.');
    case 'user-not-found':
      return const LoginWithEmailAndPasswordFailure('Usuario no encontrado, por favor regístrate.');
    case 'wrong-password':
      return const LoginWithEmailAndPasswordFailure('Constraseña incorrecta.');
    default:
      return const LoginWithEmailAndPasswordFailure();
  }
}
final String message;

}

class LoginWithGoogleFailure implements Exception{
  const LoginWithGoogleFailure([
    this.message = 'Ha ocurrido un error',
  ]);

  factory LoginWithGoogleFailure.fromCode(String code){
    switch (code){
      case 'account-exists-with-different-credential':
        return const LoginWithGoogleFailure('Cuenta ya existe con otras credenciales.');
      case 'invalid-credential':
        return const LoginWithGoogleFailure('La credencial recibida ha expirado.');
      case 'operation-not-allowed':
        return const LoginWithGoogleFailure('Operación no permitida.');
      case 'user-disabled':
        return const LoginWithGoogleFailure('Usuario deshabilitado');
      case 'user-not-found':
        return const LoginWithGoogleFailure('Email no encontrado, por favor crea tu cuenta.');
      case 'wrong-password':
        return const LoginWithGoogleFailure('Contraseña incorrecta.');
      case 'invalid-verification-code':
        return const LoginWithGoogleFailure('La credencial del código de verificación recibida es inválida.');
      case 'invalid-verification-id':
        return const LoginWithGoogleFailure('La credencial de la ID de verificación recibida es inválida.');
      default:
        return const LoginWithGoogleFailure(); 
    }
  }
  final String message;
}

class LogOutFailure implements Exception{}

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn(
          clientId: '614464401045-irbg8atin5jh1096ars53ap8rv6mqqv7.apps.googleusercontent.com',
          scopes: [
            'email',
            'profile',
      'https://www.googleapis.com/auth/cloud-platform',
      'https://www.googleapis.com/auth/datastore',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.readonly',
      'https://www.googleapis.com/auth/firestore',
          ]
        );

    final CacheClient _cache;
    final firebase_auth.FirebaseAuth _firebaseAuth;
    final GoogleSignIn _googleSignIn;

    @visibleForTesting
    bool isWeb =kIsWeb;

    @visibleForTesting
    static const userCacheKey = '__user_cache_key__';

 Stream<Usuario> get user {
  return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
    final user = firebaseUser == null ? Usuario.empty : (await AdminRepository().isAdmin(firebaseUser.uid)?firebaseUser.toAdmin:firebaseUser.toUser);
    return user;
  });
}


    Usuario get currentUser{
      return _cache.read<Usuario>(key: userCacheKey) ?? Usuario.empty;
    }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }
    Future<void> loginWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LoginWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LoginWithGoogleFailure();
    }
  }

  Future<void> loginWithEmailAndPassword({required String email, required String password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email:email, password:password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPasswordFailure.fromCode(e.code);
    }catch (_){
      throw const LoginWithEmailAndPasswordFailure();
    }
  }
   Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      print(_.toString());
      throw LogOutFailure();
    }
  }
}


extension on firebase_auth.User{
  Usuario get toUser{
    return Usuario(id: uid,email: email,nombre: displayName??'',phone:phoneNumber??'',userRole:UserRole.user,photo: photoURL);
  }
  Usuario get toAdmin{
    return Usuario(id: uid,email: email,nombre: displayName??'',phone: phoneNumber??'',userRole: UserRole.admin,photo: photoURL);
  }
}

