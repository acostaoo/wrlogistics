import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';
import 'package:testing/app/app.dart';
import 'package:testing/app/home/home.dart';
import 'package:testing/assets/palete.dart';
import 'package:testing/bloc/transport_bloc.dart';

class CreateTransportForm extends StatelessWidget {
  const CreateTransportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTransportCubit, CreateTransportState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('Transporte creado con éxito !')));
          context.read<TransportBloc>().add(TransportFetched(context.select((AppBloc bloc) => bloc.state.user.id)));
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Creacción fallida')));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _OriginInput(),
            const SizedBox(height: 20),
            _DestinationInput(),
            const SizedBox(height: 20),
            _DateTimePickerButton(),
            const SizedBox(height: 20),
            const _PaymentMethodSelection(),
            const SizedBox(height: 40),
            const _CostWidget(cost: 30000),
            const SizedBox(height: 40),
            _NotesInput(),
            const SizedBox(height: 40),
            _SubmitTransportButton(),
            const SizedBox(height: 40),
            _GoBackButton(),
          ],
        ),
      ),
      )
    );
  }
}

class _OriginInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransportCubit, CreateTransportState>(
        buildWhen: (previous, current) => previous.origin != current.origin,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                onChanged: (origin) =>
                    context.read<CreateTransportCubit>().originChanged(origin),
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
    return BlocBuilder<CreateTransportCubit, CreateTransportState>(
        buildWhen: (previous, current) =>
            previous.destination != current.destination,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                onChanged: (destination) => context
                    .read<CreateTransportCubit>()
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

class _DateTimePickerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransportCubit, CreateTransportState>(
        buildWhen: (previous, current) => previous.dateWhen != current.dateWhen,
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: DatePickerTheme(
                  data:
                      const DatePickerThemeData(), // selectable colors, nbot bothering with this right now
                  child: DateTimePicker(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8))),
                    type: DateTimePickerType.dateTimeSeparate,
                    style: const TextStyle(color: Colors.black),
                    dateMask: 'd MMM, yyyy',
                    initialValue:
                        DateTime.now().add(const Duration(days: 1)).toString(),
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
                        .read<CreateTransportCubit>()
                        .dateWhenChanged(DateTime.parse(dateTime)),
                  )));
        });
  }
}

class _PaymentMethodSelection extends StatefulWidget {
  const _PaymentMethodSelection();
  @override
  _PaymentMethodSelectionState createState() => _PaymentMethodSelectionState();

  static PaymentMethod get selectedPaymentMethod =>
      _PaymentMethodSelectionState._selectedPaymentMethod;
}

class _PaymentMethodSelectionState extends State<_PaymentMethodSelection> {
  static PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildPaymentMethodRadioButton(PaymentMethod.cash, Icons.money),
          const SizedBox(
            width: 30,
          ),
          _buildPaymentMethodRadioButton(
              PaymentMethod.cardOnSite, Icons.credit_card),
          const SizedBox(
            width: 30,
          ),
          const Column(children: [
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.payment,
              color: Colors.grey,
              size: 40,
            ),
            Text(
              'Webpay',
              style: TextStyle(color: Colors.grey),
            )
          ])
          //_buildPaymentMethodRadioButton(PaymentMethod.webpay, Icons.payment),
        ]));
  }

  Widget _buildPaymentMethodRadioButton(PaymentMethod method, IconData icon) {
    return Row(children: [
      Radio(
        value: method,
        groupValue: _selectedPaymentMethod,
        onChanged: (PaymentMethod? value) {
          setState(() {
            _selectedPaymentMethod = value!;
          });
        },
      ),
      Column(
        children: [
          const SizedBox(height: 4),
          Icon(icon, size: 40), // Adjust the size according to your preference
          Text(method.toShortString(),
              style: const TextStyle(color: Colors.black)),
        ],
      )
    ]);
  }
}

TextEditingController notesController = TextEditingController();
class _NotesInput extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: TextField(
        controller: notesController,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Notas adicionales',
          hintText: 'Ingresa aquí notas u observaciones adicionales...',
          border:OutlineInputBorder(
            borderSide:const BorderSide(color:Colors.grey),
            borderRadius: BorderRadius.circular(8)
          )
        ),
      ));
  }
}

class _CostWidget extends StatelessWidget {
  final double cost;

  const _CostWidget({required this.cost});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTransportCubit, CreateTransportState>(
      builder: (context, state) {
        return Visibility(
          visible: state.isValid,
          child: SizedBox(
            width: 200, // Set the width as per your requirements
            height: 50, // Set the height as per your requirements
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                cost.toString(),
                style: const TextStyle(
                  color: Color(0xFF168118),
                  fontSize: 16, // Adjust the font size as needed
                  fontWeight: FontWeight.bold, // Adjust the font weight as needed
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



class _SubmitTransportButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Usuario user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocBuilder<CreateTransportCubit, CreateTransportState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32), // Adjust padding for a larger button
                ),
                onPressed: state.isValid
                    ? () => context
                        .read<CreateTransportCubit>()
                        .createTransport(user.id,context.select((PhoneInputCubit p)=>p.state.phoneNumber.toString()), notesController.text,_PaymentMethodSelection.selectedPaymentMethod, 30000)
                    : null,
                child: const Text(
                  'Crear Transporte',
                  style: TextStyle(
                      fontSize: 18, color: Colors.white), // Adjust font size
                ),
              );
      },
    );
  }
}

class _GoBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('goBackButton'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: AppColors.primary, // Adjust color to match your theme
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      onPressed: () {
        Navigator.of(context).pop(); // Go back action
      },
      
      child:const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      children:[
        Icon(Icons.arrow_back,color: Colors.white),
       Text('Volver',style: TextStyle(fontSize: 18, color: Colors.white),)
      ],),
    );
  }
}
