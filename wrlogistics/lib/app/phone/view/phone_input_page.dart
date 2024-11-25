import 'package:WrLogistics/app/bloc/app_bloc.dart';
import 'package:WrLogistics/app/phone/phone.dart';
import 'package:WrLogistics/app/phone/view/phone_input_form.dart';
import 'package:WrLogistics/assets/palette.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInputPage extends StatelessWidget {
  const PhoneInputPage({super.key});

  static Route<void> route(){
    return MaterialPageRoute<void>(builder: (_)=> const PhoneInputPage());
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Ingresa tu teléfono',style: const TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
        actions: <Widget>[
          IconButton(
            onPressed: (){context.read<AppBloc>().add(const AppLogoutRequested());},
             icon: const Icon(Icons.exit_to_app,color: Colors.white,)),
        ],
      ),
      body: BlocProvider(
        create: (_) => PhoneInputCubit(context.read<PhoneRepository>()),
        child: PhoneInputPageForm(),
      ),
    );
  }
}