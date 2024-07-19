import 'package:digriapan_ventas/models/articulos_model.dart';
import 'package:digriapan_ventas/models/modelos_clientes.dart';
import 'package:digriapan_ventas/screens/pantalla_confirmacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


import '../backend/database_connect.dart';
import '../backend/mensajes.dart';
import '../models/user_model.dart';

class PantallaArticulos extends StatefulWidget {
  final clientes cliente;
  final user usuario;
  const PantallaArticulos({super.key, required this.cliente, required this.usuario});

  @override
  State<PantallaArticulos> createState() => _PantallaArticulosState();
}

class _PantallaArticulosState extends State<PantallaArticulos> {
  List<articulos> listaDeArticulos = [];
  String nombreCliente = "";
  @override
  void initState() {
    nombreCliente = widget.cliente.nombre_comercial.isNotEmpty
    ? widget.cliente.nombre_comercial
    : widget.cliente.nombre_cliente.trim();
    super.initState();
    traerArticulos();
  }

  traerArticulos() {
    DatabaseProvider.getArticulos(widget.cliente.cliente).then((resultado) {
      setState(() {
        listaDeArticulos = resultado;
      });
    }).onError((error, stackTrace) {
      MensajesProvider.mensajeExtendido(context, "Error", error.toString());
    });
  }

  guardadoDeProductos(){
    List<articulos> articulosSeleccionados = listaDeArticulos.where((element) => element.cantidad > 0).toList();
    articulosSeleccionados.forEach((element) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaConfirmacion(listaDeArticulosSelecionados:articulosSeleccionados, informacion: widget.cliente, usuario : widget.usuario,)));      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Articulos"),
        backgroundColor: const Color(0xFFED7914),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (listaDeArticulos.every((articulo) => articulo.cantidad == 0)) {
                MensajesProvider.mensajeExtendido(context, "Sin articulos", "No hay articulos para guardar");
                return;
              }
              guardadoDeProductos();
            },
          ),],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            infoCliente(context),
            const SizedBox(height: 10),
            buscador(context),
            const SizedBox(height: 10),
            listaArticulos(context),
          ],
        ),
      ),
    );
  }

  Widget buscador (BuildContext context){
    return SizedBox(
      width: 380,
      child: TextField(
        onChanged: (String busquedaArticulo){
          setState(() {
            for (var articulo in listaDeArticulos) {
              articulo.busqueda = false;
            }
            listaDeArticulos.where((articulo) =>
            articulo.nombre_articulo.toLowerCase().contains(busquedaArticulo.toLowerCase()) 
            || articulo.articulo.toLowerCase().contains(busquedaArticulo.toLowerCase()) 
            || articulo.clave_anterior.toLowerCase().contains(busquedaArticulo.toLowerCase())).forEach((element) {
              element.busqueda = true;
            });
          });
        },
        decoration: const InputDecoration(
          hintText: 'Buscar Articulo',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget infoCliente(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [

          Text(
            "Cliente: $nombreCliente",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Direccion: ${widget.cliente.direccion}",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(widget.cliente.telefono.isEmpty? "" :
            "Telefono: ${widget.cliente.telefono}",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget listaArticulos(BuildContext context){
    return Expanded(
      child: ListView.builder(
        itemCount: listaDeArticulos.length,
        itemBuilder: (BuildContext context, int index){
          var articulo = listaDeArticulos[index];
          return articulo.busqueda? ListTile(
            trailing: Text("\$${NumberFormat("#,###,##0.00").format(articulo.precio_base)}",
            style: const TextStyle(
              fontSize: 17.0,
              )
            ),
            title: Text(articulo.nombre_articulo.trim()),
            subtitle: TextFormField(
              onChanged: (String cantidad){
                setState(() {
                  articulo.cantidad = double.parse(cantidad);
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
                ],
              decoration: const InputDecoration(
                hintText: '0',
              ),
            ),
          )
          : Container()
          ;
        },
      ),
    );
  }
}