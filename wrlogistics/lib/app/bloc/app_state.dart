part of 'app_bloc.dart';

enum AppStatus{
  authenticated,
  authenticatedAsAdmin,
  unauthenticated
}
final class AppState extends Equatable{
  const AppState._({
    required this.status,
    this.user = Usuario.empty,
    this.isAdmin = false});

  const AppState.authenticated(Usuario user)
  : this._(status: AppStatus.authenticated, user: user);

  const AppState.authenticatedAsAdmin(Usuario user)
  : this._(status: AppStatus.authenticatedAsAdmin,user: user,isAdmin: true);

  const AppState.unauthenticated(): this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final Usuario user;
  final bool isAdmin;

  @override
  List<Object> get props =>[status,user,isAdmin];
}