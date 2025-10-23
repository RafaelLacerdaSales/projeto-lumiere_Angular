
import 'package:flutter/material.dart';
import 'dart:ui'; // Para BackdropFilter

// --- Definições de Cores e Estilos (Simulando Variáveis CSS) ---
// Em um projeto real, estas cores seriam definidas em um tema global.
const Color _corTitulo = Color(0xFF8E744C); // Cor principal (simulando var(--cor-titulo))
const Color _corPrimariaBtn = _corTitulo;
const Color _corWarningBtn = Color(0xFFFFA500); // Para o botão de Recuperar Senha
const Color _corFundoCard = Colors.black; // A base para o fundo transparente do card

// Simulação das seções do HTML
enum AuthSection { login, cadastro, recuperar }

class LoginAuthScreen extends StatefulWidget {
  const LoginAuthScreen({Key? key}) : super(key: key);

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> with SingleTickerProviderStateMixin {
  AuthSection _sectionAtual = AuthSection.login; // Simula sectionAtual
  
  // Controladores para formulários (Simulando [(ngModel)])
  final TextEditingController _emailController = TextEditingController(text: 'exemplo@email.com');
  final TextEditingController _senhaController = TextEditingController(text: 'senha123');
  
  // Cadastro
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNascController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  
  // Recuperar
  final TextEditingController _emailRecuperarController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    // Configura a animação para simular o 'fadeIn 0.5s ease-in-out' do CSS
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _nomeController.dispose();
    _cpfController.dispose();
    _dataNascController.dispose();
    _telController.dispose();
    _emailRecuperarController.dispose();
    super.dispose();
  }

  // Simula (click)="mudarSection('nome')"
  void _mudarSection(AuthSection novaSection) {
    setState(() {
      _sectionAtual = novaSection;
      // Reinicia a animação para o novo card
      _animationController.reset();
      _animationController.forward();
    });
  }

  // Simula (ngSubmit)
  void _onLogin() {
    print('Tentativa de Login com: ${_emailController.text} / ${_senhaController.text}');
    // Lógica de autenticação aqui
  }
  
  void _submitUser() {
    print('Tentativa de Cadastro para: ${_nomeController.text} / ${_emailController.text}');
    // Lógica de cadastro aqui
  }

  void _onRecuperar() {
    print('Recuperar Senha para: ${_emailRecuperarController.text}');
    // Lógica de recuperação de senha aqui
  }

