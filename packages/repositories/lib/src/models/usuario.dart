import 'package:equatable/equatable.dart';
enum UserRole{
  admin,user
}
class Usuario extends Equatable{
  const Usuario({
    required this.id,
    this.photo,
    this.email,
    this.nombre,
    this.userRole,
    this.phone,
  });

  final String? email;
  final String id;
  final String? nombre;
  final UserRole? userRole;
  final String? phone;
  final String? photo;
  static const empty = Usuario(id:'');

  void set phone(phone) => this.phone =phone;
  bool get isEmpty => this == Usuario.empty;
  bool get isNotEmpty => this != Usuario.empty;
  bool get hasPhone => this.phone !=null && this.phone !='';
  bool get isAdmin => this.userRole ==UserRole.admin;


  @override
  List<Object?> get props => [email, id, nombre,phone,userRole,photo];
 }