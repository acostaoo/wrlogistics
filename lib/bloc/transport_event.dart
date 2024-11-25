part of 'transport_bloc.dart';

sealed class TransportEvent extends Equatable{
  @override
  List<Object> get props=>[];
}

final class TransportFetched extends TransportEvent{
  final String uid;
  TransportFetched(this.uid);
}

class TransportCreated extends TransportEvent{
  final Transporte transporte;

  TransportCreated(this.transporte);

  @override
  List<Object> get props => [transporte];
}

class TransportUpdated extends TransportEvent{
  final Transporte transporte;

  TransportUpdated(this.transporte);

  @override
  List<Object> get props => [transporte];
}

class TransportDeleted extends TransportEvent{
  final Transporte transporte;

  TransportDeleted(this.transporte);

  @override
  List<Object> get props=> [transporte];
}

class TransportFetchedAll extends TransportEvent{}