import 'package:WrLogistics/admin/admin.dart';
import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/assets/palette.dart';
import 'package:WrLogistics/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class AdminPage extends StatelessWidget{
  const AdminPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AdminPage());

@override
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: const Text('Administración',style: TextStyle(color: Colors.white70),),
        backgroundColor: AppColors.primary,
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            onPressed: (){
              context.read<AppBloc>().add(const AppLogoutRequested());
            }, icon: const Icon(Icons.exit_to_app))
        ]
    ),body: BlocProvider(
      create:(_){final transportBloc =TransportBloc(transportRepository: context.read<TransportRepository>());
        context.read<TransportBloc>().add(TransportFetchedAll());return transportBloc;},
      child: AdminPageContent(), ),
      bottomNavigationBar: AdminBottomAppBar(),
    );
  }
}