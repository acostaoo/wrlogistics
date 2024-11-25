import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:testing/app/home/home.dart';
import 'package:testing/assets/palete.dart';


import '../side_drawer/side_drawer.dart';
import 'create_transport_form.dart';

class CreateTransportPage extends StatelessWidget {
  const CreateTransportPage({super.key}) ;

  static Route<void> route() => MaterialPageRoute<void>(builder: (_)=>const CreateTransportPage());

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Crear transporte',style:TextStyle(color:Colors.white)),
      backgroundColor: AppColors.primary),
      drawer: const UserDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<CreateTransportCubit>(
          create: (_)=> CreateTransportCubit(context.read<TransportRepository>()),
          child: const CreateTransportForm()
        ) 
        ),
    );
  } 
}