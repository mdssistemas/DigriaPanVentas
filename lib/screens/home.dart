import 'package:digriapan_ventas/screens/pantalla_cliente.dart';
import 'package:digriapan_ventas/screens/pantalla_informacion.dart';
import 'package:digriapan_ventas/screens/pantalla_ordenes_del_dia.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class PantallaInicial extends StatefulWidget {
  final user usuario;
  const PantallaInicial({super.key, required this.usuario});

  @override
  State<PantallaInicial> createState() => _PantallaInicialState();
}

class _PantallaInicialState extends State<PantallaInicial>
    with TickerProviderStateMixin {
  double horizontalPadding = 50.0;
  double horizontalMargin = 20.0;
  int noOfIcons = 2;

  double position = 0.0;

  List<Icon> icons = [
    const Icon(Icons.home),
    const Icon(Icons.assignment),
  ];

  late AnimationController controller;
  late Animation<double> animation;

  int selected = 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 575),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    animation = Tween(begin: getEndPosition(0), end: getEndPosition(0)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    position = getEndPosition(0);

    Future.delayed(const Duration(milliseconds: 2000), () {
      controller.forward();
    });
    super.didChangeDependencies();
  }

  double getEndPosition(int index) {
    double totalMargin = 2 * horizontalMargin;
    double totalPadding = 2 * horizontalPadding;
    double valueToOnit = totalMargin + totalPadding;

    return (((MediaQuery.of(context).size.width - valueToOnit) / noOfIcons) *
                index +
            horizontalPadding) +
        (((MediaQuery.of(context).size.width - valueToOnit) / noOfIcons) / 2) -
        70;
  }

  void animateDrop(int index) {
    animation = Tween(begin: position, end: getEndPosition(index)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    controller.forward().then((value) {
      position = getEndPosition(index);
      controller.dispose();
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 375),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      PantallaClientes(usuario: widget.usuario),
      PantallaOrdenesDelDia(usuario: widget.usuario),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(selected == 0 ?"Inicio" : "Ordenes del día"),
        backgroundColor: const Color(0xFFED7914),
        automaticallyImplyLeading: false,
        leading: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PantallaInformacion()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 375),
              curve: Curves.easeOut,
              // color: colors[selected],
              child: paginas[selected],
            ),
          ),
          Positioned(
            bottom: horizontalMargin,
            left: horizontalMargin,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: AppBarPainter(x: animation.value),
                    size: Size(
                        MediaQuery.of(context).size.width -
                            (2 * horizontalMargin),
                        80.0),
                    child: SizedBox(
                      height: 120.0,
                      width: MediaQuery.of(context).size.width -
                          (2 * horizontalMargin),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          children: icons.map<Widget>((icon) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  animateDrop(icons.indexOf(icon));
                                  selected = icons.indexOf(icon);
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 575,
                                ),
                                curve: Curves.easeOut,
                                height: 105.0,
                                width: (MediaQuery.of(context).size.width -
                                        (2 * horizontalMargin) -
                                        (2 * horizontalPadding)) /
                                    noOfIcons,
                                padding: const EdgeInsets.only(
                                    bottom: 0, //17.5,
                                    top: 10), //22.5),
                                alignment: selected == icons.indexOf(icon)
                                    ? Alignment.topCenter
                                    : Alignment.bottomCenter,
                                child: Container(
                                  height: 65, //35.0,
                                  width: 65, //35.0,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 375),
                                      switchInCurve: Curves.easeOut,
                                      switchOutCurve: Curves.easeOut,
                                      child: selected == icons.indexOf(icon)
                                          ? IconTheme(
                                              key: ValueKey('yellow$icon'),
                                              data: const IconThemeData(
                                                  size: 35.0,
                                                  color: Colors.white
                                                  // color: colors[icons.indexOf(icon)],
                                                  ),
                                              child: icon,
                                            )
                                          : IconTheme(
                                              data: const IconThemeData(
                                                  size: 25.0,
                                                  color: Colors.white),
                                              key: ValueKey('white$icon'),
                                              child: icon,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class AppBarPainter extends CustomPainter {
  double x;

  AppBarPainter({this.x = 0.0});

  double height = 80.0;
  double start = 40.0;
  double end = 120.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFED7814)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0.0, start);

    path.lineTo((x) < 20.0 ? 20.0 : x, start);
    path.quadraticBezierTo(20.0 + x, start, 30.0 + x, start + 30.0);
    path.quadraticBezierTo(40.0 + x, start + 55.0, 70.0 + x, start + 55.0);
    path.quadraticBezierTo(100.0 + x, start + 55.0, 110.0 + x, start + 30.0);
    path.quadraticBezierTo(
      120.0 + x,
      start,
      (140 + x) > (size.width - 20.0) ? (size.width - 20.0) : 140.0 + x,
      start,
    );
    path.lineTo(size.width - 20.0, start);

    path.quadraticBezierTo(size.width, start, size.width, start + 25.0);
    path.lineTo(size.width, end - 25.0);
    path.quadraticBezierTo(size.width, end, size.width - 25.0, end);
    path.lineTo(25.0, end);
    path.quadraticBezierTo(0.0, end, 0.0, end - 25.0);
    path.lineTo(0.0, start + 25.0);
    path.quadraticBezierTo(0.0, start, 20.0, start);
    path.close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(70.0 + x, 50.0), 35.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
