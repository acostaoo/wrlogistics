import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'phone_input_state.dart';

class PhoneInputCubit extends Cubit<PhoneInputState> {

  PhoneInputCubit(this._phoneRepository) : super(const PhoneInputState());

  final PhoneRepository _phoneRepository;

  void phoneNumberChanged(String value) {
    final phone = ChileanPhoneNumber.dirty(value);
    emit(state.copyWith(
      phoneNumber: phone,
      isValid: Formz.validate([phone]),
      status: FormzSubmissionStatus.initial
    ));
  }

  Future<String> getPhoneNumber(String uid) async{
    try{
      String phone =await _phoneRepository.getPhoneNumber(uid:uid);
      if (phone.isNotEmpty){
      emit(state.copyWith(phoneNumber: ChileanPhoneNumber.dirty(phone),isValid: true,status: FormzSubmissionStatus.success));
      print('phone found: $phone');
      return phone;
      }else{return '';
      }
    }catch(_){
      print(_.toString());
      return '';
    }
  }

  Future<void> submitPhoneNumber(String uid) async {
    if (!state.isValid)return;
    try {
      await _phoneRepository.storePhoneNumber(phoneNumber:state.phoneNumber.value,uid:uid);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      print('phjone success store');
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        print(e.toString());
      }
    }
  }

