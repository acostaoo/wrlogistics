import 'package:formz/formz.dart';

class Address extends FormzInput<String,String>{
  const Address.pure():super.pure('');
  const Address.dirty([String value='']):super.dirty(value);

  static final RegExp _addressRegExp = RegExp(
  r'^[a-zA-Z0-9ñá]+(\s?[a-zA-Z0-9ñá])+ \d{1,5}, [a-zA-Z0-9ñá]+(\s?[a-zA-Z0-9ñá])+$',
);

@override
String? validator(String value){
  return _addressRegExp.hasMatch(value)?null:'Dirección inválida';
}
  
}
