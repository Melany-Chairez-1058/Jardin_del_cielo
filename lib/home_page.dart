import 'package:flutter/material.dart';
import 'package:jardin_del_cielo/login_page.dart';
import 'package:jardin_del_cielo/register_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateWithFade(BuildContext context, String route) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) =>
          route == '/registro' ? const RegistroPage() : const LoginPage(),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF889063),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 800),
          child: SlideTransition(
            position: _slideAnimation,
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE5D7C4),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Image.asset('assets/lsl.png', height: 100),
          const SizedBox(height: 10),
          const Text(
            'El Jardín del Cielo',
            style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF354024)),
          ),
          const SizedBox(height: 20),
          const Text(
            'Bienvenid@ a\nEl Jardín Del Cielo',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF743014)),
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFF9D9167), thickness: 1),
          const SizedBox(height: 20),
          const Text('¿Eres nuevo por aquí?',
              style: TextStyle(fontSize: 14, color: Color(0xFF84592B))),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => _navigateWithFade(context, '/registro'),
            icon: const Icon(Icons.person_add),
            label: const Text('Registrar'),
            style: _botonEstilo(const Color(0xFFCFBB99)),
          ),
          const SizedBox(height: 20),
          const Text('¿Ya tienes una cuenta?',
              style: TextStyle(fontSize: 14, color: Color(0xFF84592B))),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => _navigateWithFade(context, '/login'),
            icon: const Icon(Icons.login),
            label: const Text('Iniciar Sesión'),
            style: _botonEstilo(const Color(0xffdbc9aa)),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFF9D9167), thickness: 1),
          const SizedBox(height: 8),
          const Text(
            '🌼 Flores que alegran tu día 🌼',
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color(0xFF354024),
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  ButtonStyle _botonEstilo(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Color(0xFF354024),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      elevation: 4,
    );
  }
}
