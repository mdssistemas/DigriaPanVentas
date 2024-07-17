import 'package:flutter/material.dart';
import 'screens/pantalla_pogin.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ventas Digriapan',
      home: PantallaLogin(),
    );
  }
}
