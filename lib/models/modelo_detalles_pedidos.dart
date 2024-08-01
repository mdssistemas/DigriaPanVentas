// ignore_for_file: non_constant_identifier_names, camel_case_types

class detallesPedido {
  int pedido;
  int clave_articulo;
  String articulo;
  String nombre_articulo;
  double cantidad;
  double precio_pactado;
  double importe_impuesto;
  double importe;
  String nombre_unidad;

  detallesPedido({
    required this.pedido,
    required this.clave_articulo,
    required this.articulo,
    required this.nombre_articulo,
    required this.cantidad,
    required this.precio_pactado,
    required this.importe_impuesto,
    required this.importe,
    required this.nombre_unidad
  });

  factory detallesPedido.fromJson(Map<String, dynamic> json) {
    return detallesPedido(
      pedido: json['pedido'] as int,
      clave_articulo: json['clave_articulo'] as int,
      articulo: json['articulo'] as String,
      nombre_articulo: json['nombre_articulo'] as String,
      cantidad: double.parse(json['cantidad'].toString()),
      precio_pactado: double.parse(json['precio_pactado'].toString()),
      importe_impuesto: double.parse(json['importe_impuesto'].toString()),
      importe: double.parse(json['importe'].toString()),
      nombre_unidad: json['nombre_unidad'] as String
    );
  }
}