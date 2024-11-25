import 'package:WrLogistics/assets/palette.dart';
import 'package:WrLogistics/home/home.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';

import '../cubit/admin_edit_cubit.dart';

class AdminTransportItem extends StatelessWidget{
 const AdminTransportItem({super.key, required this.transporte});
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
              context.read<TransportBloc>().add(TransportFetched(transporte.userId));
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

bool isEditable = false;

class _TransportDetailedViewDialog extends StatefulWidget {
  final Transporte transporte;
  const _TransportDetailedViewDialog({required this.transporte});
  @override
  _TransportDetailedViewDialogState createState() =>
      _TransportDetailedViewDialogState();
}

class _TransportDetailedViewDialogState
    extends State<_TransportDetailedViewDialog> {
  Transporte get transporte => widget.transporte;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminEditCubit>(
        create: (_) => AdminEditCubit(transporte: transporte),
        child: AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                  icon: const Icon(Icons.edit)),
              const Text(
                'Editar',
                style: TextStyle(color: Colors.black),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          content: Align(
              alignment: const Alignment(0, -1 / 3),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _OriginInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  _DestinationInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  _DateStartViewer(),
                  const SizedBox(
                    height: 20,
                  ),
                  _DateTimePickerButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  _NotesInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _PaymentMethodViewer(),
                      const SizedBox(
                        width: 10,
                      ),
                      _CostViewer()
                    ],
                  ),
                  const SizedBox(height: 20),
                  _StatusSlider(),
                ],
              ))),
          actions:<Widget> [Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_SubmitChangesButton(),
            //_DiscardChangesButton(),
            //im too lazy

            ],
          )
          ],
        ));
  }
}

class _OriginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
        buildWhen: (previous, current) => previous.origin != current.origin,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                initialValue:
                    context.read<AdminEditCubit>().transporte.origin!,
                enabled: isEditable,
                onChanged: (origin) =>
                    context.read<AdminEditCubit>().originChanged(origin),
                keyboardType: TextInputType.streetAddress,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Origen',
                    hintText: 'Ingresa el origen',
                    errorText: state.origin.displayError != null
                        ? 'Dirección inválida'
                        : null,
                    errorStyle: const TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8))),
              ));
        });
  }
}

class _DestinationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
        buildWhen: (previous, current) =>
            previous.destination != current.destination,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                initialValue:
                    context.read<AdminEditCubit>().transporte.destination!,
                enabled: isEditable,
                onChanged: (destination) => context
                    .read<AdminEditCubit>()
                    .destinationChanged(destination),
                keyboardType: TextInputType.streetAddress,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Destino',
                    hintText: 'Ingresa el destino',
                    errorText: state.origin.displayError != null
                        ? 'Dirección inválida'
                        : null,
                    errorStyle: const TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8))),
              ));
        });
  }
}

class _DateStartViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
        builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            initialValue: formatDate(context
                .read<AdminEditCubit>()
                .transporte
                .dateStart!),
            enabled: false,
            style: const TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                labelText: 'Fecha creación',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                )),
          ));
    });
  }
}

class _DateTimePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
        buildWhen: (previous, current) => previous.dateWhen != current.dateWhen,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: DatePickerTheme(
                  data:
                      const DatePickerThemeData(), // selectable colors, nbot bothering with this right now
                  child: DateTimePicker(
                    enabled: isEditable,
                    decoration: InputDecoration(
                        labelText: 'Fecha seleccionada',
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8))),
                    type: DateTimePickerType.dateTimeSeparate,
                    style: const TextStyle(color: Colors.black),
                    dateMask: 'd MMM, yyyy',
                    initialValue: context
                        .read<AdminEditCubit>()
                        .transporte
                        .dateWhen
                        .toString(),

                    // DateTime.now().add(const Duration(days: 1)).toString(),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Fecha',
                    timeLabelText: "Hora",
                    calendarTitle: 'Elige la fecha del transporte',
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar, only disabled sunday for now
                      //also, skipped the half hours and time of operation validations, too complicated for now
                      // if(date.hour<8 && date.hour>22){return false;}
                      // if(date.minute!=30){
                      //   return false;
                      // }
                      if (date.weekday == 7) {
                        return false;
                      }
                      return true;
                    },
                    onChanged: (dateTime) => context
                        .read<AdminEditCubit>()
                        .dateWhenChanged(DateTime.parse(dateTime)),
                  )));
        });
  }
}

