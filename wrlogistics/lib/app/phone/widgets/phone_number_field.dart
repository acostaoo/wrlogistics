// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PhoneNumberWidget extends StatefulWidget {
//   const PhoneNumberWidget({Key? key, required this.phoneNumberController})
//       : super(key: key);

//   final TextEditingController phoneNumberController;

//   @override
//   State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
// }

// class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
//   final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _phoneNumberFormKey,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: TextFormField(
//               keyboardType: TextInputType.phone,
//               controller: widget.phoneNumberController,
//               decoration: InputDecoration(
//                 labelText: 'Número de Teléfono',
//                 hintText: 'Ingresa tu número de teléfono',
//                 errorText: _getPhoneNumberError(context),
//                 errorStyle: const TextStyle(color: Colors.red),
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.blue),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               validator: (value) {
//                 // Use the ChileanPhoneNumber validator
//               //  return ChileanPhoneNumber.dirty(value!).error;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String? _getPhoneNumberError(BuildContext context) {
//   //  final signUpState = context.watch<SignUpCubit>().state;
//     return signUpState.phoneNumber.displayError != null
//         ? 'Número de teléfono no válido'
//         : null;
//   }
// }
