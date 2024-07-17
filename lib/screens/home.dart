import 'package:digriapan_ventas/screens/pantalla_cliente.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class PantallaInicial extends StatefulWidget {
  final user usuario;
  const PantallaInicial({super.key, required this.usuario});

  @override
  State<PantallaInicial> createState() => _PantallaInicialState();
}

class _PantallaInicialState extends State<PantallaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Inicio"),
        backgroundColor: const Color(0xFFED7914),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iniciarIconoBoton(context),
            const SizedBox(height: 20),
            const Text(
              'Iniciar Viaje',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iniciarIconoBoton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaClientes(usuario: widget.usuario)),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF004D40),
        padding: const EdgeInsets.all(20),
        shape: const CircleBorder(),
      ),
      child: const Icon(
        Icons.play_circle_filled,
        size: 200.0,
        color: Colors.white,
      ),
    );
  }
}