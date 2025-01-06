import 'package:blog_moble/views/auth/login.dart';
import 'package:blog_moble/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  runApp(MyApp(token:token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});

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
          ? Dashboard(token: token!)
          : LoginScreens(),
    );
  }
}
