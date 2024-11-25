part of 'edit_transport_cubit.dart';

class EditTransportState extends Equatable {
  const EditTransportState({
    this.origin = const Address.pure(),
    this.destination = const Address.pure(),
    this.dateWhen,
    this.notes,
    this.status =FormzSubmissionStatus.initial,
    this.isValid = true,
    this.errorMessage
  });
  final Address origin;
  final Address destination;
  final DateTime? dateWhen;
  final FormzSubmissionStatus status;
  final String? notes;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [origin,destination,dateWhen,notes,status,isValid,errorMessage];
   EditTransportState copyWith({
    Address? origin,
    Address? destination,
    DateTime? dateWhen,
    String? notes,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return EditTransportState(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      dateWhen: dateWhen ?? this.dateWhen,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

