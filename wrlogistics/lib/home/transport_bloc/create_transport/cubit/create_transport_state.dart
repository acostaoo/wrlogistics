part of 'create_transport_cubit.dart';

class CreateTransportState extends Equatable {

  const CreateTransportState({
    this.origin = const Address.pure(),
    this.destination = const Address.pure(),
    this.dateWhen,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Address origin;
  final Address destination;
  final DateTime? dateWhen;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [origin, destination, dateWhen, status, isValid];

  CreateTransportState copyWith({
    Address? origin,
    Address? destination,
    DateTime? dateWhen,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage
  }) {
    return CreateTransportState(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      dateWhen: dateWhen ?? this.dateWhen,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage??this.errorMessage
    );
  }
}
