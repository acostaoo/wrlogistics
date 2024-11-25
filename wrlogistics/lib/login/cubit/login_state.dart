part of 'login_cubit.dart';

enum UserRole{
  admin,
  user,
}

final class LoginState extends Equatable{
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid =false,
    this.errorMessage,
    this.role = UserRole.user
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final UserRole role;

  @override
  List<Object?> get props => [email,password,status,isValid,errorMessage,role];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    UserRole? role,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      role: role ?? this.role,
    );
  }
}
