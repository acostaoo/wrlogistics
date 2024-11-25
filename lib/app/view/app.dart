import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:testing/app/app.dart';
import 'package:testing/assets/palete.dart';
import 'package:testing/bloc/transport_bloc.dart';

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