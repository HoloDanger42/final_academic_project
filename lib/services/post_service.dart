import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class PostService {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('tbl_posts');

  /// Fetch all posts
  Future<List<Post>> getAllPosts() async {
    try {
      QuerySnapshot snapshot =
          await _postsCollection.orderBy('timestamp', descending: true).get();
      return snapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching posts: $e');
      rethrow;
    }
  }

  /// Fetch a specific post by ID
  Future<Post?> getPostById(String postId) async {
    try {
      DocumentSnapshot doc = await _postsCollection.doc(postId).get();
      if (doc.exists) {
        return Post.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching post by ID: $e');
      rethrow;
    }
  }

  /// Add a new post
  Future<void> addPost(Post post) async {
    try {
      await _postsCollection.doc(post.postId).set(post.toJson());
    } catch (e) {
      print('Error adding post: $e');
      rethrow;
    }
  }

  // Update an existing post
  Future<void> updatePost(Post post) async {
    try {
      await _postsCollection.doc(post.postId).update(post.toJson());
    } catch (e) {
      print('Error updating post: $e');
      rethrow;
    }
  }

  /// Delete a post
  Future<void> deletePost(String postId) async {
    try {
      await _postsCollection.doc(postId).delete();
    } catch (e) {
      print('Error deleting post: $e');
      rethrow;
    }
  }
}
