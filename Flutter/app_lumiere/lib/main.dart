import 'package:app_lumiere/pages/cadastrar.dart';
import 'package:flutter/material.dart';
import 'pages/curso_page.dart';

void main() {
  runApp(const LumiereApp());
}

class LumiereApp extends StatelessWidget {
  const LumiereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumière Estética',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5C4033),
      ),
      home: const AuthScreen(),
    );
  }
}
