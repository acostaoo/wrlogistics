import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository,required AdminRepository adminRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
          ?(authenticationRepository.currentUser.isAdmin
          ?AppState.authenticatedAsAdmin(authenticationRepository.currentUser)
          :AppState.authenticated(authenticationRepository.currentUser))
              : const AppState.unauthenticated(),
        )
         {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<Usuario> _userSubscription;

//TODO implementar el teléfono aquí, mucho más pertinente que en el otro bloc. qué pavada 💀

 void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
  final user = event.user;
  
  if (user.isNotEmpty) {
    if (user.isAdmin) {
      emit(AppState.authenticatedAsAdmin(user));
    } else if (!user.isAdmin) {
      emit(AppState.authenticated(user));
  } else {
    emit(const AppState.unauthenticated());
  }
  }
 }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
    emit(const AppState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

}
