part of 'transport_bloc.dart';

enum TransportStatus { initial,isInProgress,hasError, success,failure}

final class TransportState extends Equatable{
  const TransportState({
    this.status = TransportStatus.initial,
    this.transports = const <Transporte>[],
    this.hasReachedMax = false,
  });

  final TransportStatus status;
  final List<Transporte> transports;
  final bool hasReachedMax;

  TransportState copyWith({
    TransportStatus? status,
    List<Transporte>? transports,
    bool? hasReachedMax,
  }) {
    return TransportState(
      status: status ?? this.status,
      transports: transports ?? this.transports,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString(){
    return '''TransportState { status: $status,hasReachedMax : $hasReachedMax, transports: ${transports.length} } ''';
  }

  @override
  List<Object> get props => [status,transports,hasReachedMax];
}
