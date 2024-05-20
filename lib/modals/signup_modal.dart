// lib/modals/signup_modal.dart
import 'package:flutter/material.dart';
import 'package:quizzotic_frontend/controllers/auth_controller.dart';

class SignupModal extends StatefulWidget {
  final VoidCallback onSignupSuccess;

  const SignupModal({Key? key, required this.onSignupSuccess})
      : super(key: key);

  @override
  _SignupModalState createState() => _SignupModalState();
}

class _SignupModalState extends State<SignupModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthController _authController = AuthController();

  Future<void> _signup() async {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final bool success = await _authController.signup(name, email, password);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      widget.onSignupSuccess();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign Up'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
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
          onPressed: _isLoading ? null : _signup,
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('Sign Up'),
        ),
      ],
    );
  }
}
