// lib/controllers/auth_controller.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String token = responseBody['token'];
      final Map<String, dynamic> user = responseBody['user'];

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user', jsonEncode(user));

      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8080/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String token = responseBody['token'];
      final Map<String, dynamic> user = responseBody['user'];

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user', jsonEncode(user));

      return true;
    } else {
      return false;
    }
  }
}
