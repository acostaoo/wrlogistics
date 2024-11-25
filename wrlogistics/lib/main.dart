import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/firebase_options.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    //webProvider:(app) async {return FirebaseAppCheck('24FFDAB4-004B-4867-89E4-56C3A4FD07F4')},
    webProvider: ReCaptchaV3Provider('6LdqBCcpAAAAANmRZm5YISk-FvxeLLl_hsURs-0c'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest
    
  );

  final authenticationRepository = AuthenticationRepository();
  final adminRepository = AdminRepository();
  await authenticationRepository.user.first;
final transportRepository = TransportRepository();

  final PhoneRepository phoneAuthRepository=PhoneRepository();
  runApp(App(adminRepository: adminRepository,authenticationRepository: authenticationRepository,transportRepository: transportRepository,phoneAuthRepository: phoneAuthRepository,));
}
