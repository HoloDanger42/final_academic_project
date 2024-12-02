import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';
import '../widgets/comments_section.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat.yMMMd().add_jm().format(post.timestamp);

    return Scaffold(
      appBar: AppBar(
        title: Text(post.content),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: post.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                post.content,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                semanticsLabel: 'Art piece title: ${post.content}',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('User ID: ${post.userId}'),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.thumb_up),
                  SizedBox(width: 4),
                  Text('${post.likesCount} Likes'),
                  SizedBox(width: 16),
                  Icon(Icons.comment),
                  SizedBox(width: 4),
                  Text('${post.commentsCount} Comments'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Posted on: $formattedDate',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommentsSection(postId: post.postId),
            ),
          ],
        ),
      ),
    );
  }
}
