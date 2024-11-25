part of 'phone_input_cubit.dart';

final class PhoneInputState extends Equatable {
  const PhoneInputState({
    this.phoneNumber = const ChileanPhoneNumber.pure(),
    this.isValid =false,
    this.status = FormzSubmissionStatus.initial
  });

  final ChileanPhoneNumber phoneNumber;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [phoneNumber];

  PhoneInputState copyWith({
    ChileanPhoneNumber? phoneNumber,
    bool? isValid,
    FormzSubmissionStatus? status,
  }){
    return PhoneInputState(
      phoneNumber: phoneNumber??this.phoneNumber,
      isValid: isValid??this.isValid,
      status: status??this.status,);}
}