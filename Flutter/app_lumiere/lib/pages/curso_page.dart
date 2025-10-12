import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Curso {
  final String titulo;
  final String preco;
  final String imagem;
  final double avaliacao;

  Curso({
    required this.titulo,
    required this.preco,
    required this.imagem,
    required this.avaliacao,
  });
}

class CursosPage extends StatefulWidget {
  const CursosPage({super.key});

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  final List<Curso> cursos = [
    Curso(
      titulo: 'Design de Sobrancelhas',
      preco: 'R\$ 249,90',
      imagem: 'https://picsum.photos/400/300?1',
      avaliacao: 4.7,
    ),
    Curso(
      titulo: 'Limpeza de Pele Profunda',
      preco: 'R\$ 299,90',
      imagem: 'https://picsum.photos/400/300?2',
      avaliacao: 4.9,
    ),
    Curso(
      titulo: 'Massagem Relaxante',
      preco: 'R\$ 199,90',
      imagem: 'https://picsum.photos/400/300?3',
      avaliacao: 4.6,
    ),
    Curso(
      titulo: 'Extensão de Cílios',
      preco: 'R\$ 349,90',
      imagem: 'https://picsum.photos/400/300?4',
      avaliacao: 5.0,
    ),
  ];

  int cartItemCount = 0;

  void comprar(Curso curso) {
    setState(() {
      cartItemCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${curso.titulo} adicionado ao carrinho!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (width < 1100 && width > 700) {
      crossAxisCount = 3;
    } else if (width <= 700) {
      crossAxisCount = 2;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFBEC0C2),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C4033),
        title: Text(
          '📒 Cursos Disponíveis 📒',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.65, // cards menores e mais verticais
                  ),
                  itemCount: cursos.length,
                  itemBuilder: (context, index) {
                    final curso = cursos[index];
                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoveredIndex = index),
                      onExit: (_) => setState(() => _hoveredIndex = null),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: _hoveredIndex == index ? 1.05 : 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFDDDDDD)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // IMAGEM - 70% DO CARD
                              Expanded(
                                flex: 7,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    curso.imagem,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // CONTEÚDO - 30% DO CARD
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            curso.titulo,
                                            style:
                                                GoogleFonts.cormorantGaramond(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF5C4033),
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 3),
                                          RatingBarIndicator(
                                            rating: curso.avaliacao,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Color(0xFFB4690E),
                                            ),
                                            itemCount: 5,
                                            itemSize: 10,
                                            unratedColor: Colors.grey[300],
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            curso.preco,
                                            style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF5C4033),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 22,
                                        child: ElevatedButton(
                                          onPressed: () => comprar(curso),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF5C4033),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                          ),
                                          child: Text(
                                            'Comprar',
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // BOTÃO FIXO DO CARRINHO
          Positioned(
            bottom: 25,
            right: 25,
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF5C4033),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                if (cartItemCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE74C3C),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int? _hoveredIndex;
}
