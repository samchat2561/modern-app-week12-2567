import 'dart:convert';
import 'package:blog_moble/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthController {
  //For Register
  Future<dynamic> register(username, email, password, firstName, lastName) async {
    String registerUrl = "/auth/register";
    //apiUrl = http://192.168.1.110:3000/api/auth/register
    final apiUrl = url + registerUrl;
    final res = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{
        "username": username,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );

    // Create new users
    if (res.statusCode == 201) {
      final data = jsonDecode(res.body);
      print(data['status']);
      print(data['message']);
      return data;
    }

    // User already exists
    if (res.statusCode == 400) {
      final data = jsonDecode(res.body);
      print(data['status']);
      print(data['message']);
      return data;
    }
  }

  //For Login
  Future<dynamic> loginAuth(email, password) async {
    String loginUrl = "/auth/login";
    //apiUrl = http://192.168.1.110:3000/api/auth/login
    final apiUrl = url + loginUrl;
    final res = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      print('status:${data['status']}');
      print('message:${data['message']}');
      print('token:${data['token']}');

      return data;
    }

    if (res.statusCode == 401) {
      final data = jsonDecode(res.body);
      print(data['status']);
      print(data['message']);
      return data;
    }
  }
}
