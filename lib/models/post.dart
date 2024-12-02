class Post {
  final String postId;
  final String userId;
  final String content;
  final String imageUrl;
  final DateTime timestamp;
  final int likesCount;
  final int commentsCount;

  Post({
    required this.postId,
    required this.userId,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
    required this.likesCount,
    required this.commentsCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'content': content,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      userId: json['userId'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      timestamp: DateTime.parse(json['timestamp']),
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
    );
  }
}
