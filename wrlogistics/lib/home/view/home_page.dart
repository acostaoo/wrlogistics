import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/assets/palette.dart';
import 'package:WrLogistics/home/home.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:WrLogistics/app/phone/cubit/phone_input_cubit.dart';
import 'package:WrLogistics/home/side_drawer/side_drawer.dart';
import 'package:repository/repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneInputCubit>(
      create: (context) => PhoneInputCubit(
        RepositoryProvider.of<PhoneRepository>(context),
      ),
      child: BlocBuilder<PhoneInputCubit, PhoneInputState>(
        builder: (context, phoneState) {
          final AppBloc bloc = context.select((AppBloc bloc) => bloc);
          return FutureBuilder<String>(
            future: context.read<PhoneInputCubit>().getPhoneNumber(bloc.state.user.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                final phone = snapshot.data ?? '';
                if (phone.isEmpty) {
                  return const PhoneInputPage();
                } else {
                  return BlocProvider<TransportBloc>(
                    create: (_) => TransportBloc(
                      transportRepository: RepositoryProvider.of<TransportRepository>(context),
                    )..add(TransportFetched(bloc.state.user.id)),
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('Hogar',style: TextStyle(color:Colors.white),),
                        backgroundColor: AppColors.primary,
                        actions: <Widget>[
                          IconButton(
                            onPressed: () {
                              context.read<AppBloc>().add(const AppLogoutRequested());
                            },
                            icon: const Icon(Icons.exit_to_app,color: Colors.white,),
                          ),
                        ],
                      ),
                      drawer: const UserDrawer(),
                      body:const Align(
                        alignment:Alignment(0,-1/3),
                        child:SingleChildScrollView( child:Column(
                            mainAxisSize: MainAxisSize.min,
                          children:[
                         HomePageContent(),
                      SizedBox(height: 20),
                      ]
                    )
                    )
                    )
                    ,floatingActionButton: _CreateButton(),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                    )
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportBloc, TransportState>(
      builder: (context, state) {
        //final Usuario user = context.select((AppBloc bloc) => bloc.state.user);
        switch (state.status) {
          case TransportStatus.isInProgress:
            return const Center(child: CircularProgressIndicator());
          case TransportStatus.initial:
              return const Center(child: Text('No hay transportes asignados aún :('));
            case TransportStatus.success:
            if (state.transports.isNotEmpty) {
              return const TransportList();
            } else if (state.transports.isEmpty) {
            }
            break;
          case TransportStatus.hasError:
            return const Center(child: Text('Algo salió mal'));
          default:
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied,
                    size: 80,
                    color: AppColors.secondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No hay información disponible.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
        }
        return Text(
  '¡Bienvenido! Aún no hay datos disponibles.\n¡Crea un transporte para empezar!',
  style: TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primary, 
  ),
  textAlign: TextAlign.center,
);

      },
    );
  }
}

class TransportList extends StatefulWidget{
  const TransportList({super.key});

  @override
  State<TransportList> createState()=> _TransportListState();
}

class _TransportListState extends State<TransportList>{
  final _scrollController = ScrollController();

  @override
  void initState(){
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  @override
  Widget build(BuildContext context){
    return BlocBuilder<TransportBloc, TransportState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount:state.hasReachedMax?
          state.transports.length
          :state.transports.length+1,
          itemBuilder: (BuildContext context,int index){
            return index>= state.transports.length ? null: TransportItem(transporte: state.transports[index]);
          });
      },
    );
  }
  @override
  void dispose(){
    _scrollController..removeListener(_onScroll)..dispose();
    super.dispose();
  }

  void _onScroll(){
    if (_isBottom) context.read<TransportBloc>().add(TransportFetched(context.select((AppBloc bloc) => bloc.state.user.id)));
  }

  bool get _isBottom{
    if(!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll>=(maxScroll*0.8);
  }
}
   class _CreateButton extends StatelessWidget{
    @override build(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push<void>(CreateTransportPage.route());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Choose your desired color
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: Colors.black,
        elevation: 5,
      ),
      child:const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'Crear transporte',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
   }