  @override
  Widget build(BuildContext context) {
    // Determina o tamanho da tela para responsividade
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMaxWidth = _sectionAtual == AuthSection.cadastro ? 600.0 : 480.0;
    
    // Simula img_background (fundo fixo com imagem e blur)
    final background = Container(
      width: screenWidth,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        // Simulação de background_login.jpg
        image: DecorationImage(
          image: AssetImage('assets/background_login.jpg'), // Placeholder for asset
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        // Simula backdrop-filter: blur(12px)
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(color: Colors.black.withOpacity(0.1)), // Ajuste de opacidade para a imagem
      ),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          background, // Fundo fixo
          // Container: display: flex; align-items: center; justify-content: center; min-height: 100vh;
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: cardMaxWidth),
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: _buildAuthCard(context, cardMaxWidth),
                ),
              ),
            ),
          ),
          // app-footer placeholder (assumindo que seja um widget de rodapé simples)
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '© 2024 Minha Empresa. Todos os direitos reservados.',
                style: TextStyle(color: Color.fromARGB(195, 104, 63, 2), fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthCard(BuildContext context, double cardMaxWidth) {
    // Card Style: border-radius: 15px; box-shadow; background-color: rgba(0, 0, 0, 0.55); backdrop-filter: blur(12px);
    Widget currentCard;

    switch (_sectionAtual) {
      case AuthSection.login:
        currentCard = _buildLoginForm();
        break;
      case AuthSection.cadastro:
        currentCard = _buildRegisterForm(context);
        break;
      case AuthSection.recuperar:
        currentCard = _buildRecoverForm();
        break;
    }

    // Aplica o estilo do Card base
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0), // Aplica o blur do card
        child: Container(
          padding: const EdgeInsets.all(30),
          width: cardMaxWidth,
          decoration: BoxDecoration(
            color: const Color.fromARGB(212, 255, 245, 227), // background-color: rgba(0, 0, 0, 0.55);
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: currentCard,
        ),
      ),
    );
  }
  
  // --- LOGIN SECTION ---
  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Image(
            image: AssetImage('assets/icone-2.png'), // Placeholder
            height: 80,
            width: 150,
          ),
        ),
        // Card Header
        _CardHeader(title: 'Login', isCadastro: false),
        
        const SizedBox(height: 20),
        
        // Form
        _AuthForm(
          onSubmitted: _onLogin,
          children: [
            _CustomLabel(text: 'E-mail'),
            _CustomInput(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            _CustomLabel(text: 'Senha'),
            _CustomInput(
              controller: _senhaController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            _CustomButton(
              text: 'Entrar',
              onPressed: _onLogin,
              color: _corPrimariaBtn,
              marginTop: 15, // mt-3
            ),
          ],
        ),
        
        // Links
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CustomLink(
              text: 'Esqueci minha senha',
              onTap: () => _mudarSection(AuthSection.recuperar),
            ),
            const Text(' | ', style: TextStyle(color: Colors.white)),
            _CustomLink(
              text: 'Cadastrar-se',
              onTap: () => _mudarSection(AuthSection.cadastro),
            ),
          ],
        ),
      ],
    );
  }
  
  // --- CADASTRO SECTION ---
  Widget _buildRegisterForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header personalizado do Cadastro
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _corTitulo, // background-color: var(--cor-titulo)
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/icone-2.png'), // Placeholder
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 5),
              Text(
                'Cadastro',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: DefaultTextStyle.of(context).style.fontFamily, // Simula var(--font-principal)
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Form
        _AuthForm(
          onSubmitted: _submitUser,
          children: [
            // Row: Nome (col-md-8) e CPF (col-md-4)
            Row(
              children: [
                Expanded(
                  flex: 2, // Simula col-md-8
                  child: _CustomInput(
                    controller: _nomeController,
                    hintText: 'Nome Completo',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1, // Simula col-md-4
                  child: _CustomInput(
                    controller: _cpfController,
                    hintText: 'CPF',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            
            // Row: Data de Nascimento (col-md-6) e Telefone (col-md-6)
            Row(
              children: [
                Expanded(
                  child: _CustomInput(
                    controller: _dataNascController,
                    hintText: 'Data de Nascimento',
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      // Simula type="date"
                      FocusScope.of(context).requestFocus(new FocusNode());
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      // Atualizar controller com data selecionada
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CustomInput(
                    controller: _telController,
                    hintText: 'Telefone',
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            
            // Email
            _CustomInput(
              controller: _emailController,
              hintText: 'E-mail',
              keyboardType: TextInputType.emailAddress,
            ),
            
            // Senha
            _CustomInput(
              controller: _senhaController,
              hintText: 'Senha',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,

            ),
            
            // Botão Cadastrar (w-100 mt-2)
            _CustomButton(
              text: 'Cadastrar',
              onPressed: _submitUser,
              color: _corPrimariaBtn,
              marginTop: 10,
            ),
          ],
        ),
        
        // Link
        const SizedBox(height: 15),
        _CustomLink(
          text: 'Já tenho uma conta',
          onTap: () => _mudarSection(AuthSection.login),
        ),
      ],
    );
  }

  // --- RECUPERAR SENHA SECTION ---
  Widget _buildRecoverForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Card Header
        _CardHeader(title: 'Recuperar Senha', isCadastro: false),
        
        const SizedBox(height: 20),
        
        // Form
        _AuthForm(
          onSubmitted: _onRecuperar,
          children: [
            _CustomInput(
              controller: _emailRecuperarController,
              hintText: 'Digite seu e-mail',
              keyboardType: TextInputType.emailAddress,
            ),
            // Botão Redefinir Senha (btn-warning mt-3)
            _CustomButton(
              text: 'Redefinir Senha',
              onPressed: _onRecuperar,
              color: _corWarningBtn,
              marginTop: 15,
            ),
          ],
        ),
        
        // Link
        const SizedBox(height: 15),
        _CustomLink(
          text: 'Voltar ao login',
          onTap: () => _mudarSection(AuthSection.login),
        ),
      ],
    );
  }
}

// --- Componentes Reutilizáveis (Simulando Classes CSS) ---

class _CardHeader extends StatelessWidget {
  final String title;
  final bool isCadastro;

  const _CardHeader({required this.title, required this.isCadastro});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.brown,
          fontFamily: DefaultTextStyle.of(context).style.fontFamily, // Simula var(--font-principal)
        ),
      ),
    );
  }
}

class _AuthForm extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onSubmitted;

  const _AuthForm({required this.children, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    // No Flutter, o formulário é implícito. Usamos Column para organização.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class _CustomLabel extends StatelessWidget {
  final String text;

  const _CustomLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        text,
        style: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: DefaultTextStyle.of(context).style.fontFamily, // Simula var(--font-principal)
        ),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final VoidCallback? onTap;

  const _CustomInput({
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: _corTitulo, width: 2),
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double marginTop;

  const _CustomButton({
    required this.text,
    required this.onPressed,
    required this.color,
    this.marginTop = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: marginTop),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // background-color: var(--cor-titulo) ou btn-warning
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50), // padding: 12px; width: 100%;
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _CustomLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _CustomLink({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          decoration: TextDecoration.none,
          fontSize: 14,
        ),
      ),
    );
  }
}