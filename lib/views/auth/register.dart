import 'package:blog_moble/controllers/authController.dart';
import 'package:blog_moble/views/auth/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool showPass = false;
  bool showPass2 = false;
  final formState = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  //===== Validate Email =====
  bool isEmailValid(String email) {
    RegExp regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return regex.hasMatch(email);
  }

  AuthController authController = AuthController(); //create object

  void signUp() async {
    if (formState.currentState!.validate()) {
      final data = await authController.register(
        usernameController.text,
        emailController.text,
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
      );

      if (data['message'] == 'Registered Successfully') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreens(),
          ),
        );
      }
      else{
        print("Not register");
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
            padding: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //==== Image Register =====
                Image.asset(
                  'assets/images/register.png',
                  width: size.width - 200,
                ),
                //===== Text Register=====
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                //===== Form Sign in =====
                Form(
                  key: formState,
                  child: Column(
                    children: [
                      //===== Enter Username =====
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('User name is empty');
                            return 'User name is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your User name',
                          label: const Text('User name'),
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //===== Enter FirstName =====
                      TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('First Name is empty');
                            return 'First Name is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your first name',
                          label: const Text('First Name'),
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //===== Enter LastName =====
                      TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('Last Name is empty');
                            return 'Last Name is empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Last name',
                          label: const Text('Last Name'),
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //===== Enter Email =====
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
                          hintText: 'Enter your email',
                          label: const Text('Email'),
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //===== Enter Password =====
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: !showPass,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('Password is empty');
                            return 'Password is empty';
                          } else if (value.length < 6) {
                            debugPrint('Password too short');
                            return 'Password too short';
                          }
                          return null;
                        },
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
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      //===== Enter Confirm Password =====
                      TextFormField(
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: !showPass2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            debugPrint('Confirm Password is empty');
                            return 'Confirm Password is empty';
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            debugPrint('Error:Password do not match');
                            return 'Error:Password do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your Confirm password',
                          label: const Text('Confirm Password'),
                          labelStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontFamily: "verdana_regular",
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.vpn_key_sharp),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPass2 = !showPass2;
                              });
                            },
                            icon: Icon(
                              showPass2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // ===== Button submit login =====
                      InkWell(
                        onTap: () {
                          setState(() {
                            signUp();
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.lock_open, color: Colors.white),
                              SizedBox(width: 5.0),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 2,
                                  color: Colors.white,
                                ),
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
                      "Already have an account?",
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
                                  builder: (context) => const LoginScreens()));
                        });
                      },
                      child: const Text(
                        ' Sign In',
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
