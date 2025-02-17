import 'package:blog_moble/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final String token;
  final String username;
  final String email;
  const Dashboard({super.key, required this.token, required this.username, required this.email});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences prefs;
  late SharedPreferences logout;
  late String email;
  late String username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    print('token:${widget.token}');
    print('token:${widget.email}');
    print('token:${widget.username}');
  }

  void logOut() async {
    logout = await SharedPreferences.getInstance();
    logout.clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreens()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xffe0e0e0),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.0),
                bottomRight: Radius.circular(60.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 32, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: IconButton(
                          onPressed: () {
                            logOut();
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 60.0),
                      child: Icon(
                        Icons.home,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 160,
            left: 18,
            child: Image.asset('assets/images/hacker.png', scale: 3.8),
          ),
          Positioned(
            top: 180,
            left: 150,
            child: Text(
              'Username:${widget.username}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 200,
            left: 150,
            child: Text(
              'Email:${widget.email}',
              style: TextStyle(color: Colors.white),
            ),
          ),

        ],
      ),
    );
  }
}
