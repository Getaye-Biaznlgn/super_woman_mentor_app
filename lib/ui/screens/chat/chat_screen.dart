import 'package:flutter/material.dart';
import 'package:super_woman_mentor/ui/screens/chat/componenets/body.dart';
import '../../../utils/constants.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat-screen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: buildAppBar(context, args),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context, args) {
    return AppBar(
      titleSpacing: 0,
      title: ListTile(
        leading: args['ppic'] == null
            ? CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Text(
                  args['name'].substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(args['ppic']),
              ),
        title: Text(
          args['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
