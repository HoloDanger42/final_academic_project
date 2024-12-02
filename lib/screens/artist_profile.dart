import 'package:flutter/material.dart';

class ArtistProfilePage extends StatelessWidget {
  final String artistName;
  final String artistProfilePic;
  final String artistBio;
  final List<String> artistArtCollection;

  const ArtistProfilePage({
    super.key,
    required this.artistName,
    required this.artistProfilePic,
    required this.artistBio,
    required this.artistArtCollection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$artistName\'s Profile'),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Change the back arrow icon color to white
        ),
        titleTextStyle: TextStyle(
          color: Colors.white, // Change the title text color to white
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist Profile Picture and Name
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(artistProfilePic),
                ),
                SizedBox(width: 16),
                Text(
                  artistName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Artist Bio
            Text(
              artistBio,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            // Art Collection Grid
            Text(
              'Art Collection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: artistArtCollection.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: Image.network(
                      artistArtCollection[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
