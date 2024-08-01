import 'package:flutter/material.dart';

import '../models/modelo_detalles_pedidos.dart';
import '../models/modelo_pedido_vendedor.dart';

class PantallaInformacionPedido extends StatefulWidget {
  final pedidos pedido;
  final List<detallesPedido> detalles;
  const PantallaInformacionPedido({super.key, required this.pedido, required this.detalles});

  @override
  State<PantallaInformacionPedido> createState() => _PantallaInformacionPedidoState();
}

class _PantallaInformacionPedidoState extends State<PantallaInformacionPedido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido: ${widget.pedido.pedido}"),
        centerTitle: true,
        backgroundColor: const Color(0xFFED7914),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            informacionDelCliente(context),
            informacionDelPedido(context),
          ],
        ),
      ),
    );
  }

  Widget informacionDelCliente(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
            "Cliente: ${widget.pedido.nombre_cliente.trim()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
            "Sucursal: ${widget.pedido.nombre_sucursal.trim()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
            "Fecha: ${widget.pedido.fecha_pedido.trim()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
            "Estado: ${widget.pedido.estado_actual.trim()}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text(
            "Importe: \$${widget.pedido.importe_pedido}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
        ],
      ),
    );
  }

  Widget informacionDelPedido(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.detalles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Producto: ${widget.detalles[index].nombre_articulo}"),
                subtitle: Text("Cantidad: ${widget.detalles[index].cantidad.toStringAsFixed(0)}"),
              );
            },
          ),
        ],
      ),
    );
  }
}