import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Curso {
  final String titulo;
  final String preco;
  final String imagem;

  Curso({required this.titulo, required this.preco, required this.imagem});
}

class ComprasPage extends StatefulWidget {
  final List<Curso> cursosNoCarrinho;

  const ComprasPage({super.key, required this.cursosNoCarrinho});

  @override
  State<ComprasPage> createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  String metodoPagamento = 'credit';
  bool mostrarModal = false;

  double get subtotal {
    double total = 0;
    for (var curso in widget.cursosNoCarrinho) {
      String preco = curso.preco.replaceAll('R\$ ', '').replaceAll(',', '.');
      total += double.tryParse(preco) ?? 0;
    }
    return total;
  }

  void removerItem(int index) {
    setState(() {
      widget.cursosNoCarrinho.removeAt(index);
    });
  }

  void finalizarPagamento() {
    setState(() {
      mostrarModal = true;
    });
  }

  void fecharModal() {
    setState(() {
      mostrarModal = false;
    });
  }

  Widget _buildQRCodePix() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          // Padrão de fundo do QR Code (simulação)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: CustomPaint(
              size: const Size(150, 150),
              painter: _QRCodePainter(),
            ),
          ),
          // Centralizando o símbolo do Pix
          Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF32BCAD), // Verde oficial do Pix
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'PIX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modalContent() {
    switch (metodoPagamento) {
      case 'credit':
      case 'debit':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Informe os dados do cartão',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFA38F75)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Número do cartão'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Validade'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'CVV'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: fecharModal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF716243),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: fecharModal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      case 'pix':
      case 'boleto':
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              metodoPagamento == 'pix'
                  ? 'Código Pix gerado'
                  : 'Boleto gerado',
              style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFA38F75)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (metodoPagamento == 'pix')
              _buildQRCodePix() // QR CODE ESTILIZADO
            else
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Center(
                  child: Text(
                    'Boleto Bancário - Código: 12345.67890.12345.678900.123456.789000.1 12345.678901',
                    style: TextStyle(fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            TextField(
              decoration:
                  const InputDecoration(labelText: 'Informe seu e-mail'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: fecharModal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF716243),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Confirmar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: fecharModal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildPaymentOption(String value, String label) {
    bool selected = metodoPagamento == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          metodoPagamento = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF716243) : Colors.white,
          border: Border.all(
              color: selected ? const Color(0xFF716243) : Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.cormorantGaramond(
              color: selected ? Colors.white : const Color(0xFFA38F75),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/goldenflower.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.white54, BlendMode.overlay),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.white.withOpacity(0)),
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                color: const Color(0xFFA38F75),
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart,
                        color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Carrinho de Compras',
                      style: GoogleFonts.cormorantGaramond(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Center(
                    child: Column(
                      children: [
                        // Cartão de itens
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF7F3),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Resumo da Compra',
                                style: GoogleFonts.cormorantGaramond(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFA38F75)),
                              ),
                              const SizedBox(height: 16),
                              widget.cursosNoCarrinho.isEmpty
                                  ? const Text('Nenhum item no carrinho.')
                                  : Column(
                                      children: widget.cursosNoCarrinho
                                          .asMap()
                                          .entries
                                          .map(
                                            (entry) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 70,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            entry.value.imagem),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          entry.value.titulo,
                                                          style: GoogleFonts
                                                              .cormorantGaramond(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: const Color(
                                                                      0xFFA38F75)),
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          entry.value.preco,
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: const Color(
                                                                      0xFF716243)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        removerItem(entry.key),
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.red[100],
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4),
                                                    ),
                                                    child: const Text(
                                                      'X',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Resumo do pedido
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Resumo do Pedido',
                                style: GoogleFonts.cormorantGaramond(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFA38F75)),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Subtotal'),
                                  Text('R\$ ${subtotal.toStringAsFixed(2)}'),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Descontos'),
                                  Text('R\$ 0,00'),
                                ],
                              ),
                              const Divider(height: 16, thickness: 1),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: GoogleFonts.cormorantGaramond(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF716243)),
                                  ),
                                  Text(
                                    'R\$ ${subtotal.toStringAsFixed(2)}',
                                    style: GoogleFonts.cormorantGaramond(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF716243)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // Métodos de pagamento
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildPaymentOption(
                                      'credit', 'Cartão de Crédito'),
                                  _buildPaymentOption('debit', 'Cartão de Débito'),
                                  Row(
                                    children: [
                                      Expanded(
                                          child:
                                              _buildPaymentOption('pix', 'Pix')),
                                      const SizedBox(width: 8),
                                      Expanded(
                                          child: _buildPaymentOption(
                                              'boleto', 'Boleto')),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: finalizarPagamento,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF716243),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: Text(
                                  'Finalizar Pagamento',
                                  style: GoogleFonts.cormorantGaramond(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Modal
          if (mostrarModal)
            Positioned.fill(
              child: GestureDetector(
                onTap: fecharModal,
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {}, // bloqueia clique no conteúdo
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: _modalContent(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Classe para desenhar um QR Code simulado
class _QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Desenha padrão quadriculado simulando QR Code
    final squareSize = size.width / 15;
    
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        // Padrão aleatório para simular QR Code
        if ((i + j) % 3 == 0 || (i * j) % 5 == 0 || i % 4 == 0 && j % 4 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(
              i * squareSize,
              j * squareSize,
              squareSize - 0.5,
              squareSize - 0.5,
            ),
            paint,
          );
        }
      }
    }

    // Marcadores de posição (típicos em QR Codes)
    _drawPositionMarker(canvas, Offset(squareSize * 2, squareSize * 2), squareSize * 3);
    _drawPositionMarker(canvas, Offset(size.width - squareSize * 5, squareSize * 2), squareSize * 3);
    _drawPositionMarker(canvas, Offset(squareSize * 2, size.height - squareSize * 5), squareSize * 3);
  }

  void _drawPositionMarker(Canvas canvas, Offset offset, double size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Quadrado externo
    canvas.drawRect(Rect.fromLTWH(offset.dx, offset.dy, size, size), paint);
    
    // Quadrado interno branco
    paint.color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(offset.dx + size * 0.25, offset.dy + size * 0.25, size * 0.5, size * 0.5),
      paint,
    );
    
    // Quadrado central preto
    paint.color = Colors.black;
    canvas.drawRect(
      Rect.fromLTWH(offset.dx + size * 0.375, offset.dy + size * 0.375, size * 0.25, size * 0.25),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}