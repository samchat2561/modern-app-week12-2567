import 'package:blog_moble/views/auth/login.dart';
import 'package:blog_moble/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  final String? username = prefs.getString('username');
  final String? email = prefs.getString('email');

  runApp(MyApp(token: token, username: username, email: email));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? username;
  final String? email;
  const MyApp({super.key, this.token, this.username, this.email});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Blog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginScreens(),
      home: (token != null && JwtDecoder.isExpired(token!) == false)
          ? Dashboard(
              token: token!,
              username: username!,
              email: email!,
            )
          : LoginScreens(),
    );
  }
}
