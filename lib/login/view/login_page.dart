import 'package:attempt1/assets/palette.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attempt1/login/login.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  static Page<void> page()=> const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Login',style: TextStyle(color: Colors.white),),backgroundColor: AppColors.primary,),
      body:Padding(padding: const EdgeInsets.symmetric(vertical:10),
      child: BlocProvider(create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
      child: const LoginForm()))
    );
  }
}