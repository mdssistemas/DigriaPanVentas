import 'package:digriapan_ventas/backend/database_connect.dart';
import 'package:digriapan_ventas/models/user_model.dart';
import 'package:digriapan_ventas/screens/pantalla_detalle_pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../backend/mensajes.dart';
import '../models/modelo_detalles_pedidos.dart';
import '../models/modelo_pedido_vendedor.dart';

class PantallaOrdenesDelDia extends StatefulWidget {
  final user usuario;
  const PantallaOrdenesDelDia({super.key, required this.usuario});

  @override
  State<PantallaOrdenesDelDia> createState() => _PantallaOrdenesDelDiaState();
  }

  class _PantallaOrdenesDelDiaState extends State<PantallaOrdenesDelDia> {
    @override
    void initState() {
      super.initState();
      traerOrdenes();
    }
    List<pedidos> ordenes = [];
    List<detallesPedido> detalles = [];
    traerOrdenes(){
      DateTime desde = DateTime.now();
      String fecha = DateFormat('yyyyMMdd').format(desde);
      DatabaseProvider.getPedidos(widget.usuario.usuario, fecha).then((value){
        setState(() {
          ordenes = value.first;
          detalles = value.last;
        });
      })
      .onError((error, stackTrace) {
      MensajesProvider.mensajeExtendido(context, "Error", error.toString());
    });
      
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .8,
              padding: const EdgeInsets.all(10),
              child: ordenes.length == 0
                ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/images/no-results.png',
                      width: 200,
                      height: 200,
                  ),
                  Text("No se han encontrado ordenes el dia de hoy")
                ],
              )
                : ListView.builder(
                itemCount: ordenes.length,
                itemBuilder: (context, index) {
                  var pedido = ordenes[index];
                  return InkWell(
                    onTap: () {
                      List<detallesPedido> detallesDelPedido = detalles.where((element) => element.pedido == pedido.pedido).toList();
                      Navigator.push(context, MaterialPageRoute(builder:(context) => PantallaInformacionPedido(pedido: pedido, detalles: detallesDelPedido)));
                    },
                    child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                    color: Colors.grey,
                    width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text("Pedido: ${ordenes[index].pedido}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Cliente: ${ordenes[index].nombre_cliente}"),
                                    Text("Sucursal: ${ordenes[index].nombre_sucursal}"),
                                    Text("Fecha: ${ordenes[index].fecha_pedido}"),
                                    Text("Estado: ${ordenes[index].estado_actual}"),
                                  ],
                                ),
                              ),
                    ),
                  );
                },
              ),
            ),
      );
    }
  }