import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/controller/mentee_controller.dart';
import 'package:super_woman_mentor/ui/screens/chat/chat_screen.dart';
import '../../../../models/chat_mentee.dart';
import '../../../../providers/auth.dart';
import '../../../../providers/themes.dart';
import '../../../../utils/constants.dart';
import 'search_field.dart';

class ChatTab extends StatelessWidget {
  ChatTab({Key? key}) : super(key: key);
  MenteeController menteeController = MenteeController();
  
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeNotifier>(context).isDark;
    Auth auth = Provider.of<Auth>(context);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SearchField(isDark: isDark),
      ),
      const SizedBox(
        height: kDefaultPadding / 2,
      ),
      // MentorFilterList(),
      const SizedBox(
        height: kDefaultPadding / 2,
      ),
      Expanded(
        child: FutureBuilder(
            future: menteeController.fetchChatMentee(auth.token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Faild to load data'),
                  );
                } else if (snapshot.hasData) {
                  List<ChatMentee> chatMentees =
                      snapshot.data as List<ChatMentee>;
                  return ListView.builder(
                    itemCount: chatMentees.length,
                    itemBuilder: (context, index) => ChatMenteeListItem(
                      name: chatMentees[index].firstName +
                          ' ' +
                          chatMentees[index].lastName,
                      lastMessage: chatMentees[index].lastMessage??'',
                      ppic: chatMentees[index].profilePic,
                      noUnreadMessasge:chatMentees[index].unreadMessage ,
                      onPress: () {
                        Navigator.pushNamed(context, ChatScreen.routeName,
                            arguments:{
                             'id': chatMentees[index].id,
                             'name': chatMentees[index].firstName+' '+chatMentees[index].lastName,
                             'ppic': chatMentees[index].profilePic
                            } 
                            
                            );
                      },
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      )
    ]);
  }
}

class ChatMenteeListItem extends StatelessWidget {
  String name;
  String lastMessage;
  String? ppic;
  int noUnreadMessasge;
  final VoidCallback onPress;
  ChatMenteeListItem({
    required this.name,
    required this.lastMessage,
    required this.onPress,
    required this.noUnreadMessasge,
    this.ppic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // isThreeLine: true,
      leading: ppic == null
          ? CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor,
              child: Text(
                name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          : CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(ppic!),
            ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(lastMessage.length <= 30
          ? lastMessage
          : lastMessage.substring(0, 30) + '...'),
      onTap: onPress,
      trailing: noUnreadMessasge>0?Container(
        
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(2)
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(noUnreadMessasge.toString()),): null,
    );

  }
}
