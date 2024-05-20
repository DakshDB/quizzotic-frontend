import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<Map<String, dynamic>?> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? userString = prefs.getString('user');
  if (userString != null) {
    return jsonDecode(userString);
  }
  return null;
}
