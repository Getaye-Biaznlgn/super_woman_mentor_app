 import 'package:flutter/material.dart';

import 'components/body.dart';

class Profile extends StatelessWidget {
  static const String routeName= '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      )
      ),
      body:   Body(),
    );
  }
}