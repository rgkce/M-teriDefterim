import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_colors.dart';
import 'package:musteridefterim/constants/app_styles.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.person_add,
                  size: 70,
                  color: AppColors.lightPrimary,
                ),
                const SizedBox(height: 20),
                Text(
                  "Kayıt Ol",
                  style: AppStyles.headline1.copyWith(
                    color: AppColors.lightPrimary,
                  ),
                ),
                const SizedBox(height: 40),

                TextField(decoration: AppStyles.inputDecoration("İsim")),
                const SizedBox(height: 16),
                TextField(decoration: AppStyles.inputDecoration("E-posta")),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: AppStyles.inputDecoration("Şifre"),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  style: AppStyles.primaryButton,
                  child: const Text("Kayıt Ol"),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Zaten hesabın var mı?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: const Text("Giriş Yap"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
