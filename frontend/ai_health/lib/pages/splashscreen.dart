import 'package:ai_health/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ⬅ Tambahkan ini

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Biar tetap ada animasi splash

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      context.go('/Home'); // ⬅ Langsung ke Home kalau udah login
    } else {
      context.go('/Login'); // ⬅ Kalau belum login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgLogo,
      body: Center(
        child: Image.asset(
          'lib/assets/images/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
