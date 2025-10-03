import 'package:flutter/material.dart';
import 'package:musteridefterim/navigation/navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Profil Page")),
      bottomNavigationBar: const NavBar(currentIndex: 1),
    );
  }
}
