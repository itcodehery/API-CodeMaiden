import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:translator_libre_flutter/constants.dart';
import 'package:toastification/toastification.dart';

enum AuthenType {
  signIn,
  signUp,
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthenType _authenType = AuthenType.signIn;
  late final StreamSubscription<AuthState> _auth;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _auth = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        if (mounted) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/home");
        }
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _auth.cancel();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      debugPrint(e.toString());
      toastification.show(
          title: const Text("Couldn't sign in! Try again."),
          type: ToastificationType.error);
    }
  }

  Future<void> _signUp() async {
    try {
      await supabase.auth
          .signUp(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((c) async {
        await supabase.from('users').insert({
          'id': c.user!.id,
          'username': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });
      });
    } catch (e) {
      debugPrint(e.toString());
      toastification.show(
          title: const Text("Couldn't sign up! Try again."),
          type: ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Authen'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton(
                  segments: const <ButtonSegment<AuthenType>>[
                    ButtonSegment(
                        value: AuthenType.signIn, label: Text('Login')),
                    ButtonSegment(
                        value: AuthenType.signUp, label: Text('Sign Up')),
                  ],
                  selected: <AuthenType>{_authenType},
                  onSelectionChanged: (value) {
                    setState(() {
                      _authenType = value.first;
                    });
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                if (_authenType == AuthenType.signUp)
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if (_authenType == AuthenType.signIn) {
                      _login();
                    } else {
                      _signUp();
                    }
                  },
                  child: Text(
                      _authenType == AuthenType.signIn ? 'Login' : 'Sign Up'),
                ),
              ],
            ),
          ),
        ));
  }
}
