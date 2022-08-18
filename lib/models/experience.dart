class Experience {
  int id;
  String position;
  String org;
  DateTime from;
  DateTime to;
  // bool isCurrent;
  Experience(
      {required this.id,
      required this.position,
      required this.org,
      required this.from,
      required this.to,
      // required this.isCurrent
      });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
        id: json['id'],
        position: json['position'],
        org: json['organization'],
        from: DateTime.parse(json['from']),
        to: DateTime.parse(json['to']),
        );
  }
}
