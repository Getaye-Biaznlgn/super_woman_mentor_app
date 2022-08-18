import 'package:flutter/material.dart';
import 'components/body.dart';

class Availability extends StatelessWidget {
  static const String routeName= '/availability';
  const Availability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title: const Text('Set Availability'),
   leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      )
  ),
  body: Body()
    );
  }
}