class BookingDrDetails {
  final DateTime? date;
  final String name;
  final String time;
  final String userUid;
  final bool acept;
  final bool decline;
  final bool complete;
  final String profilePic;
  final String drName;
  final String department;

  BookingDrDetails({
    required this.name,
    required this.date,
    required this.time,
    required this.userUid,
    required this.acept,
    required this.decline,
    required this.complete,
    required this.profilePic,
    required this.drName,
    required this.department,
  });

  factory BookingDrDetails.fromJson(Map<String, dynamic> json) {
    return BookingDrDetails(
        name: json['patientName'],
        date: DateTime.tryParse(json['date']),
        time: json['time'],
        userUid: json['userUid'],
        acept: json['acept'],
        decline: json['decline'],
        complete: json['completed'],
        profilePic: json['profilePic'],
        drName: json['drname'],
        department: json['department']);
  }
}
