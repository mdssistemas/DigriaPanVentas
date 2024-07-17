import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MensajesProvider {

  static Future<void> aviso(
      BuildContext context, String imagen, String texto, bool red) async {
    return showCupertinoDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Image.asset(
            'assets/images/' + imagen,
            height: MediaQuery.of(context).size.height * 0.15,
            fit: BoxFit.fitHeight,
          ),
          content: Text(
            texto,
            style: const TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              isDestructiveAction: red,
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  static Future<Future<bool?>> mensaje(BuildContext context, String texto) async {
    return showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(texto),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  static Future<Future<bool?>> mensajeExtendido(
      BuildContext context, String titulo, String texto) async {
    return showCupertinoDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(titulo),
          content: Text(texto),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}