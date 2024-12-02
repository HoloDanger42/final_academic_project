import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment.dart';

class CommentService {
  final CollectionReference _commentsCollection =
      FirebaseFirestore.instance.collection('tbl_comments');

  // Fetch comments for a specific post
  Future<List<Comment>> getCommentsByPostId(String postId) async {
    try {
      QuerySnapshot snapshot = await _commentsCollection
          .where('postId', isEqualTo: postId)
          .orderBy('timestamp', descending: false)
          .get();
      return snapshot.docs
          .map((doc) => Comment.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching comments: $e');
      rethrow;
    }
  }

  // Add a new comment
  Future<void> addComment(Comment comment) async {
    try {
      await _commentsCollection.doc(comment.commentId).set(comment.toJson());
    } catch (e) {
      print('Error adding comment: $e');
      rethrow;
    }
  }

  // Update an existing comment
  Future<void> updateComment(Comment comment) async {
    try {
      await _commentsCollection.doc(comment.commentId).update(comment.toJson());
    } catch (e) {
      print('Error updating comment: $e');
      rethrow;
    }
  }

  // Delete a comment
  Future<void> deleteComment(String commentId) async {
    try {
      await _commentsCollection.doc(commentId).delete();
    } catch (e) {
      print('Error deleting comment: $e');
      rethrow;
    }
  }
}
