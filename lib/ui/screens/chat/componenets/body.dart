import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/ui/screens/chat/componenets/chat_message.dart';
import 'package:super_woman_mentor/ui/screens/chat/componenets/message_field.dart';
import '../../../../providers/auth.dart';
import '../../../../providers/message_provider.dart';
import '../../../../providers/themes.dart';
import '../../../../utils/constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => getMessage());
  }

  Future getMessage() async {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    MessageController msgCtrl =
        Provider.of<MessageController>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    isLoading = true;
    await msgCtrl.fetchMessages(auth.token, args['id']);

    isLoading = false;
    msgCtrl.bindAbly(auth.id);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final isDark = Provider.of<ThemeNotifier>(context).isDark;
    MessageController msgCtrl =
        Provider.of<MessageController>(context, listen: true);

    return Column(children: [
      Expanded(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true,
                    itemCount: msgCtrl.messages.length,
                    itemBuilder: (context, index) => ChatMessage(
                        message: msgCtrl.messages[index].message,
                        isMe: msgCtrl.messages[index].sender != 'user',
                        time:
                            '${msgCtrl.messages[index].createdAt.hour}:${msgCtrl.messages[index].createdAt.minute}'),
                  )),
      ),
      MessageField(isDark: isDark, menteeId: args['id'])
    ]);
  }
}
