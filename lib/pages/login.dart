import 'package:dror_meditations/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        onSignup: (data) {
          _authProvider.register(data.name ?? '', data.password ?? '');
        },
        onLogin: (data) {
          _authProvider.signIn(data.name, data.password);
        },
        onRecoverPassword: (email) {},
        initialAuthMode: AuthMode.signup,
      ),
    );
  }
}
