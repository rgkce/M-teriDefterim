import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_theme.dart';
import 'package:musteridefterim/pages/auth/forgot_password_page.dart';
import 'package:musteridefterim/pages/auth/login_page.dart';
import 'package:musteridefterim/pages/auth/signup_page.dart';
import 'package:musteridefterim/pages/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MüşteriDefteri',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginPage(),
        "/signup": (context) => const SignupPage(),
        "/forgot": (context) => const ForgotPasswordPage(),
        // "/home": (context) => const HomePage(),  // sonra eklenecek
      },
    );
  }
}
