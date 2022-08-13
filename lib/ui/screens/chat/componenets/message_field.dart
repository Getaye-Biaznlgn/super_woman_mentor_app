import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth.dart';
import '../../../../providers/message_provider.dart';

class MessageField extends StatelessWidget {
  MessageField({
    Key? key,
    required this.menteeId,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;
  final int menteeId;
  TextEditingController fieldController = TextEditingController();
  _submitForm(token, msgCtrl) async {
    if (fieldController.text == "") return;

    try {
      await msgCtrl.sendMessage(fieldController.text, menteeId, token);
      fieldController.clear();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    MessageController msgCtrl = Provider.of<MessageController>(context);
    return Card(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.transparent : const Color(0xFFF7F7F7),
        ),
        child: TextField(
          controller: fieldController,
          maxLines: null,
          decoration: InputDecoration(
              hintText: 'Write a message...',
              suffixIcon: IconButton(
                  onPressed: () {
                    _submitForm(auth.token, msgCtrl);
                  },
                  icon: const Icon(
                    Icons.send,
                    // color: kPrimaryColor,
                    size: 32,
                  ))),
        ),
      ),
    );
  }
}
