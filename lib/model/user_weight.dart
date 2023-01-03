class UserWeight {
  static const String collectionName = 'user_weight';
  String id;
  String weight;
  String note;
  int time;

  UserWeight(
      {this.id = '',
      required this.weight,
      required this.note,
      required this.time});

  UserWeight.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          weight: json['weight'],
          time: json['time'],
          note: json['note'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'time': time,
      'note': note,
    };
  }
}
