import 'package:flutter/material.dart';
import 'dart:ui'; // Necessário para BackdropFilter

// Definição da cor primária baseada na variável CSS (--cor-titulo)
const Color _corTitulo = Color(0xFF5A4C39);
// Cor de fundo do cartão (55% de opacidade preta)
const Color _corFundoCard = Color(0x8C000000);

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Autenticação',
      // Definição de propriedades básicas do tema
      theme: ThemeData(
        fontFamily: 'Inter', // Fonte padrão
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _corTitulo,
          brightness: Brightness.dark,
          primary: _corTitulo,
          onPrimary: Colors.white,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Gestão de estado para alternar entre as vistas: 'login', 'cadastro', 'recuperar'
  String _sectionAtual = 'login';

  // Dados do formulário (campos fictícios para demonstração)
  final Map<String, dynamic> _loginData = {'email': '', 'senha': ''};
  final Map<String, dynamic> _cadastroData = {
    'nome': '',
    'cpf': '',
    'data_nascimento': '',
    'telefone': '',
    'email': '',
    'senha': '',
  };
  final Map<String, dynamic> _recuperarData = {'email_recuperar': ''};

  void _mudarSection(String newSection) {
    setState(() {
      _sectionAtual = newSection;
    });
  }

  void _onLogin() {
    // Lógica de login (simulação)
    print('Tentativa de Login: ${_loginData['email']}');
  }

  void _submitUser() {
    // Lógica de registo (simulação)
    print('Tentativa de Registo para: ${_cadastroData['nome']}');
  }

  void _onRecuperar() {
    // Lógica de recuperação de palavra-passe (simulação)
    print(
      'Recuperação de Palavra-passe solicitada para: ${_recuperarData['email_recuperar']}',
    );
  }

  Widget _buildSection() {
    // Chave única para que o AnimatedSwitcher saiba quando trocar o widget
    return KeyedSubtree(
      key: ValueKey<String>(_sectionAtual),
      child: switch (_sectionAtual) {
        'cadastro' => CadastroCard(
          data: _cadastroData,
          onSubmit: _submitUser,
          onGoToLogin: () => _mudarSection('login'),
        ),
        'recuperar' => RecuperarCard(
          data: _recuperarData,
          onSubmit: _onRecuperar,
          onGoToLogin: () => _mudarSection('login'),
        ),
        _ => LoginCard(
          data: _loginData,
          onSubmit: _onLogin,
          onMudarSection: _mudarSection,
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold fornece a estrutura básica
    return Scaffold(
      body: Stack(
        children: [
          // 1. Imagem de Fundo (Simulação de /assets/background_login.jpg)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Imagem de espaço reservado
                image: NetworkImage(
                  'https://placehold.co/1080x1920/1a1a1a/white?text=Imagem%20de%20Fundo',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black45, // Escurece ligeiramente a imagem
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // 2. Content Container (.container)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              // CORREÇÃO: Adicionando Directionality para satisfazer a exigência de direção do texto
              // de widgets como TextFormField e resolver o erro da tela vermelha.
              child: Directionality(
                textDirection:
                    TextDirection.ltr, // Definindo LTR (Left-to-Right)
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                        // Transição para imitar o efeito fadeIn
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(
                                0,
                                -0.05,
                              ), // Ligeiro movimento para baixo
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                  child: _buildSection(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Card Wrapper com Efeito de Vidro Fosco ---

class FrostedCard extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const FrostedCard({super.key, required this.child, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12.0,
            sigmaY: 12.0,
          ), // backdrop-filter: blur(12px)
          child: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: _corFundoCard, // background-color: rgba(0, 0, 0, 0.55)
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 14.0,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// --- Secção de Login (max-width: 480px) ---

class LoginCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onSubmit;
  final Function(String) onMudarSection;

  const LoginCard({
    super.key,
    required this.data,
    required this.onSubmit,
    required this.onMudarSection,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      maxWidth: 480.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Content of icon-2.png
          Center(
            child: Image.network(
              'https://placehold.co/150x50/5A4C39/ffffff?text=LOGO',
              width: 150,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 50,
                child: Center(
                  child: Text('LOGO', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Card Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _corTitulo,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Form
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'E-mail',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: data['email'],
                  onChanged: (value) => data['email'] = value,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration.copyWith(
                    hintText: 'Digite seu e-mail',
                  ),
                ),
                // Espaçamento vertical (mb-3)
                const SizedBox(height: 15),

                const Text(
                  'Senha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: data['senha'],
                  onChanged: (value) => data['senha'] = value,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration.copyWith(
                    hintText: 'Digite sua senha',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ), // Espaçamento maior antes do botão (mt-3)
                // Submit Button
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corTitulo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Entrar'),
                ),
              ],
            ),
          ),

          // Links
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onMudarSection('recuperar'),
                  child: const Text('Esqueci minha senha', style: _linkStyle),
                ),
                const Text(' | ', style: _linkStyle),
                GestureDetector(
                  onTap: () => onMudarSection('cadastro'),
                  child: const Text('Cadastrar-se', style: _linkStyle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Secção de Cadastro (max-width: 600px) ---

class CadastroCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onSubmit;
  final VoidCallback onGoToLogin;

  const CadastroCard({
    super.key,
    required this.data,
    required this.onSubmit,
    required this.onGoToLogin,
  });

  @override
  Widget build(BuildContext context) {
    // Determina o layout com base na largura do ecrã
    final isMobile = MediaQuery.of(context).size.width < 600;

    return FrostedCard(
      maxWidth: 600.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header com Logo
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _corTitulo,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                // Simulação da imagem icon-2.png
                Image.network(
                  'https://placehold.co/80x80/5A4C39/ffffff?text=ICO',
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                    height: 80,
                    child: Center(
                      child: Text('ICON', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                const Text(
                  'Cadastro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Form
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Nome Completo e CPF
                _buildResponsiveRow(
                  isMobile,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: data['nome'],
                        onChanged: (value) => data['nome'] = value,
                        decoration: _inputDecoration.copyWith(
                          hintText: 'Nome Completo',
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    if (!isMobile) const SizedBox(width: 15),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        initialValue: data['cpf'],
                        onChanged: (value) => data['cpf'] = value,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration.copyWith(hintText: 'CPF'),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15), // Espaçamento após a primeira linha
                // Data de Nascimento e Telefone
                _buildResponsiveRow(
                  isMobile,
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: data['data_nascimento'],
                        onChanged: (value) => data['data_nascimento'] = value,
                        keyboardType: TextInputType.datetime,
                        decoration: _inputDecoration.copyWith(
                          hintText: 'Data de Nascimento (AAAA-MM-DD)',
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    if (!isMobile) const SizedBox(width: 15),
                    Expanded(
                      child: TextFormField(
                        initialValue: data['telefone'],
                        onChanged: (value) => data['telefone'] = value,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDecoration.copyWith(
                          hintText: 'Telefone',
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15), // Espaçamento após a segunda linha
                // Email
                TextFormField(
                  initialValue: data['email'],
                  onChanged: (value) => data['email'] = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration.copyWith(hintText: 'E-mail'),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 15),

                // Senha
                TextFormField(
                  initialValue: data['senha'],
                  onChanged: (value) => data['senha'] = value,
                  obscureText: true,
                  decoration: _inputDecoration.copyWith(hintText: 'Senha'),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 25,
                ), // Espaçamento maior antes do botão (mt-2)
                // Submit Button
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corTitulo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),

          // Link
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GestureDetector(
              onTap: onGoToLogin,
              child: const Text(
                'Já tenho uma conta',
                textAlign: TextAlign.center,
                style: _linkStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Ajuda a criar uma linha responsiva (Row para desktop, Column para dispositivos móveis)
  Widget _buildResponsiveRow(bool isMobile, {required List<Widget> children}) {
    if (isMobile) {
      // Em dispositivos móveis, os campos ficam em coluna sem padding extra, pois já é gerado pelo campo
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .map(
              (w) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                ), // Simula mb-3 para cada campo na coluna
                child: w,
              ),
            )
            .toList(),
      );
    } else {
      // Em ecrãs maiores, os campos ficam lado a lado
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
  }
}

// --- Secção de Recuperar Senha (max-width: 480px) ---

class RecuperarCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onSubmit;
  final VoidCallback onGoToLogin;

  const RecuperarCard({
    super.key,
    required this.data,
    required this.onSubmit,
    required this.onGoToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return FrostedCard(
      maxWidth: 480.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: _corTitulo,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Recuperar Senha',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Form
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: data['email_recuperar'],
                  onChanged: (value) => data['email_recuperar'] = value,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  decoration: _inputDecoration.copyWith(
                    hintText: 'Digite seu e-mail',
                  ),
                ),
                const SizedBox(height: 25), // Espaçamento antes do botão (mt-3)
                // Submit Button (Estilo de aviso)
                ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.amber, // Amarelo para aviso/redefinir
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Redefinir Senha'),
                ),
              ],
            ),
          ),

          // Link
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GestureDetector(
              onTap: onGoToLogin,
              child: const Text(
                'Voltar ao login',
                textAlign: TextAlign.center,
                style: _linkStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Estilos Comuns ---

// Estilo para os links
const TextStyle _linkStyle = TextStyle(
  color: Colors.white,
  decoration: TextDecoration.underline,
  decorationColor: Colors.white,
  fontWeight: FontWeight.w500,
);

// Estilo para os campos de entrada (InputDecoration)
const InputDecoration _inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(12.0),
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)), // border-radius: 8px
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: _corTitulo, width: 2.0),
  ),
  isDense: true,
  errorStyle: TextStyle(
    fontSize: 0,
    height: 0,
  ), // Oculta o texto de erro padrão
);
