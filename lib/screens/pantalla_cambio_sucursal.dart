import 'package:flutter/material.dart';

import '../models/modelos_direcciones.dart';

class PantallaCambioSucursal extends StatefulWidget {
  final List<direcciones> listaDeDirecciones;
  const PantallaCambioSucursal({super.key ,required this.listaDeDirecciones});

  @override
  State<PantallaCambioSucursal> createState() => _PantallaCambioSucursalState();
}

class _PantallaCambioSucursalState extends State<PantallaCambioSucursal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cambio de sucursal"),
        backgroundColor: const Color(0xFFED7914),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cambioDeSucursal(context),
          ],
        ),
      ),
    );
  }

  Widget cambioDeSucursal(BuildContext context) {
    return Expanded( 
      child:
        ListView.builder(
          itemCount: widget.listaDeDirecciones.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pop(context, widget.listaDeDirecciones[index]);
              },
             child: Container(
                margin: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
                ),
               child: Text(widget.listaDeDirecciones[index].direccion_ex,
                         style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                         ),
                         ),
             ),
            );
          },
        )
    );
  }


}