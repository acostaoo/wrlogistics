// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transporte _$TransporteFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Transporte',
      json,
      ($checkedConvert) {
        final val = Transporte(
          id: $checkedConvert('id', (v) => v as String?),
          userId: $checkedConvert('user_id', (v) => v as String),
          origin: $checkedConvert('origin', (v) => v as String?),
          destination: $checkedConvert('destination', (v) => v as String?),
          dateStart: $checkedConvert('date_start',
              (v) => v == null ? null : DateTime.parse(v as String)),
          dateWhen: $checkedConvert('date_when',
              (v) => v == null ? null : DateTime.parse(v as String)),
          dateDone: $checkedConvert('date_done',
              (v) => v == null ? null : DateTime.parse(v as String)),
          notes: $checkedConvert('notes', (v) => v as String?),
          paymentMethod: $checkedConvert('payment_method',
              (v) => $enumDecodeNullable(_$PaymentMethodEnumMap, v)),
          status: $checkedConvert(
              'status', (v) => $enumDecodeNullable(_$EstadoEnumMap, v)),
          userPhone: $checkedConvert('user_phone', (v) => v as String?),
          cost: $checkedConvert('cost', (v) => (v as num?)?.toDouble() ?? 0),
        );
        return val;
      },
      fieldKeyMap: const {
        'userId': 'user_id',
        'dateStart': 'date_start',
        'dateWhen': 'date_when',
        'dateDone': 'date_done',
        'paymentMethod': 'payment_method',
        'userPhone': 'user_phone'
      },
    );

Map<String, dynamic> _$TransporteToJson(Transporte instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'origin': instance.origin,
      'destination': instance.destination,
      'date_start': instance.dateStart?.toIso8601String(),
      'date_when': instance.dateWhen?.toIso8601String(),
      'date_done': instance.dateDone?.toIso8601String(),
      'notes': instance.notes,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod],
      'status': _$EstadoEnumMap[instance.status],
      'user_phone': instance.userPhone,
      'cost': instance.cost,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.webpay: 'webpay',
  PaymentMethod.cardOnSite: 'cardOnSite',
};

const _$EstadoEnumMap = {
  Estado.pendiente: 'pendiente',
  Estado.confirmado: 'confirmado',
  Estado.enTransito: 'enTransito',
  Estado.entregado: 'entregado',
  Estado.cancelado: 'cancelado',
};
