import 'package:flutter/material.dart';
import 'package:musteridefterim/constants/app_styles.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Şifre Sıfırlama")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              "E-posta adresinizi girin, şifre sıfırlama bağlantısı gönderelim.",
              style: AppStyles.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(decoration: AppStyles.inputDecoration("E-posta")),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Şifre sıfırlama isteği burada çalışacak
                Navigator.pop(context);
              },
              style: AppStyles.primaryButton,
              child: const Text("Bağlantıyı Gönder"),
            ),
          ],
        ),
      ),
    );
  }
}
