import 'package:flutter/material.dart';
import 'components/body.dart';

class SignIn extends StatelessWidget {
  static String routeName = '/login';
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset :false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Sign In',
        ),
      ),
      body: const Body(),
    );
  }
}

