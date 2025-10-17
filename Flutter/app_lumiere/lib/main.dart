import 'package:flutter/material.dart';
import 'pages/compras.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumière Estética',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5C4033),
      ),
      home: const ComprasPage(cursosNoCarrinho: []), // LISTA VAZIA INICIAL
    );
  }
}