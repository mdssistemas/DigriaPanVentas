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

  buscarCliente(String nombre, int usuario) {
    DatabaseProvider.getClientes(nombre, usuario).then((resultado) {
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
        cursorColor: const Color(0xFFED7914),
        onSubmitted: (nombre){
          buscarCliente(nombre, widget.usuario.usuario);
        },
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: BorderSide(color: Color(0xFFED7914), width: 2),
          ),
          hintText: 'Buscar cliente',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          prefixIcon: Icon(Icons.search, color: Color(0xFFED7914),),
        ),
      ),
    );
  }

  Widget listaClientes(BuildContext context){
    return Expanded( // Envuelve ListView.builder en un Expanded
      child: cliente.isEmpty 
      ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.search, size: 100,),
          Text("Busca un cliente", style: TextStyle(fontSize: 20),),
        ],
      ) 
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
            subtitle: Text(clienteActual.cliente.toString()),
            onTap: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                title: const Text("Confirmar cliente seleccionado"),
                content: Text("Cliente: ${clienteActual.nombre_cliente} \nDomicilio: ${clienteActual.direccion}"),
                actions: [
                   const Text('Selecciona el estado de la visita: '),
                  // DropdownButton<String>(
                  // items: <String>['Visitado', 'Cerrado', 'Cerrado permanentemente', 'Regresar despues'].map((String value) {
                  //   return DropdownMenuItem<String>(
                  //   value: value,
                  //   child: Text(value),
                  //   );
                  // }).toList(),
                  // onChanged: (String? newValue) {
                  //   setState(() {
                  //
                  //   });
                  // },
                  // ),
                  TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Cancelar"),
                  ),
                  TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaArticulos(cliente: clienteActual, usuario: widget.usuario,)));
                  },
                  child: const Text("Aceptar"),
                  ),
                ],
                );
              },
            );
            },
        ),
          );
        },
      ),
    );
  }
}