import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;
  final String token;
  const HomeScreen({super.key, required this.username, required this.email, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home ${widget.username}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text("MyApp"),
      ),
    );
  }
}
