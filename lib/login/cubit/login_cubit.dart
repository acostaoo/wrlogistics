import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:form_inputs/form_inputs.dart';
// import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

}
  // void emailChanged(String value) {
  //   final email = Email.dirty(value);
  //   emit(
  //     state.copyWith(
  //       email: email,
  //       isValid: Formz.validate([email, state.password]),
  //     ),
  //   );
  // }

  // void passwordChanged(String value) {
  //   final password = Password.dirty(value);
  //   emit(
  //     state.copyWith(
  //       password: password,
  //       isValid: Formz.validate([state.email, password]),
  //     ),
  //   );
  // }

//   Future<void> logInWithCredentials() async {
//     if (!state.isValid) return;
//     emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
//     try {
//       await _authenticationRepository.loginWithEmailAndPassword(
//         email: state.email.value,
//         password: state.password.value,
//       );
//       emit(state.copyWith(status: FormzSubmissionStatus.success));
//     } on LoginWithEmailAndPasswordFailure catch (e) {
//       emit(
//         state.copyWith(
//           errorMessage: e.message,
//           status: FormzSubmissionStatus.failure,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: FormzSubmissionStatus.failure));
//     }
//   }

//   Future<void> logInWithGoogle() async {
//     emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
//     try {
//       await _authenticationRepository.loginWithGoogle();
//       emit(state.copyWith(status: FormzSubmissionStatus.success));
//     } on LoginWithGoogleFailure catch (e) {
//       emit(
//         state.copyWith(
//           errorMessage: e.message,
//           status: FormzSubmissionStatus.failure,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(status: FormzSubmissionStatus.failure));
//     }
//   }
// }