// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:digriapan_ventas/models/articulos_model.dart';
import 'package:http/http.dart' as http;
import '../models/modelos_clientes.dart';
import '../models/modelos_direcciones.dart';
import '../models/user_model.dart';

class DatabaseProvider{
  static const ROOT = 'https://alleatoapps.com/phpapi/digriapan_ventas.php';
  static const VERSION = "1.1.0";


  static Future<bool> pruebaConeccion() async {
    Map data = {
      'action': ""
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOT),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == "") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<user> getUserByEmailPassword(
      String usuario, String password) async {
    Map data = {
      'action': "login",
      'usuario': int.parse(usuario),
      'contrasena': password
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOT),
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      print(response.body);
      user list = user.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <user>[];
    }
  }

  static Future<List<clientes>> getClientes(String nombre) async{
    Map data = {
      'action': "busca_clientes",
      'nombre': nombre
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOT),
    headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200){
      List<clientes> jsonResponse = parseClientes (json.decode(response.body));
      return jsonResponse;
    } else {
      throw <clientes>[];
    }
  }

  static List<clientes> parseClientes(Map<String, dynamic> responseBody) {
    var response = responseBody['clientes'];
    return (response == null) ? [] : 
    response.map<clientes>((json) => clientes.fromJson(json))
        .toList();
  }

  static Future<List<dynamic>> getArticulos(int cliente) async{
    Map data = {
      'action': "busca_productos",
      'cliente': cliente
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOT),
    headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200){
      List arreglo = [];
      arreglo.add(parseArticulos(jsonDecode(response.body)));
      arreglo.add(parseDirecciones(jsonDecode(response.body)));
      return arreglo;
    } else {
      throw <articulos>[];
    }
  }

  static List<direcciones> parseDirecciones(Map<String, dynamic> responseBody) {
    return responseBody['direcciones'].map<direcciones>((json) => direcciones.fromJson(json))
        .toList();
    
  }
  
    static List<articulos> parseArticulos(Map<String, dynamic> responseBody) {
    return responseBody['articulos'].map<articulos>((json) => articulos.fromJson(json))
        .toList();
  }

  static Future<int> guardarPedido(int vendedor, int cliente, int domicilio, String comentarios, String detalles) async{
    Map data = {
      'action': "guarda_pedido",
      'vendedor': vendedor,
      'cliente': cliente,
      'domicilio': domicilio,
      'comentarios': comentarios,
      'detalles': detalles
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse(ROOT),
    headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200){
      print(response.body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return int.parse(responseBody['pedido'].toString());
    } else {
      throw 0;
    }
  }
}