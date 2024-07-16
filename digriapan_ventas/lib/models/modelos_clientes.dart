// ignore_for_file: non_constant_identifier_names, camel_case_types

class clientes {
  int cliente;
  String nombre_cliente;
  String nombre_comercial;
  String direccion;
  String telefono;

  clientes({
    required this.cliente,
    required this.nombre_cliente,
    required this.nombre_comercial,
    required this.direccion,
    required this.telefono
  });

  factory clientes.fromJson(Map<String, dynamic> json) {
    return clientes(
        cliente: json['cliente'] as int,
        nombre_cliente: json['nombre_cliente'] as String,
        nombre_comercial: json['nombre_comercial'] as String,
        direccion: json['direccion'] as String,
        telefono: json['telefono'] as String
    );
  }
}