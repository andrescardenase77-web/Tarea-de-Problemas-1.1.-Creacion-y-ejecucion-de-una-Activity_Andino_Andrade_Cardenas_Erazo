import 'package:flutter/material.dart';
import 'pantallas/pantalla_principal.dart';
import 'pantallas/ejercicio6_pantalla.dart';
// import 'pantallas/ejercicio7_pantalla.dart';
// import 'pantallas/ejercicio8_pantalla.dart';
import 'pantallas/ejercicio9_pantalla.dart';
import 'pantallas/ejercicio10_pantalla.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea 1.1 - NRC 36873',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PantallaPrincipal(),
        '/ejercicio6': (context) => const Ejercicio6Pantalla(),
        // '/ejercicio7': (context) => const Ejercicio7Pantalla(),
        // '/ejercicio8': (context) => const Ejercicio8Pantalla(),
        '/ejercicio9': (context) => const Ejercicio9Pantalla(),
        '/ejercicio10': (context) => const Ejercicio10Pantalla(),
      },
    );
  }
}