import 'package:ai_health/commons/constant.dart';
import 'package:ai_health/services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void handleLogin() async {
    final result = await authService.login(
      emailController.text,
      passwordController.text,
    );

    if (result['success'] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['access_token']);
      context.go('/Home');
    } else {
      final errorMessage = result['message'] ?? 'Terjadi Kesalahan';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Selamat Datang',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Silakan login untuk melanjutkan',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Email',
                                  hintText: 'Masukkan email Anda',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  }
                                  if (!RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  ).hasMatch(value)) {
                                    return 'Masukkan email yang valid';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Password',
                                ),
                                obscureText: !_isPasswordVisible,
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    print(
                                      'Password: ${passwordController.text}',
                                    );
                                    handleLogin();
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              // Handle forgot password
                            },
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Belum punya akun?',
                    style: TextStyle(fontSize: 16, color: AppColors.WhiteLogo),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/Register');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: AppColors.BgLogo),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.WhiteLogo,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
