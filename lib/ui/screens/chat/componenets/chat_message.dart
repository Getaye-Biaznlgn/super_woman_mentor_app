import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/themes.dart';
import '../../../../utils/constants.dart';

class ChatMessage extends StatelessWidget {
  final bool isMe;
  final String time;
  final String message;
  const ChatMessage({
    required this.isMe,
    required this.time,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isDark = Provider.of<ThemeNotifier>(context).isDark;
    return Container(
      margin: EdgeInsets.only(
          top: kDefaultPadding,
          left: isMe ? width * 0.20 : 0,
          right: !isMe ? width * 0.20 : 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft: isMe
                  ? const Radius.circular(10)
                  : const Radius.elliptical(500, 0),
              bottomRight: isMe
                  ? const Radius.elliptical(500, 0)
                  : const Radius.circular(10)),
          color: isDark
              ? const Color.fromARGB(59, 88, 116, 146)
              : const Color(0xffd1d1d1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
          ),
          Text(
            time,
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}
