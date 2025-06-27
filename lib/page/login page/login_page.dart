import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/model/user_model.dart';
import 'package:mobile_app/services/api_service.dart';
import 'package:mobile_app/widget/login_card.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  UserModel? loggedInUser;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final auth = await loginUser(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      loggedInUser = auth.user;

      context.go('/home');
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() => _isLoading = false);
    }
    print('Error: $_error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginCard(
          emailController: _emailController,
          passwordController: _passwordController,
          onSubmit: _handleLogin,
          isLoading: _isLoading,
          errorMessage: _error,
          title: 'Login',
          buttonText: 'Login',
        ),
      ),
    );
  }
}