import 'package:flutter/material.dart';
import 'pages/compras.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cursosTeste = [
      Curso(
        titulo: 'Design de Sobrancelhas',
        preco: 'R\$ 249,90',
        imagem: 'https://picsum.photos/100/100?1',
      ),
      Curso(
        titulo: 'Limpeza de Pele Profunda',
        preco: 'R\$ 299,90',
        imagem: 'https://picsum.photos/100/100?2',
      ),
      Curso(
        titulo: 'Massagem Relaxante',
        preco: 'R\$ 199,90',
        imagem: 'https://picsum.photos/100/100?3',
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComprasPage(cursosNoCarrinho: cursosTeste),
    );
  }
}
