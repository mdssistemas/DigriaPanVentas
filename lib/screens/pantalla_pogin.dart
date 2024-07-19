import 'package:digriapan_ventas/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backend/database_connect.dart';
import '../backend/mensajes.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  bool contraseniaOscura = true;
  TextEditingController usuarioController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();

  @override
  initState() {
    super.initState();
    sesionActual();
  }

  sesionActual() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usuario = prefs.getString('usuario') ?? "";
    String contrasenia = prefs.getString('contrasenia') ?? "";
    if (usuario != "" && contrasenia != "") {
      iniciarSesion(usuario, contrasenia);
    }
  }

  iniciarSesion(String usuario, String contrasenia) {
    if (usuario == "" || contrasenia == "") {
      MensajesProvider.mensajeExtendido(context, "No hay datos", "Debes ingresar un usuario y contraseña");
    }else{
      DatabaseProvider.getUserByEmailPassword(usuario, contrasenia).then((resultado) {
        if (resultado.mensaje == "") {
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('usuario', usuarioController.text);
            prefs.setString('contrasenia', contraseniaController.text);
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaInicial(usuario: resultado,)));
        }else {
          MensajesProvider.mensajeExtendido(context, "No se pudo iniciar sesión", resultado.mensaje);
        }
      }).onError((error, stackTrace) {
        print(error.toString());
        print(stackTrace.toString());
        MensajesProvider.mensajeExtendido(context, "Error", error.toString()); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ventas Digriapan'),
        backgroundColor: const Color(0xFFED7914),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                imagenDigriapan(context),
                const SizedBox(
                  height: 40,
                ),
                campoTextoUsuario(context),
                campoTextoContrasenia(context),
                botonIniciarSesion(context),
              ],
            ),
                textoVersion(context),
          ],
        ),
      ),
    );
  }

  Widget imagenDigriapan(BuildContext context){
    return SizedBox(
  width: 600.0,
  height: 100.0,
  child: Image.asset(
    'assets/images/logo_digriapan.png',
    fit: BoxFit.fitWidth, // Ajusta la imagen al tamaño del contenedor
  ),
);

  }

  Widget textoVersion(BuildContext context){
    return const Text('Version: ${DatabaseProvider.VERSION}');
  }

  Widget campoTextoUsuario(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 16),
      child: TextFormField(
        controller: usuarioController,
        maxLines: 1,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Color(0xFFED7914)),
                  borderRadius: BorderRadius.circular(15),
                ),

          labelText: 'Ingresa tu usuario',
          labelStyle: const TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }

  Widget campoTextoContrasenia(BuildContext context){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 68, vertical: 16),
      child: TextFormField(
        controller: contraseniaController,
        maxLines: 1,
        obscureText: contraseniaOscura,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState((){
                contraseniaOscura = !contraseniaOscura;
              });
            },
            icon: Icon(
              (contraseniaOscura == true) 
              ?Icons.visibility_off
              :Icons.visibility
              ),
              color: Colors.black,
            ),

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Color(0xFFED7914)),
                  borderRadius: BorderRadius.circular(15),
                ),
          labelText: 'Contraseña',
          labelStyle: const TextStyle(
            color: Colors.black
          ),
        ),
      )
      );
  }

  Widget botonIniciarSesion(BuildContext context){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF004D40),
      ),
      label: const Text("Iniciar sesion"),
      icon: const Icon(Icons.login),
      onPressed: (){
        iniciarSesion(usuarioController.text, contraseniaController.text);
      },
    );
  }
}