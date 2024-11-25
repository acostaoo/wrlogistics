part of 'admin_edit_cubit.dart';

class AdminEditState extends Equatable {
  const AdminEditState({
    this.origin = const Address.pure(),
    this.destination = const Address.pure(),
    this.dateWhen,
    this.notes,
    this.status =FormzSubmissionStatus.initial,
    this.isValid = true,
    this.errorMessage,
    this.estado
  });
  final Address origin;
  final Address destination;
  final DateTime? dateWhen;
  final FormzSubmissionStatus status;
  final String? notes;
  final bool isValid;
  final String? errorMessage;
  final Estado? estado;

  @override
  List<Object?> get props => [origin,destination,dateWhen,notes,status,isValid,errorMessage,estado];
   AdminEditState copyWith({
    Address? origin,
    Address? destination,
    DateTime? dateWhen,
    String? notes,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    Estado? estado
  }) {
    return AdminEditState(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      dateWhen: dateWhen ?? this.dateWhen,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      estado: estado?? this.estado
    );
  }
}

