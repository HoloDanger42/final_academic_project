import 'package:flutter/material.dart';
import 'artist_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(ArtDesignApp());
}

class ArtDesignApp extends StatelessWidget {
  const ArtDesignApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArtShowcaseScreen(),
    );
  }
}

class ArtShowcaseScreen extends StatefulWidget {
  const ArtShowcaseScreen({super.key});

  @override
  _ArtShowcaseScreenState createState() => _ArtShowcaseScreenState();
}

class _ArtShowcaseScreenState extends State<ArtShowcaseScreen> {
  // Mock data simulating posts
  final List<Map<String, dynamic>> mockPosts = [
    {
      'image_url': 'https://via.placeholder.com/150',
      'content': 'Amazing artwork by Artist 1',
      'likes_count': 120,
      'comments_count': 15,
      'time': '2 hours ago',
    },
    {
      'image_url': 'https://via.placeholder.com/150',
      'content': 'Beautiful design by Artist 2',
      'likes_count': 200,
      'comments_count': 25,
      'time': '1 day ago',
    },
    {
      'image_url': 'https://via.placeholder.com/150',
      'content': 'Creative concept by Artist 3',
      'likes_count': 300,
      'comments_count': 35,
      'time': '3 days ago',
    },
    {
      'image_url': 'https://via.placeholder.com/150',
      'content': 'Innovative art by Artist 4',
      'likes_count': 400,
      'comments_count': 45,
      'time': '5 days ago',
    },
    {
      'image_url': 'https://via.placeholder.com/150',
      'content': 'Masterpiece by Artist 5',
      'likes_count': 500,
      'comments_count': 55,
      'time': '1 week ago',
    },
  ];

  // Mock categories
  final List<String> categories = [
    "Home",
    "Pop Art",
    "Cubism",
    "Surrealism",
    "Impressionism"
  ];

  // Currently selected category
  String selectedCategory = "Home";

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leonardo Art", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.people, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/artists'),
            tooltip: 'View Artists',
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories Bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: categories.map((category) {
                  bool isSelected = selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        label: Text(category),
                        backgroundColor:
                            isSelected ? Colors.black : Colors.grey[300],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: mockPosts.map((post) {
                    return SizedBox(
                      width: 192, // Adjusted width for smaller screens
                      child: PostCard(
                        imageUrl: post['image_url'],
                        content: post['content'],
                        likes: post['likes_count'],
                        comments: post['comments_count'],
                        artistName: 'Artist Name',
                        artistProfilePic: 'https://via.placeholder.com/40',
                        time: post['time'], // Passing the time
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Default to "Home"
        onTap: (index) {
          if (index == 0) {
            // Handle Home button
          } else if (index == 1) {
            // Handle Explore button (add functionality if needed)
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String imageUrl;
  final String content;
  final int likes;
  final int comments;
  final String artistName;
  final String artistProfilePic;
  final String? time; // Make time nullable

  PostCard({
    super.key,
    required this.imageUrl,
    required this.content,
    required this.likes,
    required this.comments,
    required this.artistName,
    required this.artistProfilePic,
    required this.time, // time is nullable
  });

  // Sample comment data
  final String userName = "User123";
  final String userProfilePic = 'https://via.placeholder.com/40';
  final String commentText = 'Great art! Love the colors and concept!';
  final String commentTime = '2 hours ago';

  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Comment'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userProfilePic),
                  ),
                  SizedBox(width: 8),
                  Text(
                    userName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(commentText),
              SizedBox(height: 8),
              Text(
                commentTime,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stack for overlapping the artist profile pic and name over the image
          Stack(
            children: [
              // Image occupying the top part of the postcard
              AspectRatio(
                aspectRatio: 1.0, // Ensuring the image is square-shaped
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              // Artist Profile Picture and Name overlapping the image
              Positioned(
                left: 8,
                top: 8,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(artistProfilePic),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the artist profile screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArtistProfilePage(
                              artistName: artistName,
                              artistProfilePic: artistProfilePic,
                              artistBio: 'This is a mock bio for $artistName.',
                              artistArtCollection: [
                                'https://via.placeholder.com/300x200',
                                'https://via.placeholder.com/300x200',
                                'https://via.placeholder.com/300x200',
                                'https://via.placeholder.com/300x200',
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        artistName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white, // Ensure visibility on the image
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Like and Comment Icons Above the Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Text('$likes'),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Show the comment dialog
                    _showCommentDialog(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.comment, color: Colors.blue, size: 16),
                      SizedBox(width: 4),
                      Text('$comments'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Post Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(content),
          ),

          // Display Time of Post
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              time ?? 'Time not available', // Provide fallback if time is null
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
