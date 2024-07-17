// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:digriapan_ventas/backend/database_connect.dart';
import 'package:digriapan_ventas/models/modelos_clientes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../backend/mensajes.dart';
import '../models/articulos_model.dart';
import '../models/user_model.dart';

class PantallaConfirmacion extends StatefulWidget {
  final List<articulos> listaDeArticulosSelecionados;
  final clientes informacion;
  final user usuario;
  const PantallaConfirmacion({super.key, required this.listaDeArticulosSelecionados, required this.informacion, required this.usuario});

  @override
  State<PantallaConfirmacion> createState() => _PantallaConfirmacionState();
}

class _PantallaConfirmacionState extends State<PantallaConfirmacion> {
  TextEditingController comentariosController = TextEditingController();

   guardadoDePedido(){
    String detalles = "";
    widget.listaDeArticulosSelecionados.forEach((element) {
      detalles += "${element.clave_articulo}|${element.cantidad}|${element.precio_sin_IVA}|${element.importe_IVA}Ç";
    });
    DatabaseProvider.guardarPedido(widget.informacion.cliente, widget.usuario.usuario, comentariosController.text, detalles).then((value) {
      if (value != 0){
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        MensajesProvider.mensajeExtendido(context, "Pedido guardado", "El pedido #${NumberFormat("#,###,###").format(value)} ha sido guardado con éxito");
      } else {
        MensajesProvider.mensajeExtendido(context, "Ha ocurrido un problema", "No se pudo guardar el pedido");
      }
    }).onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());
      MensajesProvider.mensajeExtendido(context, "Error", error.toString());
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmacion del pedido"),
        backgroundColor: const Color(0xFFED7914),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          informacionCliente(context),
          detallesDelPedido(context),
          comentariosContainer(context),
          totalContainer(context),
        ],
      ),
    );
  }

  Widget informacionCliente (BuildContext context){
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cliente:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            widget.informacion.nombre_cliente.trim(),
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Dirección:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            widget.informacion.direccion.trim(),
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Teléfono:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(widget.informacion.telefono.isEmpty? "No disponible" :
            widget.informacion.telefono.trim(),
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget detallesDelPedido (BuildContext context){
    return Expanded(
      child: ListView.builder(
        itemCount: widget.listaDeArticulosSelecionados.length,
        itemBuilder: (context, index){
          var articuloAgregado = widget.listaDeArticulosSelecionados[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(articuloAgregado.nombre_articulo.trim()),
              subtitle: Text("Cantidad: ${NumberFormat("#,###,##0.##").format(articuloAgregado.cantidad)}"),
              trailing: Text("Precio: \$${articuloAgregado.precio_base * articuloAgregado.cantidad}"),
            ),
          );
        },
      ),
    );
  }

  Widget comentariosContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          TextFormField(
            controller: comentariosController,
            decoration: InputDecoration(
              hintText: "Escribe tus comentarios aquí",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget totalContainer (BuildContext context){
    double total = 0;
    widget.listaDeArticulosSelecionados.forEach((element) {
      total += element.precio_base * element.cantidad;
    });

    return Container(
      alignment: Alignment.bottomLeft,
      margin: const EdgeInsets.all(25.0),
      padding: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: const Color(0xFFED7914),
      ),
      child: Row(
        children: [
          Text("Total: \$$total",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,)),
          Expanded(child: Container()),
          FloatingActionButton.extended(
            splashColor: const Color(0xFFBA5A07),
            backgroundColor: Colors.white,
            label: const Text(
              "Terminar",
              style: TextStyle(
                color: Colors.black,
              
              ),),
            onPressed: (){
              guardadoDePedido();
            },
            icon: const Icon(
              Icons.check,
              color: Colors.black,
              )
            )
        ],
      ),
      );
  }
}