import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/assets/palette.dart';
import 'package:WrLogistics/home/transport_bloc/bloc/transport.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';
class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required AdminRepository adminRepository,
    required TransportRepository transportRepository,
    required PhoneRepository phoneAuthRepository,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _adminRepository = adminRepository,
        _transportRepository = transportRepository,
        _phoneRepository = phoneAuthRepository;

  final AuthenticationRepository _authenticationRepository;
  final AdminRepository _adminRepository;
  final TransportRepository _transportRepository;
  final PhoneRepository _phoneRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (appbloc) => AppBloc(
        authenticationRepository: _authenticationRepository,
        adminRepository: _adminRepository,
      ),
      child: Builder(
        builder: (context) => BlocProvider<TransportBloc>(
          create: (_) => TransportBloc(
            transportRepository: _transportRepository,
          ),
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: _authenticationRepository),
              RepositoryProvider.value(value: _adminRepository),
              RepositoryProvider.value(value: _transportRepository),
              RepositoryProvider.value(value: _phoneRepository)
            ],
            child: const AppView(),
          ),
        ),
      )
      );
  }
}


class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}