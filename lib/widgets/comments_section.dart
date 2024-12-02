import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class CommentsSection extends StatefulWidget {
  final String postId;

  const CommentsSection({super.key, required this.postId});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final CommentService _commentService = CommentService();
  final TextEditingController _commentController = TextEditingController();
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() {
    setState(() {
      _commentsFuture = _commentService.getCommentsByPostId(widget.postId);
    });
  }

  Future<void> _addComment() async {
    if (_commentController.text.trim().isEmpty) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    Comment newComment = Comment(
      commentId: const Uuid().v4(),
      postId: widget.postId,
      userId: user.uid,
      content: _commentController.text.trim(),
      timestamp: DateTime.now(),
    );

    await _commentService.addComment(newComment);
    _commentController.clear();
    _fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List<Comment>>(
          future: _commentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No comments found.'));
            } else {
              List<Comment> comments = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  Comment comment = comments[index];
                  return ListTile(
                    title: Text(comment.content),
                    subtitle: Text('User ID: ${comment.userId}'),
                  );
                },
              );
            }
          },
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Add a comment',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _addComment,
            ),
          ],
        ),
      ],
    );
  }
}
