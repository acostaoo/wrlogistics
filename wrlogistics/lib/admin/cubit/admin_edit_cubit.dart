import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

part 'admin_edit_state.dart';

class AdminEditCubit extends Cubit<AdminEditState> {
  AdminEditCubit({required this.transporte}) : super(const AdminEditState());
  final Transporte transporte;

  void notesChanged(String value){
    _validateAndEmit(notes:value);
  }

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
  void estadoChanged(Estado? estado){
    _validateAndEmit(estado:estado);
  }

  void _validateAndEmit({
    Address? origin,
    Address? destination,
    DateTime? dateWhen,
    String? notes,
    Estado? estado
  }) {
    final isValid = Formz.validate([origin ?? state.origin, destination ?? state.destination]);
    emit(state.copyWith(origin: origin ?? state.origin, destination: destination ?? state.destination, dateWhen: dateWhen,notes: notes??state.notes, isValid: isValid,estado: estado??state.estado));
  }



  Transporte editTransport(Transporte oldTransport) {
    if (!state.isValid)return oldTransport;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try{
      final newTransport = oldTransport.copyWith(
        origin: state.origin.value,
        destination: state.destination.value,
        dateWhen: state.dateWhen,
        notes: state.notes,
        status: state.estado
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));;
      return newTransport;
    } catch(_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      return oldTransport;
    }
  }
}

