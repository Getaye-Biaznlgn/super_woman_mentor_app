import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import 'sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final  height = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            const SignInForm(),
            Row(
              children: [
                const Text('Don\'t have an account?'),
                const SizedBox(
                  width: kDefaultPadding * 0.5,
                ),
                TextButton(
                  onPressed: () {
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ));
  }

}
