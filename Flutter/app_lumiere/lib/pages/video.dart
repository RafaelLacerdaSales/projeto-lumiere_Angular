
import 'package:flutter/material.dart';

// --- Theme/Color Definitions (Simulando Variáveis CSS) ---
// Em um projeto real, estas cores seriam definidas em um tema central.
const Color _corBotao = Color(0xFF8E744C); // Exemplo de cor para --cor-botao
const Color _corTitulo = Color(0xFF333333); // Exemplo de cor para --cor-titulo
const Color _corTituloDestaque = Color(0xFFB89F6B); // Exemplo de cor para --cor-titulo-destaque
const Color _corTexto = Color(0xFF555555); // Exemplo de cor para --cor-texto
const Color _fundoCaixasWorkshop = Color(0xFFF0F0F0); // Exemplo de cor para --Fundo-caixas-workshop
const Color _fundoProcedimentos = Color(0xFFDCDCDC); // Exemplo de cor para --fundo-procedimentos

// As propriedades de fonte (font-family) são ignoradas aqui ou usam a fonte padrão.

// --- Data Mockup (Simulando Propriedades de Template) ---
class Lesson {
  final int id;
  final String title;
  final String description;
  final String videoUrl; // Simulado, pois 'iframe' é o uso aqui

  Lesson({required this.id, required this.title, required this.description, required this.videoUrl});
}

final Lesson currentLesson = Lesson(
  id: 1,
  title: "Introdução ao Desenvolvimento Mobile com Flutter",
  description: "Esta aula aborda os fundamentos do Flutter, a instalação e configuração do ambiente, e a criação do primeiro projeto. Exploramos a arquitetura baseada em widgets e o conceito de Hot Reload.",
  videoUrl: "https://www.youtube.com/embed/dQw4w9WgXcQ",
);

final List<Lesson> lessons = [
  Lesson(id: 1, title: "Fundamentos do Flutter", description: "", videoUrl: ""),
  Lesson(id: 2, title: "Widgets e Layout", description: "", videoUrl: ""),
  Lesson(id: 3, title: "Navegação e Rotas", description: "", videoUrl: ""),
  Lesson(id: 4, title: "Gerenciamento de Estado", description: "", videoUrl: ""),
];

class AulaScreen extends StatefulWidget {
  const AulaScreen({Key? key}) : super(key: key);

  @override
  State<AulaScreen> createState() => _AulaScreenState();
}

class _AulaScreenState extends State<AulaScreen> {
  int _selectedLessonId = 1;

  void _selectLesson(int id) {
    setState(() {
      _selectedLessonId = id;
      // Lógica para carregar o vídeo e detalhes da aula seria implementada aqui
    });
  }

