import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../backend/database_connect.dart';
import 'package:audioplayers/audioplayers.dart';

class PantallaInformacion extends StatelessWidget {
  PantallaInformacion({super.key});

  final AudioPlayer _audioPlayer = AudioPlayer();

  _launchWebURL() async {
  final uri = Uri.parse('https://mds-sistemas.com');
  await launchUrl(uri);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Desarrollada por MDS sistemas'),
        backgroundColor: const Color(0xFFED7914),  
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            imagenDigriapan(context),
            version(context),
            const SizedBox(
              height: 90.0,
            ),
            textoInformacion(context),
            const SizedBox(
              height: 60.0,
            ),
            imageButton(context),
          ],
        ),
      ),
    );
  }

  Widget imagenDigriapan(BuildContext context) {
    return SizedBox(
      width: 600.0,
      height: 100.0,
      child: Image.asset(
        'assets/images/logo_digriapan.png',
        fit: BoxFit.fitWidth, // Ajusta la imagen al tamaño del contenedor
      ),
    );
  }

  Widget version(BuildContext context) {
    return const Text(
      'Version: ${DatabaseProvider.VERSION}',
      style: TextStyle(
        fontSize: 30, 
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 179, 89, 10), // Azul oscuro
      ),
    );
  }

  Widget textoInformacion(BuildContext context) {
    return const Text(
      'Aplicación desarrollada por MDS sistemas',
      style: TextStyle(
        fontSize: 18, // Azul oscuro
      ),
    );
  }

  Widget imageButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchWebURL();
      },
      onDoubleTap: () {
        _audioPlayer.play(AssetSource('sounds/villager.mp3'));
        print('cola');
      },
      child: Image.asset(
        'assets/images/search.gif',
        width: 100,
        height: 100,
      ),
    );
  }
}