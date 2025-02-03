import 'package:blog_moble/controllers/authController.dart';
import 'package:blog_moble/views/auth/register.dart';
import 'package:blog_moble/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:blog_moble/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  bool showPass = false;
  final formState = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref()async{
    prefs = await SharedPreferences.getInstance();
  }

  //===== Validate Email =====
  bool isEmailValid(String email) {
    RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return regex.hasMatch(email);
  }

  AuthController authController = AuthController();

  void login() async {
    if (formState.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      final data = await authController.loginAuth(
        emailController.text,
        passwordController.text,
      );

      if (data['message'] == 'success') {
        final myToken = data['token'];
        final username = data['username'];
        final email = data['email'];

        prefs.setString('token', myToken);
        prefs.setString('username', username);
        prefs.setString('email', email);

        print(myToken);

        await Future.delayed(Duration(seconds: 3));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              token:myToken,
              username: username,
              email: email,
              // token: data['token'],
            ),
          ),
        );
      } else {
        setState(() {
          loading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('SignIn'),
            content: Text("Theis email/password is not on our data"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ===== Images Login =====
                Image.asset(
                  'assets/images/login.png',
                  // width: size.width * 0.9,
                  width: size.width - 100,
                ),
                // ===== Text Login =====
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                // ===== Form Login =====
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      // ===== Enter field Email =====
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('email is empty');
                            return 'email is empty';
                          } else if (!isEmailValid(value)) {
                            debugPrint('ERROR is email');
                            return 'ERROR is email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter your email or username',
                            label: const Text('Email or username'),
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(Icons.email),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(height: 10.0),
                      // ===== Enter field password  const TextField(),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('password is empty');
                            return 'password is empty';
                          }
                          return null;
                        },
                        obscureText: !showPass,
                        decoration: InputDecoration(
                            hintText: 'Enter your password',
                            label: const Text('Password'),
                            labelStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(Icons.vpn_key_sharp),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(
                                showPass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(height: 10.0),
                      // ===== Button submit login =====
                      InkWell(
                        onTap: () {
                          setState(() {
                            login();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          height: 55.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: loading == false
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.lock_open, color: Colors.white),
                                    SizedBox(width: 5.0),
                                    Text(
                                      "Sign In",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 2,
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 20.0,
                                      width: 20.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Loading...",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          wordSpacing: 2,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                // ===== Button Link Register =====
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()));
                        });
                      },
                      child: const Text(
                        ' Sign Up',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
