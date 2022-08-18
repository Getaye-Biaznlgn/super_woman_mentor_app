class ChatMentee {
  int id;
  String firstName;
  String lastName;
  String profilePic;
  String? lastMessage;
  int unreadMessage;
  ChatMentee(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.profilePic,
      required this.lastMessage,
      required this.unreadMessage
      });

  factory ChatMentee.fromJson(Map<String, dynamic> json) {
    return ChatMentee(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        profilePic: json['profile_picture'],
        unreadMessage: json['no'],
        lastMessage: json['message']?['message']);
  }
}
