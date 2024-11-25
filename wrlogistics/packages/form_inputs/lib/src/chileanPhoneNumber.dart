import 'package:formz/formz.dart';

// Custom FormzInput validator for Chilean phone numbers
class ChileanPhoneNumber extends FormzInput<String, String> {
  const ChileanPhoneNumber.pure() : super.pure('');
  const ChileanPhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegex = RegExp(r'^9\d{8}$');

  @override
  String? validator(String value) {
    return _phoneRegex.hasMatch(value) ? null : 'Número inválido';
  }
}