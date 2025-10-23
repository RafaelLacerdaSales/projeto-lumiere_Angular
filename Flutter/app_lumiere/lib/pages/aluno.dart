
import 'package:flutter/material.dart';

// --- Theme/Color Definitions (Simulando Variáveis CSS) ---
// Em um projeto Flutter real, estas cores seriam definidas no ThemeData.
const Color _corBotao = Color(0xFF8E744C); // Exemplo de cor para --cor-botao
const Color _corTituloDestaque = Color(0xFFB89F6B); // Exemplo de cor para --cor-titulo-destaque
const Color _corTitulo = Color(0xFF333333); // Exemplo de cor para --cor-titulo
const Color _corTexto = Color(0xFF555555); // Exemplo de cor para --cor-texto
const Color _fundoCertificados = Color(0xFFF9F6F1); // Exemplo de cor para --fundo-certificados (cor clara)
const Color _fundoSobre = Color(0xFFF3F7F9); // Exemplo de cor para --fundo-sobre

// --- Data Mockup (Simulando Dados de Template) ---
class Certificado {
  final String nome;
  final String data;
  final IconData icon;

  Certificado({required this.nome, required this.data, required this.icon});
}

class Usuario {
  final String nome;
  final String email;
  final String cargo;

  Usuario({required this.nome, required this.email, required this.cargo});
}

class Curso {
  final String titulo;
  final int aulasCompletas;
  final int totalAulas;
  final double progresso;
  final IconData icon;

  Curso({
    required this.titulo,
    required this.aulasCompletas,
    required this.totalAulas,
    required this.progresso,
    required this.icon,
  });
}

final Usuario usuarioMock = Usuario(
  nome: "Maria Helena Silva", // {{ nomeUsuario }}
  email: "maria.helena@email.com", // {{ emailUsuario }}
  cargo: "Esteticista | Aluna Lumière",
);

final List<Certificado> certificadosMock = [
  Certificado(nome: "Manejo de Micropigmentação", data: "15/03/2024", icon: Icons.palette_outlined),
  Certificado(nome: "Técnicas Avançadas de Laser", data: "01/04/2024", icon: Icons.wb_incandescent_outlined),
  Certificado(nome: "Cosmetologia Aplicada", data: "20/05/2024", icon: Icons.spa_outlined),
  Certificado(nome: "Workshop de Limpeza de Pele", data: "10/06/2024", icon: Icons.clean_hands_outlined),
];

