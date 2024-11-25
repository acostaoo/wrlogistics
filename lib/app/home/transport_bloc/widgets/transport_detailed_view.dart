part of 'widgets.dart';

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
    return BlocProvider<EditTransportCubit>(
        create: (_) => EditTransportCubit(transporte: transporte),
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
                  _StatusShower(),
                ],
              ))),
          //TODO missing actions: save changes,discard changes
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
    return BlocBuilder<EditTransportCubit, EditTransportState>(
        buildWhen: (previous, current) => previous.origin != current.origin,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                initialValue:
                    context.read<EditTransportCubit>().transporte.origin!,
                enabled: isEditable,
                onChanged: (origin) =>
                    context.read<EditTransportCubit>().originChanged(origin),
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
    return BlocBuilder<EditTransportCubit, EditTransportState>(
        buildWhen: (previous, current) =>
            previous.destination != current.destination,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                initialValue:
                    context.read<EditTransportCubit>().transporte.destination!,
                enabled: isEditable,
                onChanged: (destination) => context
                    .read<EditTransportCubit>()
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
    return BlocBuilder<EditTransportCubit, EditTransportState>(
        builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            initialValue: formatDate(context
                .read<EditTransportCubit>()
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
    return BlocBuilder<EditTransportCubit, EditTransportState>(
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
                        .read<EditTransportCubit>()
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
                        .read<EditTransportCubit>()
                        .dateWhenChanged(DateTime.parse(dateTime)),
                  )));
        });
  }
}

class _NotesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditTransportCubit, EditTransportState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              initialValue: context.read<EditTransportCubit>().transporte.notes,
              enabled: isEditable,
              onChanged: (notes) =>
                  context.read<EditTransportCubit>().notesChanged(notes),
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
    return BlocBuilder<EditTransportCubit, EditTransportState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
            child: TextFormField(
              initialValue: context
                  .read<EditTransportCubit>()
                  .transporte
                  .paymentMethod
                  ?.toShortString(),
              enabled: false,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                  labelText: 'Pagas con',
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
    return BlocBuilder<EditTransportCubit, EditTransportState>(
        builder: (context, state) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
              initialValue:
                  context.read<EditTransportCubit>().transporte.cost.toString(),
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

class _StatusShower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<EditTransportCubit, EditTransportState>(
      builder: (context, state) {
    IconData statusIcon;
    Color statusColor;

    switch (context.read<EditTransportCubit>().transporte.status!) {
      case Estado.pendiente:
        statusIcon = Icons.access_time;
        statusColor = Colors.orange;
      case Estado.confirmado:
        statusIcon = Icons.check;
        statusColor = Colors.green;
      case Estado.enTransito:
        statusIcon = Icons.local_shipping;
        statusColor = Colors.blue;
      case Estado.cancelado:
        statusIcon = Icons.error;
        statusColor = Colors.red;
      case Estado.entregado:
        statusIcon = Icons.check_circle_outline;
        statusColor = Colors.green;
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
                context.read<EditTransportCubit>().transporte.status!.toShortString().toUpperCase(),
                style:const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SubmitChangesButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocBuilder<TransportBloc,TransportState>(
      builder: (context,state){
        return BlocBuilder<EditTransportCubit,EditTransportState>(
          builder: ((context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: AppColors.lightPrimary,
                padding: const EdgeInsets.symmetric(vertical:10,horizontal: 30 ),
              ),onPressed: state.isValid
              ?()=>context.read<TransportBloc>().add(TransportUpdated(
                context.read<EditTransportCubit>().editTransport(
                  context.read<EditTransportCubit>().transporte.copyWith(
                    origin: state.origin.value,
                    destination: state.destination.value,
                    dateWhen: state.dateWhen,
                    notes: state.notes
                  )) ))
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