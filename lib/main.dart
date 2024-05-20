// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzotic_frontend/screens/home.dart';
import 'package:quizzotic_frontend/modals/login_modal.dart';
import 'package:quizzotic_frontend/modals/signup_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzotic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Quizzotic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if (userString != null) {
      final Map<String, dynamic> user = jsonDecode(userString);
      setState(() {
        userName = user['name'];
      });
    }
  }

  Future<void> _signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    setState(() {
      userName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          if (userName != null)
            PopupMenuButton<String>(
              onSelected: (String result) {
                switch (result) {
                  case 'Signout':
                    _signOut();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'Profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Settings',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Signout',
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Signout'),
                  ),
                ),
              ],
              child: Row(
                children: [
                  Text(userName!),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LoginModal(onLoginSuccess: _loadUser);
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.app_registration),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SignupModal(onSignupSuccess: _loadUser);
                  },
                );
              },
            ),
          ],
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quizzotic',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
