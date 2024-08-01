// ignore_for_file: non_constant_identifier_names, camel_case_types

class pedidos {
  int pedido;
  int cliente;
  String sucursal;
  String fecha_pedido;
  double importe_pedido;
  String estado_actual;
  String nombre_cliente;
  String nombre_sucursal;

  pedidos({
    required this.pedido,
    required this.cliente,
    required this.sucursal,
    required this.fecha_pedido,
    required this.importe_pedido,
    required this.estado_actual,
    required this.nombre_cliente,
    required this.nombre_sucursal,
  });

  factory pedidos.fromJson(Map<String, dynamic> json) {
    return pedidos(
      pedido: json['pedido'] as int,
      cliente: json['cliente'] as int,
      sucursal: json['sucursal'] as String,
      fecha_pedido: json['fecha_pedido'] as String,
      importe_pedido: double.parse(json['importe_pedido'].toString()),
      estado_actual: json['estado_actual'] as String,
      nombre_cliente: json['nombre_cliente'] as String,
      nombre_sucursal: json['nombre_sucursal'] as String,
    );
  }
}