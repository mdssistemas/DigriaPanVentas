// ignore_for_file: non_constant_identifier_names

import 'package:digriapan_ventas/backend/database_connect.dart';
import 'package:digriapan_ventas/screens/pantalla_articulos.dart';
import 'package:flutter/material.dart';

import '../backend/mensajes.dart';
import '../models/modelos_clientes.dart';
import '../models/user_model.dart';

class PantallaClientes extends StatefulWidget {
  final user usuario;

  const PantallaClientes({super.key, required this.usuario});

  @override
  State<PantallaClientes> createState() => _PantallaClientesState();
}

class _PantallaClientesState extends State<PantallaClientes> {

  List<clientes> cliente = [];

  buscarCliente(String nombre) {
    DatabaseProvider.getClientes(nombre).then((resultado) {
      setState(() {
        if (resultado.isEmpty) {
          MensajesProvider.mensajeExtendido(context, "No hubo resultados", "No se encontraron clientes con ese nombre.");
        }
        cliente = resultado;
      });
    }).onError((error, stackTrace) {
      MensajesProvider.mensajeExtendido(context, "Error", error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Clientes"),
        backgroundColor: const Color(0xFFED7914),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            buscador(context),
            const SizedBox(
              height: 10,
              ),
            listaClientes(context),
          ],
        ),
      ),
    );
  }

  Widget buscador (BuildContext context){
    return SizedBox(
      width: 340,
      child: TextField(
        onSubmitted: (nombre){
          buscarCliente(nombre);
        },
        decoration: const InputDecoration(
          hintText: 'Buscar cliente',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget listaClientes(BuildContext context){
    return Expanded( // Envuelve ListView.builder en un Expanded
      child: cliente.isEmpty 
      ? Container() 
      : ListView.builder(
        itemCount: cliente.length,
        itemBuilder: (BuildContext context, int index){
          var clienteActual = cliente[index];
          String nombre_comercial = clienteActual.nombre_comercial.trim();
          return Card(
        child: ListTile(
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.arrow_forward),
          title: Text(nombre_comercial.isNotEmpty? nombre_comercial: clienteActual.nombre_cliente.trim()),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaArticulos(cliente: clienteActual, usuario: widget.usuario,)));
          },
        ),
          );
        },
      ),
    );
  }
}