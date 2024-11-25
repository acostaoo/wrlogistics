import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/repositories.dart';

part 'create_transport_state.dart';

class CreateTransportCubit extends Cubit<CreateTransportState> {
  final TransportRepository _transportRepository;

  CreateTransportCubit(this._transportRepository): super(const CreateTransportState());

  void originChanged(String value) {
    final origin = Address.dirty(value);
    _validateAndEmit(origin: origin, destination: state.destination);
  }

  void destinationChanged(String value) {
    final destination = Address.dirty(value);
    _validateAndEmit(origin: state.origin, destination: destination);
  }

  void dateWhenChanged(DateTime? date) {
    _validateAndEmit(dateWhen: date);
  }

  void _validateAndEmit({
    Address? origin,
    Address? destination,
    DateTime? dateWhen,
  }) {
    final isValid = Formz.validate([origin ?? state.origin, destination ?? state.destination]);
    emit(state.copyWith(origin: origin ?? state.origin, destination: destination ?? state.destination, dateWhen: dateWhen, isValid: isValid));
  }

  Future<void> createTransport(String uid,String userPhone,String? notes,PaymentMethod? paymentMethod,double? cost) async {
    if (!state.isValid)return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try{
      final transport = Transporte(
        userId: uid,
        origin: state.origin.value,
        destination: state.destination.value,
        dateStart: DateTime.now(),
        dateWhen: state.dateWhen,
        notes: notes??'',
        paymentMethod: paymentMethod??PaymentMethod.cash,
        status: Estado.pendiente,
        userPhone: userPhone,
        cost: cost??0,
      );
        await _transportRepository.addTransportForUser(transport);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch(_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}