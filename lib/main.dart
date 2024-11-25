import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:repositories/repositories.dart';
import 'package:testing/app/app.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

//here goes initialization of firebase and App Check

final authenticationRepository = AuthenticationRepository();
final adminRepository = AdminRepository();
final transportRepository = TransportRepository();
final phoneRepository = PhoneRepository();

runApp(App(authenticationRepository: authenticationRepository, adminRepository: adminRepository, transportRepository: transportRepository, phoneAuthRepository: phoneRepository));
}