  @override
  Widget build(BuildContext context) {
    // Media query para simular a responsividade do CSS
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      // Simulando o body com background-color e padding-top
      backgroundColor: Colors.white, // Usamos white aqui, mas o CSS tinha aliceblue
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20), // Simulando mt-4
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : double.infinity), // Simulando max-width: 95%
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  // --- Layout para Desktop (Colunas 8 e 4) ---
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Conteúdo Principal (col-lg-8)
        Expanded(
          flex: 8,
          child: Column(
            children: [
              _buildAulaCard(currentLesson),
              SizedBox(height: 32),
              _buildCommentsCard(),
            ],
          ),
        ),
        SizedBox(width: 32),
        // Lista de Aulas (col-lg-4)
        Expanded(
          flex: 4,
          child: _buildSidebar(),
        ),
      ],
    );
  }

  // --- Layout para Mobile (Colunas empilhadas) ---
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Conteúdo Principal
        _buildAulaCard(currentLesson),
        SizedBox(height: 32),
        _buildCommentsCard(),
        SizedBox(height: 32),
        // Lista de Aulas (Sidebar)
        _buildSidebar(isMobile: true), // Adiciona margem top de 115px (simulação)
      ],
    );
  }

  // --- Card Principal da Aula (aula-card) ---
  Widget _buildAulaCard(Lesson lesson) {
    return Container(
      decoration: BoxDecoration(
        color: _fundoCaixasWorkshop,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_fundoCaixasWorkshop, Colors.white],
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header da Aula (aula-header)
          Container(
            padding: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _fundoProcedimentos, width: 2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Aula Badge (aula-badge)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [_corBotao, _corTituloDestaque],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Text(
                    'Aula ${lesson.id}',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                SizedBox(width: 16),
                // Card Title (card-title)
                Flexible(
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [_corTitulo, _corTituloDestaque],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // Video Container (video-container)
          Container(
            height: 480, // Altura do iframe: 480px
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              // Use um WebView para simular o iframe. Requer um pacote (ex: webview_flutter).
              // No Flutter Web, pode-se usar HtmlElementView.
              child: Container(color: Colors.grey[300], child: Center(child: Text("Simulação de Vídeo (iframe)"))),
            ),
          ),
          SizedBox(height: 32),
          // Descrição (description)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: _corTitulo, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Descrição:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _corTitulo,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _corBotao.withOpacity(0.05), // rgba(142, 116, 76, 0.05)
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: _corBotao, width: 4)),
                ),
                child: Text(
                  lesson.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: _corTexto,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Card de Comentários (comments-card) ---
  Widget _buildCommentsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título Comentários
          Row(
            children: [
              Icon(Icons.comment, color: _corTitulo, size: 24),
              SizedBox(width: 8),
              Text(
                'Comentários:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _corTitulo,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Lista de Comentários (placeholder)
          Container(
            height: 100, // Altura placeholder
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text("Lista de Comentários (id=comments-list)"),
          ),
          SizedBox(height: 16),
          // Formulário de Comentário (comment-form)
          TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Digite seu comentário...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFe9ecef), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _corBotao, width: 2),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          SizedBox(height: 24),
          // Botão Enviar Comentário
          ElevatedButton.icon(
            onPressed: () {
              // Lógica de envio de comentário
            },
            icon: Icon(Icons.send, size: 20),
            label: Text('Enviar Comentário', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Transparente para usar Decoration
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              elevation: 0,
              // Simulação do gradiente e box-shadow no botão
            ).copyWith(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return _corBotao;
                  }
                  return _corBotao; // Cor principal para o botão
                },
              ),
              overlayColor: MaterialStateProperty.all(_corTituloDestaque.withOpacity(0.1)),
              shadowColor: MaterialStateProperty.all(_corBotao.withOpacity(0.4)),
              elevation: MaterialStateProperty.all(4),
            ),
          ),
        ],
      ),
    );
  }

  // --- Barra Lateral (sidebar-modern) ---
  Widget _buildSidebar({bool isMobile = false}) {
    return Container(
      margin: isMobile ? EdgeInsets.only(top: 32) : EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isMobile ? BorderRadius.circular(20) : BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
        border: isMobile
            ? Border(top: BorderSide(color: _corBotao, width: 6))
            : Border(left: BorderSide(color: _corBotao, width: 6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min, // fit-content
        children: [
          // Sidebar Header (sidebar-header)
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_corBotao, _corTituloDestaque],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.play_circle, color: Colors.white, size: 28),
                SizedBox(width: 8),
                Text(
                  'Lista de Aulas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          // Lista de Aulas (aulas-list)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: lessons.map((lesson) {
                final isActive = lesson.id == _selectedLessonId;
                return GestureDetector(
                  onTap: () => _selectLesson(lesson.id),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isActive ? _corBotao : Colors.transparent, width: 2),
                      color: isActive
                          ? null // Usa o gradiente
                          : Colors.transparent,
                      gradient: isActive
                          ? LinearGradient(
                              colors: [_corBotao, _corTituloDestaque],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Aula Indicator (aula-indicator)
                        Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive ? Colors.white : _corBotao,
                          ),
                        ),
                        // Aula Number (aula-number)
                        Text(
                          lesson.id.toString().padLeft(2, '0'), // number:'2.0'
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: isActive ? Colors.white : _corTexto,
                          ),
                        ),
                        SizedBox(width: 16),
                        // Aula Title (aula-title)
                        Expanded(
                          child: Text(
                            lesson.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isActive ? Colors.white : _corTexto,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}