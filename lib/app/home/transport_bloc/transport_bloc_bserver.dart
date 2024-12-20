// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';

class TransportBlocObserver extends BlocObserver{
  const TransportBlocObserver();

  @override
  void onTransition(
    Bloc<dynamic,dynamic> bloc,
    Transition<dynamic,dynamic> transition
  ){
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc,Object error, StackTrace stackTrace){
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}