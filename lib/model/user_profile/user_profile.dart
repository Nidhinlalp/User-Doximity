class UserProfileData {
  final String name;

  final String profilePic;

  UserProfileData({
    required this.name,
    required this.profilePic,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      name: json['userName'],
      profilePic: json['profilePic'],
    );
  }
}
