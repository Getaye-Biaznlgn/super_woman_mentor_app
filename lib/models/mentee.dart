class Mentee {
  int id;
  String firstName;
  String lastName;
  String profilePic;
  String educationLevel;

  Mentee(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.profilePic,
      required this.educationLevel});

  factory Mentee.fromJson(Map<String, dynamic> json) {
    return Mentee(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        profilePic: json['profile_picture'],
        educationLevel: json['education_level']['level']);
  }
}
