import 'package:digriapan_ventas/models/user_model.dart';
import 'package:flutter/material.dart';

class PantallaOrdenesDelDia extends StatefulWidget {
  const PantallaOrdenesDelDia({super.key, required user usuario});

  @override
  State<PantallaOrdenesDelDia> createState() => _PantallaOrdenesDelDiaState();
  }

  class _PantallaOrdenesDelDiaState extends State<PantallaOrdenesDelDia> {
    List<String> ordenes = ['Orden 1', 'Orden 2', 'Orden 3']; // Example list of orders

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: ordenes.length,
            itemBuilder: (context, index) {
              return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            title: Text(ordenes[index]),
          ),
              );
            },
          ),
        ),
      );
    }
  }