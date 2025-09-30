import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_colors.dart';
import 'package:musteridefterim/constants/app_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.book, size: 70, color: AppColors.lightPrimary),
                const SizedBox(height: 20),
                Text(
                  "MüşteriDefteri",
                  style: AppStyles.headline1.copyWith(
                    color: AppColors.lightPrimary,
                  ),
                ),
                const SizedBox(height: 40),

                // Email
                TextField(decoration: AppStyles.inputDecoration("E-posta")),
                const SizedBox(height: 16),

                // Password
                TextField(
                  obscureText: true,
                  decoration: AppStyles.inputDecoration("Şifre"),
                ),
                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  style: AppStyles.primaryButton,
                  child: const Text("Giriş Yap"),
                ),
                const SizedBox(height: 16),

                // Forgot password
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/forgot");
                  },
                  child: const Text("Şifremi Unuttum"),
                ),
                const SizedBox(height: 8),

                // Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hesabın yok mu?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/signup");
                      },
                      child: const Text("Kayıt Ol"),
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
