// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'transport_event.dart';
part 'transport_state.dart';

class TransportBloc extends Bloc<TransportEvent,TransportState>{
  TransportBloc({required TransportRepository transportRepository})
  :_transportRepository = transportRepository,
    super(const TransportState()){
      on<TransportFetched>(_onTransportFetched);
      on<TransportCreated>(_onTransportCreated);
      on<TransportDeleted>(_onTransportDeleted);
      on<TransportUpdated>(_onTransportUpdated);
      on<TransportFetchedAll>(_onTransportFetchedAll);
    }

    Future<void> _onTransportFetched(TransportFetched event, Emitter<TransportState> emit) async{
      if(state.hasReachedMax) return;
      try{
        if (state.status == TransportStatus.initial){
          final transports = await _fetchTransports(event.uid);
          return emit(state.copyWith(
            status:TransportStatus.success,
            transports: transports,
            hasReachedMax: false
          ));
        }
        final transports = await _fetchTransports(event.uid,state.transports.length);
        emit(transports.isEmpty?state.copyWith(hasReachedMax: true)
        :state.copyWith(
          status: TransportStatus.success,
          transports: List.of(state.transports)..addAll(transports),
          hasReachedMax: false
        ));
      }catch(_){
        // ignore: avoid_print
        print(_);
        emit(state.copyWith(status: TransportStatus.failure));
      } 
    }

    Future<void> _onTransportCreated(TransportCreated event, Emitter<TransportState> emitter) async{
      try{
        await _transportRepository.addTransportForUser(event.transporte);
        final updatedTransports = await _fetchTransports(event.transporte.userId);
        emit(state.copyWith(
          status: TransportStatus.success,
          transports: updatedTransports,
          hasReachedMax: false));
      }catch(_){
        emit(state.copyWith(status: TransportStatus.failure));
      }
    }

    Future<void> _onTransportDeleted(TransportDeleted event, Emitter<TransportState> emitter) async{
      try{
        await _transportRepository.deleteTransport(event.transporte.id!);
        final updatedTransports = await _fetchTransports(event.transporte.userId);
        emit(state.copyWith(
          status: TransportStatus.success,
          transports: updatedTransports,
          hasReachedMax: false));
      }catch(_){
        // ignore: avoid_print
        print(_);
        emit(state.copyWith(status: TransportStatus.failure));
      }
    }

      final TransportRepository _transportRepository;

      Future<List<Transporte>> _fetchTransports(String uid,[int startIndex = 0]) async{
         return await _transportRepository.getTransportsForUser(uid);
      }
      Future<List<Transporte>> _fetchAllTransports() async{
        return await _transportRepository.fetchAllTransports();
      }

  FutureOr<void> _onTransportUpdated(TransportUpdated event, Emitter<TransportState> emit) async{
    try{
      await _transportRepository.updateTransport(event.transporte);
      final updatedTransports = await _fetchTransports(event.transporte.userId);
      emit(state.copyWith(
        status: TransportStatus.success,
        transports: updatedTransports,
        hasReachedMax: false
      ));
    }catch(_){
      print(_.toString());
      emit(state.copyWith(status:TransportStatus.failure));
    }

  }

  FutureOr<void> _onTransportFetchedAll(TransportFetchedAll event, Emitter<TransportState> emit) async {
     if(state.hasReachedMax) return;
      try{
        if (state.status == TransportStatus.initial){
          final transports = await _fetchAllTransports();
          return emit(state.copyWith(
            status:TransportStatus.success,
            transports: transports,
            hasReachedMax: false
          ));
        }
        final transports = await _fetchAllTransports();
        emit(transports.isEmpty?state.copyWith(hasReachedMax: true)
        :state.copyWith(
          status: TransportStatus.success,
          transports: List.of(state.transports)..addAll(transports),
          hasReachedMax: false
        ));
      }catch(_){
        // ignore: avoid_print
        print(_);
        emit(state.copyWith(status: TransportStatus.failure));
      } 
}
}