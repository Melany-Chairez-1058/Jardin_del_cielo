import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    _slideAnimations = List.generate(6, (index) {
      final start = 0.1 * index;
      return Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
          .animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(start, start + 0.4, curve: Curves.easeOut)),
      );
    });

    _fadeAnimations = List.generate(6, (index) {
      final start = 0.1 * index;
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _controller,
            curve: Interval(start, start + 0.4, curve: Curves.easeOut)),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return SlideTransition(
      position: _slideAnimations[index],
      child: FadeTransition(
        opacity: _fadeAnimations[index],
        child: child,
      ),
    );
  }

  InputDecoration _decoracionCampo(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF84592B)),
      filled: true,
      fillColor: const Color(0xFFE8D1A7),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF743014), width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5D7C4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF9D9167),
        foregroundColor: Colors.white,
        title: const Text('Registro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAnimatedItem(
                0,
                TextField(
                  decoration:
                      _decoracionCampo('Nombre completo', Icons.person_outline),
                ),
              ),
              const SizedBox(height: 14),
              _buildAnimatedItem(
                1,
                TextField(
                  decoration: _decoracionCampo(
                      'Correo electrónico', Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 14),
              _buildAnimatedItem(
                2,
                TextField(
                  decoration:
                      _decoracionCampo('Teléfono', Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 14),
              _buildAnimatedItem(
                3,
                TextField(
                  decoration:
                      _decoracionCampo('Dirección', Icons.home_outlined),
                ),
              ),
              const SizedBox(height: 14),
              _buildAnimatedItem(
                4,
                TextField(
                  obscureText: true,
                  decoration:
                      _decoracionCampo('Contraseña', Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 14),
              _buildAnimatedItem(
                5,
                TextField(
                  obscureText: true,
                  decoration: _decoracionCampo(
                      'Confirmar contraseña', Icons.lock_open_outlined),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registro exitoso 🌷')),
                  );
                },
                icon: const Icon(Icons.app_registration),
                label: const Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCFBB99),
                  foregroundColor: const Color(0xFF354024),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
              ),
              const SizedBox(height: 10),
              const Text('🌼 Gracias por unirte a nuestro jardín 🌼',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF84592B),
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}
