import 'package:WrLogistics/admin/widgets/admin_transport_item.dart';
import 'package:WrLogistics/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class AdminPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context){
        context.read<TransportBloc>().add(TransportFetchedAll());
    return BlocBuilder<TransportBloc, TransportState>(
      builder: (context, state) {
        if(state.transports.isNotEmpty){
          
        return TransportList();}
        else{return Text('nada',style: TextStyle(color: Colors.black),);}
      },
    );
  }
}

DateTime today = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
DateTime tomorrow = today.add(const Duration(days: 1)); 
class TransportList extends StatelessWidget {
  const TransportList({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportBloc, TransportState>(
      builder: (context, state) {
        Map<DateTime, List<Transporte>> groupedTransports = {};

        // Group transports by date
        for (var transport in state.transports) {
          DateTime transportDate = transport.dateWhen ?? DateTime.now();
          DateTime keyDate = DateTime(transportDate.year, transportDate.month, transportDate.day);
          if (!groupedTransports.containsKey(keyDate)) {
            groupedTransports[keyDate] = [];
          }

          groupedTransports[keyDate]!.add(transport);
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: groupedTransports.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime currentDate = groupedTransports.keys.elementAt(index);

            // Determine the label based on the date
            String label = '';
            if (DateUtils.isSameDay(currentDate, today)) {
              label = 'Hoy';
            } else if (DateUtils.isSameDay(currentDate, tomorrow)) {
              label = 'Mañana';
            } else {
              label = 'Siguientes';
            }

            return Column(
              children: [
                DateLabelSeparator(label: label),
                if (groupedTransports[currentDate] != null && groupedTransports[currentDate]!.isNotEmpty)
                  for (var transport in groupedTransports[currentDate]!)
                  AdminTransportItem(transporte: transport)
                else
                  Text(
                    'No hay transportes para esta categoría',
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
class AdminBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BlocBuilder<TransportBloc, TransportState>(
        builder: (context, state) {
          double pendientesContador=0;
          double hoyContador =0;
          double mamanaContador = 0;
          double ingresoTotal=0;
          List<Transporte> transports = state.transports;
          for(var transport in transports){
            if(DateUtils.isSameDay(transport.dateWhen!, today)){
              hoyContador++;
            }if(DateUtils.isSameDay(transport.dateWhen, tomorrow)){
              mamanaContador++;
            }if(transport.status==Estado.pendiente){
              pendientesContador++;
            }
            ingresoTotal+=transport.cost;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Contador('Pendientes', pendientesContador),
              _Contador('Para Hoy', hoyContador),
              _Contador('Para Mañana', mamanaContador),
              _Contador('Ingreso Total', ingresoTotal),
            ]
          );
        },
      ),
    );
  }
}

Widget _Contador(String label, double value) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.blueGrey),
      ),
      SizedBox(height: 4),
      Text(
        value.toString(),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}


  
class DateLabelSeparator extends StatelessWidget {
  final String label;

  const DateLabelSeparator({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
