// import 'package:attempt1/app/phone_bloc/bloc/phone_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// //TODO check if it doesnt explode when popped

// class OtpWidget extends StatelessWidget {
//   OtpWidget(
//       {Key? key, required this.codeController, required this.verificationId})
//       : super(key: key);
//   final TextEditingController codeController;
//   final String verificationId;
//   final GlobalKey<FormState> _otpFormKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _otpFormKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.number,
//             controller: codeController,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Ingresar OTP',
//               prefixIcon: Icon(Icons.message),
//             ),
//             validator: (value) {
//               if (value!.length != 6) {
//                 return 'Por favor ingresa un OTP válido';
//               }
//               return null;
//             },
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_otpFormKey.currentState!.validate()) {
//                   _verifyOtp(context: context);
//                 }
//               },
//               child: const Text('Verificar OTP'),
//             ),
//           ),
//         ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Volver'))],
//       ),
//     );
//   }

//   void _verifyOtp({required BuildContext context}) {
//     context.read<PhoneAuthBloc>().add(VerifySentOtpEvent(
//         otpCode: codeController.text, verificationId: verificationId));
//     codeController.clear();
//   }
// }