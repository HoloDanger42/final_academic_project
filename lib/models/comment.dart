class Comment {
  final String commentId;
  final String postId;
  final String userId;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'post_id': postId,
      'user_id': userId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['comment_id'],
      postId: json['post_id'],
      userId: json['user_id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
