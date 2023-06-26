import 'dart:convert';

class AllDoctorsDetails {
  final String name;
  final String explanation;
  final String profilepic;
  AllDoctorsDetails({
    required this.name,
    required this.explanation,
    required this.profilepic,
  });

  AllDoctorsDetails copyWith({
    String? name,
    String? explanation,
    String? profilepic,
  }) {
    return AllDoctorsDetails(
      name: name ?? this.name,
      explanation: explanation ?? this.explanation,
      profilepic: profilepic ?? this.profilepic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'explanation': explanation,
      'profilepic': profilepic,
    };
  }

  factory AllDoctorsDetails.fromMap(Map<String, dynamic> map) {
    return AllDoctorsDetails(
      name: map['name'] ?? '',
      explanation: map['explanation'] ?? '',
      profilepic: map['profilepic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AllDoctorsDetails.fromJson(String source) =>
      AllDoctorsDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'AllDoctorsDetails(name: $name, explanation: $explanation, profilepic: $profilepic)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllDoctorsDetails &&
        other.name == name &&
        other.explanation == explanation &&
        other.profilepic == profilepic;
  }

  @override
  int get hashCode =>
      name.hashCode ^ explanation.hashCode ^ profilepic.hashCode;
}