class _NotesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              initialValue: context.read<AdminEditCubit>().transporte.notes,
              enabled: isEditable,
              onChanged: (notes) =>
                  context.read<AdminEditCubit>().notesChanged(notes),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  labelText: 'Notas adicionales',
                  hintText: 'Ingresa aquí notas u observaciones adicionales...',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8))),
            ));
      },
    );
  }
}

class _PaymentMethodViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: TextFormField(
              initialValue: context
                  .read<AdminEditCubit>()
                  .transporte
                  .paymentMethod
                  ?.toShortString(),
              enabled: false,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  labelText: 'Paga con',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
        );
      },
    );
  }
}

class _CostViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminEditCubit, AdminEditState>(
        builder: (context, state) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
              initialValue:
                  context.read<AdminEditCubit>().transporte.cost.toString(),
              enabled: false,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)))),
        ),
      );
    });
  }
}

class _StatusSlider extends StatefulWidget {
  @override
  _StatusSliderState createState() => _StatusSliderState();
}

class _StatusSliderState extends State<_StatusSlider> {
  double _sliderValue = 0.0;
  late int _defaultStatusIndex;

  @override
  void initState() {
    super.initState();
    // Replace the following line with how you get the default status from the context
    // For now, I'll use a default value of 1 (confirmado) if the context value is not available.
    _defaultStatusIndex = context.read<AdminEditCubit>().transporte.status?.index ?? 1;
    _sliderValue = _defaultStatusIndex.toDouble();
  }
  Estado _getStatusFromSliderValue(double value) {
  List<Estado> statuses = [Estado.cancelado, Estado.pendiente, Estado.confirmado, Estado.enTransito, Estado.entregado];
  int index = value.toInt();
  return statuses[index];
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStatusIndicator(),
        Slider(
          value: _sliderValue,
          min: 0.0,
          max: 4.0, // Adjust the max value based on the number of statuses
          divisions: 4, // Adjust the number of divisions based on the number of statuses
          onChanged: (value) {
            setState(() {
              _sliderValue = value;
            });
            context.read<AdminEditCubit>().estadoChanged(_getStatusFromSliderValue(value));
          },
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    IconData statusIcon;
    Color statusColor;

    // Order the statuses, excluding 'cancelado' which will be last
    List<int> orderedStatusIndices = [0, 1, 2, 3, 4];
    int statusIndex = orderedStatusIndices[_sliderValue.toInt()];

    switch (statusIndex) {
      case 1:
        statusIcon = Icons.access_time;
        statusColor = Colors.orange;
        break;
      case 2:
        statusIcon = Icons.check;
        statusColor = Colors.green;
        break;
      case 3:
        statusIcon = Icons.local_shipping;
        statusColor = Colors.blue;
        break;
      case 4:
        statusIcon = Icons.check_circle_outline;
        statusColor = Colors.green;
        break;
      case 0:
        statusIcon = Icons.error;
        statusColor = Colors.red;
        break;
      default:
        statusIcon = Icons.help; // Default icon for unknown status
        statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0),
          Text(
            _getStatusString(statusIndex).toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusString(int index) {
    // Convert the status index to the corresponding status string
    // You can customize this based on your actual status enum
    switch (index) {
      case 0:
        return 'cancelado';
      case 1:
        return 'pendiente';
      case 2:
        return 'confirmado';
      case 3:
        return 'en tránsito';
      case 4:
        return 'entregado';
      default:
        return 'unknown';
    }
  }
}



class _SubmitChangesButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocBuilder<TransportBloc,TransportState>(
      builder: (context,state){
        return BlocBuilder<AdminEditCubit,AdminEditState>(
          builder: ((context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: AppColors.lightPrimary,
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 30 ),
              ),onPressed: state.isValid
              ?(){context.read<TransportBloc>().add(TransportUpdated(
                context.read<AdminEditCubit>().editTransport(
                  context.read<AdminEditCubit>().transporte.copyWith(
                    origin: state.origin.value,
                    destination: state.destination.value,
                    dateWhen: state.dateWhen,
                    notes: state.notes,
                    status: state.estado
                  )) ));Navigator.pop(context);}
              :null, 
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.save),
                  SizedBox(width: 5,),
                  Text('Guardar cambios', style: TextStyle(color:Colors.white),)
                ],
              )
            ) ;
          }));
      });
  }
}