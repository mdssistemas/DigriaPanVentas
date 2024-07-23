
// ignore_for_file: non_constant_identifier_names, camel_case_types

class direcciones {
  int domicilio;
  String direccion_ex;

  direcciones({
    required this.domicilio,
    required this.direccion_ex
  });
  

  factory direcciones.fromJson(Map<String, dynamic> json) {
    return direcciones(
        domicilio: json['domicilio'] as int,
        direccion_ex: json['direccion_ex'] as String
    );
  }
}