final List<Curso> cursosMock = [
  Curso(
    titulo: "Drenagem Linfática Corporal",
    aulasCompletas: 15,
    totalAulas: 20,
    progresso: 0.75, // 75%
    icon: Icons.water_drop_outlined,
  ),
  Curso(
    titulo: "Peeling Químico e Mecânico",
    aulasCompletas: 5,
    totalAulas: 10,
    progresso: 0.5, // 50%
    icon: Icons.auto_fix_high_outlined,
  ),
  Curso(
    titulo: "Análise Facial Avançada",
    aulasCompletas: 20,
    totalAulas: 20,
    progresso: 1.0, // 100%
    icon: Icons.visibility_outlined,
  ),
];

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool _modalAberto = false; // Simula *ngIf="modalAberto"
  Certificado? _certificadoSelecionado; // Simula modalCertName

  void _openCertificadoModal(Certificado cert) {
    setState(() {
      _certificadoSelecionado = cert;
      _modalAberto = true;
    });
  }

  void _fecharModal() {
    setState(() {
      _modalAberto = false;
      _certificadoSelecionado = null;
    });
  }

  void _baixarCertificado() {
    // Implementação da lógica de download
    print("Baixar Certificado: ${_certificadoSelecionado?.nome}");
    _fecharModal();
  }

  void _compartilharCertificado() {
    // Implementação da lógica de compartilhamento
    print("Compartilhar Certificado: ${_certificadoSelecionado?.nome}");
    _fecharModal();
  }

  void _imprimir() {
    // Implementação da lógica de impressão
    print("Imprimir Certificado: ${_certificadoSelecionado?.nome}");
    _fecharModal();
  }

  @override
  Widget build(BuildContext context) {
    // Determina se é layout de desktop (simulando breakpoint col-lg-...)
    final isDesktop = MediaQuery.of(context).size.width >= 992;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Conteúdo Principal
          SingleChildScrollView(
            // Simulando margin-top: 5vw e container padding
            padding: EdgeInsets.only(top: isDesktop ? 40 : 20, left: 16, right: 16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
              ),
            ),
          ),
          // Modal (Simulando *ngIf="modalAberto" e o z-index do modal)
          if (_modalAberto && _certificadoSelecionado != null)
            _buildCertificadoModal(context, _certificadoSelecionado!),
        ],
      ),
    );
  }

  // --- Layout Responsivo (Desktop: Row 4/8) ---
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Coluna do Perfil (col-lg-4)
        Flexible(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _ProfileCard(usuario: usuarioMock),
          ),
        ),
        // Coluna do Conteúdo (col-lg-8)
        Flexible(
          flex: 8,
          child: _buildCertificatesSection(),
        ),
      ],
    );
  }

  // --- Layout Responsivo (Mobile: Column) ---
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Coluna do Perfil (col-lg-4)
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: _ProfileCard(usuario: usuarioMock),
        ),
        // Coluna do Conteúdo (col-lg-8)
        _buildCertificatesSection(),
      ],
    );
  }

  // --- Seção de Certificados e Aprendizado ---
  Widget _buildCertificatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título Meus Certificados
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: _corTituloDestaque, width: 2)),
          ),
          child: Row(
            children: [
              Icon(Icons.workspace_premium, color: _corTitulo, size: 24), // bi-award
              const SizedBox(width: 8),
              Text(
                'Meus Certificados',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _corTitulo,
                ),
              ),
            ],
          ),
        ),
        // Grid de Certificados (row-cols-1 row-cols-md-2)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Evita scroll duplo
          itemCount: certificadosMock.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 350, // Quebra em 2 colunas para tela média/grande
            childAspectRatio: 3 / 1.5, // Proporção do card
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final cert = certificadosMock[index];
            return _CertificateCard(
              cert: cert,
              onTap: () => _openCertificadoModal(cert),
            );
          },
        ),
        const SizedBox(height: 32),
        // Divisor (hr id="meu-aprendizado")
        Divider(
          color: _corTituloDestaque,
          thickness: 1,
          height: 32,
        ),
        const SizedBox(height: 32),
        
        // --- NOVA SEÇÃO: Meu Aprendizado ---
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: _corTituloDestaque, width: 2)),
          ),
          child: Row(
            children: [
              Icon(Icons.school_outlined, color: _corTitulo, size: 24), // bi-book-half simulado
              const SizedBox(width: 8),
              Text(
                'Meu Aprendizado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _corTitulo,
                ),
              ),
            ],
          ),
        ),
        // Lista de Cursos
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cursosMock.length,
          itemBuilder: (context, index) {
            return _CourseItemCard(curso: cursosMock[index]);
          },
        ),
        // --- FIM NOVA SEÇÃO ---

        const SizedBox(height: 32),
      ],
    );
  }

  // --- Modal de Certificados (Simulação) ---
  Widget _buildCertificadoModal(BuildContext context, Certificado cert) {
    return GestureDetector(
      onTap: _fecharModal, // Fechar modal ao clicar no backdrop (click)="fecharModal()"
      child: Container(
        color: Colors.black54, // Modal backdrop
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {}, // Evita fechar o modal ao clicar dentro (click)="$event.stopPropagation()"
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // Header do Modal
            title: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _fundoCertificados,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            text: 'Ações do Certificado: ',
                            style: TextStyle(color: _corTitulo, fontSize: 18, fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                              TextSpan(
                                text: cert.nome,
                                style: TextStyle(color: _corTituloDestaque, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: _corTexto),
                        onPressed: _fecharModal, // btn-close
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Body do Modal
            content: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('O que você deseja fazer com este certificado?', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  // Botões de Ação
                  _CustomModalButton(
                    label: 'Compartilhar (Link/Redes Sociais)',
                    icon: Icons.share, // bi-share
                    color: _corTituloDestaque,
                    onTap: _compartilharCertificado,
                  ),
                  const SizedBox(height: 10),
                  _CustomModalButton(
                    label: 'Baixar Certificado (PNG/PDF)',
                    icon: Icons.download, // bi-download
                    color: _corBotao,
                    onTap: _baixarCertificado,
                  ),
                  const SizedBox(height: 10),
                  _CustomModalButton(
                    label: 'Imprimir',
                    icon: Icons.print, // bi-printer
                    color: const Color(0xFF947E58), // Cor #947e58
                    onTap: _imprimir,
                  ),
                ],
              ),
            ),
            // Footer do Modal
            actions: [
              TextButton(
                onPressed: _fecharModal,
                style: TextButton.styleFrom(
                  foregroundColor: _corTexto,
                  side: BorderSide(color: _corTexto, width: 1), // btn-outline-secondary
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Fechar'),
              ),
            ],
            actionsPadding: const EdgeInsets.only(right: 20, bottom: 16),
          ),
        ),
      ),
    );
  }
}

