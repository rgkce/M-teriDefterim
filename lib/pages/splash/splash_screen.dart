import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/login");
    });

    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Center(child: Image.asset('assets/logo.png')),
    );
  }
}
