class Message {
  int id;
  int userId;
  int mentorId;
  String message;
  String sender;
  int seen;
  DateTime createdAt;
  Message(
      {required this.id,
      required this.userId,
      required this.mentorId,
      required this.message,
      required this.sender,
      required this.seen,
      required this.createdAt});
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        userId: json['user_id'],
        mentorId: json['mentor_id'],
        message: json['message'],
        sender: json['sender'],
        seen: json['seen']??1,
        createdAt: DateTime.parse(json['created_at']));
  }
}
