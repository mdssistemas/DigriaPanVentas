// ignore_for_file: non_constant_identifier_names, camel_case_types

class articulos {
  int clave_articulo;
  String articulo;
  String nombre_articulo;
  String descripcion_extendida;
  String nombre_unidad;
  String clave_anterior;
  double disponible;
  double precio_base;
  double precio_sin_IVA;
  double importe_IVA;
  double cantidad;
  bool busqueda;

  articulos(
      {required this.clave_articulo,
      required this.articulo,
      required this.nombre_articulo,
      required this.descripcion_extendida,
      required this.nombre_unidad,
      required this.clave_anterior,
      required this.disponible,
      required this.precio_base,
      required this.precio_sin_IVA,
      required this.importe_IVA,
      required this.cantidad,
      required this.busqueda});

  factory articulos.fromJson(Map<String, dynamic> json) {
    return articulos(
        clave_articulo: json['clave_articulo'] as int,
        articulo: json['articulo'] as String,
        nombre_articulo: json['nombre_articulo'] as String,
        descripcion_extendida: json['descripcion_extendida'] as String,
        nombre_unidad: json['nombre_unidad'] as String,
        clave_anterior: json['clave_anterior'] as String,
        disponible: double.parse(json['disponible'].toString()),
        precio_base: double.parse(json['precio_base'].toString()),
        precio_sin_IVA: double.parse(json['precio_sin_IVA'].toString()),
        importe_IVA: double.parse(json['importe_IVA'].toString()),
        cantidad: 0,
        busqueda: true);
  }
}