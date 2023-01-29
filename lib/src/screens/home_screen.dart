import 'package:flutter/material.dart';
import 'package:products_app/src/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true, actions: [
        IconButton(
          icon: const Icon(Icons.login),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'Login');
          },
        ),
      ]),
      body: const Center(child: Text('Hello Mae')),
    );
  }
}
