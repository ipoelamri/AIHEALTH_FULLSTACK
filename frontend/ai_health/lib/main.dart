import 'package:ai_health/drawer/profile.dart';
import 'package:ai_health/pages/BMI.dart';
import 'package:ai_health/pages/consult.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_health/pages/login.dart';
import 'package:ai_health/pages/splashscreen.dart';
import 'package:ai_health/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:ai_health/pages/register.dart';
import 'package:ai_health/drawer/about.dart';
import 'package:ai_health/drawer/contact.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ai_health/pages/mentalhealth.dart';
import 'package:ai_health/pages/virtualTherapist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // ⬅ load .env
  runApp(const MyApp());
}

// void main() {
//   runApp(const MyApp());
// }

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/Login', builder: (context, state) => const Login()),
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/Register', builder: (context, state) => const Register()),
    GoRoute(path: '/Home', builder: (context, state) => HomePage()),
    GoRoute(path: '/BMI', name: 'BMI', builder: (context, state) => BMIPage()),
    GoRoute(
      path: '/Virtual-Therapist',
      name: 'VT',
      builder: (context, state) => VirtualTherapistPage(),
    ),
    GoRoute(
      path: '/Mental-Health',
      name: 'MentalHealth',
      builder: (context, state) => MentalHealthCheckPage(),
    ),
    GoRoute(
      path: '/Consult',
      name: 'Consult',
      builder: (context, state) => ChatPage(),
    ),
    GoRoute(
      path: '/About',
      name: 'About',
      builder: (context, state) => About(),
    ),
    GoRoute(
      path: '/Contact',
      name: 'Contact',
      builder: (context, state) => Contact(),
    ),
    GoRoute(
      path: '/Profile',
      name: 'Profile',
      builder: (context, state) => ProfilePage(),
    ),
  ],
  //                                   labelStyle: TextStyle(
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
    // return FutureBuilder(
    //   future: Future.delayed(Duration(seconds: 3)),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return SplashScreen();
    //     } else {
    //       return Login();
    //     }
    //   },
    // );
  }
}
