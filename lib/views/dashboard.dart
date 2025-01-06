import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String token;
  const Dashboard({super.key, required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    print('token:${widget.token}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          "Dashboard:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: Center(
        child: Text('MyApp'),
      ),
    );
  }
}
