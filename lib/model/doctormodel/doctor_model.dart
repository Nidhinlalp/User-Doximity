import 'package:flutter/foundation.dart';

class AllDoctorsDetails {
  final String? drUid;
  final String name;
  final String department;
  final String hospital;
  final String location;
  final String explanation;
  final String experience;
  final String patience;
  final String profilePic;
  final String consaltaionFee;
  final List times;
  final bool requst;
  AllDoctorsDetails({
    this.drUid,
    required this.name,
    required this.department,
    required this.hospital,
    required this.location,
    required this.explanation,
    required this.experience,
    required this.patience,
    required this.profilePic,
    required this.consaltaionFee,
    required this.times,
    required this.requst,
  });

  AllDoctorsDetails copyWith({
    String? drUid,
    String? name,
    String? department,
    String? hospital,
    String? location,
    String? explanation,
    String? experience,
    String? patience,
    String? profilePic,
    String? consaltaionFee,
    List? times,
    bool? requst,
  }) {
    return AllDoctorsDetails(
      drUid: drUid ?? this.drUid,
      name: name ?? this.name,
      department: department ?? this.department,
      hospital: hospital ?? this.hospital,
      location: location ?? this.location,
      explanation: explanation ?? this.explanation,
      experience: experience ?? this.experience,
      patience: patience ?? this.patience,
      profilePic: profilePic ?? this.profilePic,
      consaltaionFee: consaltaionFee ?? this.consaltaionFee,
      times: times ?? this.times,
      requst: requst ?? this.requst,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drUid': drUid,
      'name': name,
      'department': department,
      'hospital': hospital,
      'location': location,
      'explanation': explanation,
      'experience': experience,
      'patience': patience,
      'profilePic': profilePic,
      'times': times,
      'requst': requst,
      'consaltaionFee': consaltaionFee,
    };
  }

  factory AllDoctorsDetails.fromJson(Map<String, dynamic> map) {
    return AllDoctorsDetails(
        drUid: map['drUid'],
        name: map['name'] ?? '',
        department: map['department'] ?? '',
        hospital: map['hospital'] ?? '',
        location: map['location'] ?? '',
        explanation: map['explanation'] ?? '',
        experience: map['experience'] ?? '',
        patience: map['patience'] ?? '',
        profilePic: map['profilePic'] ?? '',
        times: List.from(map['times']),
        requst: map['requst'] ?? false,
        consaltaionFee: map['consaltaionFee']);
  }

  @override
  String toString() {
    return 'AllDoctorsDetails(drUid: $drUid, name: $name, department: $department, hospital: $hospital, location: $location, explanation: $explanation, experience: $experience, patience: $patience, profilePic: $profilePic, consaltaionFee: $consaltaionFee, times: $times, requst: $requst)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AllDoctorsDetails &&
        other.drUid == drUid &&
        other.name == name &&
        other.department == department &&
        other.hospital == hospital &&
        other.location == location &&
        other.explanation == explanation &&
        other.experience == experience &&
        other.patience == patience &&
        other.profilePic == profilePic &&
        other.consaltaionFee == consaltaionFee &&
        listEquals(other.times, times) &&
        other.requst == requst;
  }

  @override
  int get hashCode {
    return drUid.hashCode ^
        name.hashCode ^
        department.hashCode ^
        hospital.hashCode ^
        location.hashCode ^
        explanation.hashCode ^
        experience.hashCode ^
        patience.hashCode ^
        profilePic.hashCode ^
        consaltaionFee.hashCode ^
        times.hashCode ^
        requst.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'drUid': drUid,
      'name': name,
      'department': department,
      'hospital': hospital,
      'location': location,
      'explanation': explanation,
      'experience': experience,
      'patience': patience,
      'profilePic': profilePic,
      'consaltaionFee': consaltaionFee,
      'times': times,
      'requst': requst,
    };
  }

  factory AllDoctorsDetails.fromMap(Map<String, dynamic> map) {
    return AllDoctorsDetails(
      drUid: map['drUid'],
      name: map['name'] ?? '',
      department: map['department'] ?? '',
      hospital: map['hospital'] ?? '',
      location: map['location'] ?? '',
      explanation: map['explanation'] ?? '',
      experience: map['experience'] ?? '',
      patience: map['patience'] ?? '',
      profilePic: map['profilePic'] ?? '',
      consaltaionFee: map['consaltaionFee'] ?? '',
      times: List.from(map['times']),
      requst: map['requst'] ?? false,
    );
  }
}
