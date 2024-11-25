import 'package:WrLogistics/assets/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../sign_up.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _ConfirmPasswordInput(),
            const SizedBox(height: 8),
            //_PhoneInput(),
            //const SizedBox(height: 8,),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Ingresa tu Email',
              errorText: state.email.displayError != null ? 'Email inválido' : null,
              errorStyle: const TextStyle(color: Colors.red),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        );
      },
    );
  }
}



class _PasswordInput extends StatefulWidget {
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            key: const Key('signUpForm_passwordInput_textField'),
                        style: const TextStyle(color: Colors.black),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              hintText: 'Ingrese su contraseña',
              errorText: state.password.displayError != null
                  ? 'Contraseña inválida'
                  : null,
              errorStyle: const TextStyle(color: Colors.red),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  @override
  _ConfirmPasswordInputState createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
                        style: const TextStyle(color: Colors.black),

            onChanged: (confirmPassword) =>
                context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirmar contraseña',
              hintText: 'Repite tu contraseña',
              errorText: state.confirmedPassword.displayError != null
                  ? 'Las contraseñas no coinciden'
                  : null,
              errorStyle: const TextStyle(color: Colors.red),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:AppColors.primary),
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

// i fucked up, this is just clunkier code

// class _PhoneInput extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpCubit, SignUpState>(
//       buildWhen: (previous, current) => previous.phone != current.phone,
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: TextField(
//             key: const Key('signUpForm_phoneInput_textField'),
//             onChanged: (phoneNumber) =>
//                 context.read<SignUpCubit>().phoneChanged(phoneNumber),
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               labelText: 'Número de teléfono',
//               hintText: 'Ingresa tu número de teléfono',
//               errorText: state.phone.displayError != null
//                   ? 'Número de teléfono no válido'
//                   : null,
//               errorStyle: const TextStyle(color: Colors.red),
//               border: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: AppColors.primary),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               prefix:const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(width: 8), // Adjust the spacing as needed
//                    Text(
//                     '+56',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(width: 6)
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }




class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Adjust padding for a larger button
                ),
                onPressed: state.isValid
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text(
                  'Inscribirse',
                  style: TextStyle(fontSize: 18), // Adjust font size
                ),
              );
      },
    );
  }
}
