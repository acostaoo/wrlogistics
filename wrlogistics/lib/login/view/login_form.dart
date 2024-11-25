import 'package:WrLogistics/assets/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:WrLogistics/login/login.dart';
import 'package:WrLogistics/sign_up/view/sign_up_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Autenticación fallida.'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/wrlogo.png',
                height: 320,
                filterQuality: FilterQuality.high,
              ),
              _EmailInput(),
              const SizedBox(height: 8),
              _PasswordInput(),
              const SizedBox(height: 8),
              _LoginButton(),
              const SizedBox(height: 8),
              _GoogleLoginButton(),
              const SizedBox(height: 4),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 80),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              hintText: 'Ingresa tu correo electrónico',
              errorText:
                  state.email.displayError != null ? 'Correo inválido' : null,
              errorStyle: const TextStyle(color: Colors.red),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon:const Icon(
                Icons.email,
                color: AppColors.lightPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}


class _PasswordInput extends StatefulWidget{
  @override
  _PasswordInputState createState()=>_PasswordInputState();
}
class _PasswordInputState extends State<_PasswordInput>{
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context){
    return BlocBuilder<LoginCubit,LoginState>(
      buildWhen:(previous,current) =>previous.password!=current.password,
       builder:(context,state){
        return Padding(
          key: const Key('loginForm_passwordInput_textField'),
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 80),
          child:TextField(
                        style: const TextStyle(color: Colors.black),
          onChanged: (password)=> context.read<LoginCubit>().passwordChanged(password),
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'contraseña',
            hintText: 'Ingrese su contraseña',
            errorText: state.password.displayError !=null?'contraseña inválida':null,
            errorStyle: const TextStyle(color: Colors.red),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(8)
            ),focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary)
            ),prefixIcon:const Icon(
              Icons.lock,
              color: AppColors.lightPrimary
            ),suffixIcon: IconButton(
              icon:Icon(_isPasswordVisible?Icons.visibility:Icons.visibility_off),
              color: Colors.grey,
              onPressed: (){setState(() {
                _isPasswordVisible=!_isPasswordVisible;
              });},
            )
          ),
          onSubmitted: (_) {context.read<LoginCubit>().logInWithCredentials();},
          )
        );
       });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.secondary,
                ),
                onPressed: state.isValid
                    ? () {
                        // Log in action
                        context.read<LoginCubit>().logInWithCredentials();

                        // Show keyboard
                        FocusManager.instance.primaryFocus?.unfocus();
                        FocusManager.instance.primaryFocus?.nextFocus();
                      }
                    : null,
                child: const Text('LOGIN',style: TextStyle(color: Colors.white)),
              );
      },
    );
  }
}



class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('loginForm_googleLogin_inkWell'),
      onTap: () => context.read<LoginCubit>().logInWithGoogle(),
      child: Container(
        decoration: BoxDecoration(
          gradient:const SweepGradient(
            colors: [
              Color(0xFF4285F4), // Blue
              Color(0xFFDB4437), // Red
              Color(0xFFF4B400), // Yellow
              Color(0xFF0F9D58), // Green
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child:const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.google, color: Colors.white),
            SizedBox(width: 10.0),
            Text(
              'INGRESA CON GOOGLE',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}


class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child:const Text(
        'Crear cuenta',
        style: TextStyle(color: AppColors.lightPrimary),
      ),
    );
  }
}