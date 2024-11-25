import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.unauthenticated()) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
  }

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    final user = event.user;

    if (user.isNotEmpty) {
      if (user.isAdmin) {
        emit(AppState.authenticatedAsAdmin(user));
      } else {
        emit(AppState.authenticated(user));
      }
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unauthenticated());
  }

  // New method to simulate user login
  void simulateUserLogin({required bool isAdmin}) {
    final mockUser = MockUser(
      uid: 'mock123',
      email: 'mock@example.com',
      displayName: 'Mock User',
    );

    add(_AppUserChanged(mockUser.toUser));
  }
}

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    emit(const AppState.unauthenticated());
  }

  extension on MockUser{
   Usuario get toUser{  
       return Usuario(id: uid,email: email,nombre: displayName,phone: phoneNumber??'',userRole: UserRole.user);
   }
   Usuario get toAdmin{
    return Usuario (id: uid,email: email,nombre: displayName, userRole: UserRole.admin,phone: phoneNumber??'');
   }
 }