// --- Widget Card de Perfil ---
class _ProfileCard extends StatelessWidget {
  final Usuario usuario;
  const _ProfileCard({required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // shadow-sm
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: _corBotao.withOpacity(0.2), width: 1), // border-color: rgba(109, 86, 50, 0.2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Avatar (bi-person-circle)
            Icon(
              Icons.account_circle,
              size: 90,
              color: _corBotao,
            ),
            const SizedBox(height: 16),
            // Nome do Usuário
            Text(
              usuario.nome, // {{ nomeUsuario }}
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _corTitulo),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // Título/Cargo
            Text(
              usuario.cargo,
              style: TextStyle(fontSize: 14, color: _corTituloDestaque, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Lista de Detalhes (list-group)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text('Email:', style: TextStyle(fontSize: 14, color: _corTexto)),
              trailing: Text(
                usuario.email, // {{ emailUsuario }}
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _corTexto),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: _fundoCertificados), // Simula linha divisória
            // Se houvesse mais itens na lista, eles viriam aqui.
            const ListTile(contentPadding: EdgeInsets.zero, dense: true, title: Text(''), trailing: Text(''))
          ],
        ),
      ),
    );
  }
}

// --- Widget Card de Certificado ---
class _CertificateCard extends StatelessWidget {
  final Certificado cert;
  final VoidCallback onTap;

  const _CertificateCard({required this.cert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // Simulação do :hover (transform: translateY)
        transform: Matrix4.translationValues(0, 0, 0),
        decoration: BoxDecoration(
          color: _fundoCertificados, // background-color: var(--fundo-certificados)
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _corBotao.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        onEnd: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Título do Certificado
              Row(
                children: [
                  Icon(cert.icon, color: _corTituloDestaque, size: 24),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      cert.nome,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _corTituloDestaque, // card-cert .card-title
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              // Data de Emissão
              Text(
                'Emitido em ${cert.data}.',
                style: TextStyle(fontSize: 14, color: _corTexto),
              ),
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _corBotao, // background-color: var(--cor-botao)
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Clique para Ações',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NOVO WIDGET: Card de Curso para "Meu Aprendizado" ---
class _CourseItemCard extends StatelessWidget {
  final Curso curso;

  const _CourseItemCard({required this.curso});

  @override
  Widget build(BuildContext context) {
    // Definir a cor da barra de progresso (verde se completo, destaque se em progresso)
    final progressColor = curso.progresso == 1.0 ? Colors.green.shade600 : _corTituloDestaque;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        // alert-info-custom simulação: fundo e borda
        side: BorderSide(color: _corTituloDestaque.withOpacity(0.7), width: 1),
      ),
      color: _fundoSobre, // background-color: var(--fundo-sobre)
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone do Curso
            Icon(curso.icon, size: 36, color: _corBotao),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso.titulo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _corTitulo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Barra de Progresso
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: curso.progresso,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(progressColor), // progress-bar-custom
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${(curso.progresso * 100).toInt()}%',
                        style: TextStyle(fontSize: 14, color: progressColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Contagem de Aulas
                  Text(
                    '${curso.aulasCompletas}/${curso.totalAulas} aulas concluídas',
                    style: TextStyle(fontSize: 12, color: _corTexto),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Botão/Indicador de Ação
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 18, color: _corTexto.withOpacity(0.7)),
              onPressed: () {
                // Lógica para navegar para a página do curso
                print('Navegar para o curso: ${curso.titulo}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget Botão de Ação do Modal ---
class _CustomModalButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CustomModalButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), // d-grid gap-2 e padding/height
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
    );
  }
}