class Artist {
  final String userId;
  final String name;
  final String profilePicture;
  final String bio;

  Artist({
    required this.userId,
    required this.name,
    required this.profilePicture,
    required this.bio,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'profile_picture': profilePicture,
      'bio': bio,
    };
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      userId: json['user_id'] ?? '',
      name: json['name'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      bio: json['bio'] ?? '',
    );
  }
}
