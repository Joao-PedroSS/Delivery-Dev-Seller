import 'package:delivery_dev_seller/auth/ui/viewmodels/auth_viewmodel.dart';
import 'package:delivery_dev_seller/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _viewModel = Modular.get<AuthViewmodel>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _viewModel.login(
          _emailController.text,
          _passwordController.text,
        );

        Modular.to.navigate('/home/');
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 513),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          'Entregas DEV',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 80),

                        _buildEmailField(),
                        const SizedBox(height: 24),

                        _buildPasswordField(),
                        const SizedBox(height: 40),

                        _buildLoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          )
        );
      }
    );
  }


  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'E-mail', //
        labelStyle: TextStyle(color: AppColors.text),
        hintText: 'ex: joao@email.com', //
        hintStyle: TextStyle(color: AppColors.text),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu e-mail.';
        }
        if (!value.contains('@') || !value.contains('.')) {
          return 'Por favor, insira um e-mail válido.';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Senha',
        labelStyle: TextStyle(color: AppColors.text),
        hintText: '******',
        hintStyle: TextStyle(color: AppColors.text),
        
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[400],
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey[800]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira sua senha.';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface, // Fundo claro
          foregroundColor: Colors.black, // Texto escuro
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        
        onPressed: _viewModel.isLoading ? null : _doLogin,
        child: _viewModel.isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 3,
              )
            : Text(
                'Entrar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}