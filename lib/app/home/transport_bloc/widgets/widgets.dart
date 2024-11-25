import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:repositories/repositories.dart';
import 'package:testing/bloc/transport_bloc.dart';

part 'transport_detailed_view.dart';

class TransportItem extends StatelessWidget {
  // this widget holds the UI of the transporte object to the user, also holds the modal that actually updates the transport in db
   const TransportItem({super.key, required this.transporte});
final Transporte transporte;

  @override
  Widget build(BuildContext context) {
    IconData statusIcon;
    Color? statusColor;

    switch (transporte.status) {
      case Estado.pendiente:
        statusIcon = Icons.access_time;
        statusColor = Colors.orange;
        break;
      case Estado.confirmado:
        statusIcon = Icons.check;
        statusColor = Colors.green;
        break;
      case Estado.enTransito:
        statusIcon = Icons.local_shipping;
        statusColor = Colors.blue;
        break;
      case Estado.cancelado:
        statusIcon = Icons.error;
        statusColor = Colors.red;
        break;
      case Estado.entregado:
        statusIcon = Icons.check_circle_outline;
        statusColor = Colors.green;
        break;
      default:
        statusIcon = Icons.info;
        statusColor = Colors.grey;
    }

    return Material(
      elevation: 3,
      child: InkWell(
        //this is the detailed view
        onTap: () {
          showDialog(context: context, builder: (context) {
            return _TransportDetailedViewDialog(transporte: transporte);
          }).then((result){
            if(result!=null){
              //this happens when a change is made 
            }
          });
        },
        //this is the widget itself
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
  children: [
    // Leading icon for status
    Icon(
      statusIcon,
      color: statusColor,
    ),
    const SizedBox(width: 16),
    // Transport details
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Origen: ${transporte.origin ?? 'No especificado.'}',
          style: TextStyle(color: statusColor),
        ),
        Text(
          'Destino: ${transporte.destination ?? 'No Especificado'}',
          style: TextStyle(color: statusColor),
        ),
        Text(
          'Fecha: ${formatDate(transporte.dateWhen)}',
          style: TextStyle(color: statusColor),
        ),
      ],
    ),
    const Spacer(), // Add this spacer to push the delete button to the other end
    IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        _showDeleteConfirmation(context);
      },
    ),
  ],
)
        )
      )
    );

  }
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminar'),
          content: const Text('Estás seguro que deseas eliminar este transporte ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _deleteTransport(context);
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            )
          ],
        );
      },
    );
  }

  Future<void> _deleteTransport(BuildContext context) async {
    BlocProvider.of<TransportBloc>(context).add(TransportDeleted(transporte));
  }

}

  String formatDate(DateTime? date) {
  return date != null ? DateFormat('dd/MM/yyyy HH:mm').format(date) : 'No especificado';
}