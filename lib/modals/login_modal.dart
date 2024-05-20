// lib/modals/login_modal.dart
import 'package:flutter/material.dart';
import 'package:quizzotic_frontend/controllers/auth_controller.dart';

class LoginModal extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginModal({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthController _authController = AuthController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final bool success = await _authController.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      widget.onLoginSuccess();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isLoading ? null : _login,
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('Login'),
        ),
      ],
    );
  }
}
