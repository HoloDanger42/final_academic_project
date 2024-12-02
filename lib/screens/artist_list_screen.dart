import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../services/artist_service.dart';

class ArtistListScreen extends StatefulWidget {
  const ArtistListScreen({super.key});

  @override
  State<ArtistListScreen> createState() => _ArtistListScreenState();
}

class _ArtistListScreenState extends State<ArtistListScreen> {
  final ArtistService _artistService = ArtistService();
  late Future<List<Artist>> _artistsFuture;

  @override
  void initState() {
    super.initState();
    _artistsFuture = _artistService.getAllArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists'),
      ),
      body: FutureBuilder<List<Artist>>(
        future: _artistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No artists found.'));
          } else {
            List<Artist> artists = snapshot.data!;
            return ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                Artist artist = artists[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: artist.profilePicture.isNotEmpty
                        ? NetworkImage(artist.profilePicture)
                        : null,
                    child: artist.profilePicture.isEmpty
                        ? const Icon(Icons.person, color: Colors.grey)
                        : null,
                  ),
                  title: Text(artist.name),
                  subtitle: Text(
                    artist.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/artistDetail',
                      arguments: artist,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
