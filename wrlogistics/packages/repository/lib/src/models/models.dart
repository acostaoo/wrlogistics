import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

enum Estado {
  pendiente,
  confirmado,
  enTransito,
  entregado,
  cancelado,
}

extension EstadoStrings on Estado{
  String toShortString(){
    return this.toString().split('.').last;
  }
}

enum PaymentMethod {
  cash,
  webpay,
  cardOnSite,
}
extension PaymentMethodStrings on PaymentMethod{
  String toShortString(){
    switch (this){
      case PaymentMethod.cash:
      return ('Efectivo');
      case PaymentMethod.webpay:
      return ('WebPay');
      case PaymentMethod.cardOnSite:
      return ('Tarjeta en sitio');
      default:
      return ('Inválido');
    }
  }
}

@JsonSerializable()
class Transporte extends Equatable {

  const Transporte({
    this.id,
    required this.userId,
    required this.origin,
    required this.destination,
    required this.dateStart,
    required this.dateWhen,
    this.dateDone,
    this.notes,
    required this.paymentMethod,
    this.status,
    this.userPhone,
    this.cost=0
  });

  factory Transporte.fromJson(Map<String, dynamic> json) =>
      _$TransporteFromJson(json);

  Map<String, dynamic> toJson() => _$TransporteToJson(this);

  @JsonKey(includeToJson:false,includeFromJson: true) //explcity stated since i will not remember why, its at the repository level conversion to the model from the json where i need this
  final String? id;
  final String userId;
  final String? origin;
  final String? destination;
  final DateTime? dateStart;
  final DateTime? dateWhen;
  final DateTime? dateDone;
  final String? notes;
  final PaymentMethod? paymentMethod;
  final Estado? status;
  final String? userPhone;
  final double cost;
  static const empty = Transporte(id: '', userId: '', origin: '', destination: '', dateStart: null, dateWhen: null, paymentMethod: null, userPhone: '');

  bool get isEmpty => this == Transporte.empty;
  bool get isNotEmpty => this != Transporte.empty;

  @override
  List<Object?> get props => [
        id,
        userId,
        origin,
        destination,
        dateStart,
        dateWhen,
        dateDone,
        notes,
        paymentMethod,
        status,
        userPhone,
        cost
      ];

    Transporte copyWith({
    String? id,
    String? userId,
    String? origin,
    String? destination,
    DateTime? dateStart,
    DateTime? dateWhen,
    DateTime? dateDone,
    String? notes,
    PaymentMethod? paymentMethod,
    Estado? status,
    String? userPhone,
    double? cost,
  }) {
    return Transporte(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      dateStart: dateStart ?? this.dateStart,
      dateWhen: dateWhen ?? this.dateWhen,
      dateDone: dateDone ?? this.dateDone,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      userPhone: userPhone ?? this.userPhone,
      cost: cost ?? this.cost
    );
  }
}
