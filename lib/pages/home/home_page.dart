import 'package:flutter/material.dart';
import 'package:musteridefterim/navigation/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Page")),
      bottomNavigationBar: const NavBar(currentIndex: 0),
    );
  }
}
