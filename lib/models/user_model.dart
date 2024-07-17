// ignore_for_file: non_constant_identifier_names

// ignore: camel_case_types
class user {
    int sucursal;
  int usuario;
  int es_supervisor;
  String nombre_persona;
  String mensaje;

  user({
    required this.sucursal,
    required this.usuario,
    required this.es_supervisor,
    required this.nombre_persona,
    required this.mensaje
  });

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      sucursal: json['sucursal'] as int,
      usuario: json['usuario'] as int,
      es_supervisor: json['es_supervisor'] as int,
      nombre_persona: json['nombre_persona'] as String,
      mensaje: json['mensaje'] as String
    );
  }
}