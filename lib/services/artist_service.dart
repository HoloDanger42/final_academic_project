import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/artist.dart';

class ArtistService {
  final CollectionReference _artistsCollection =
      FirebaseFirestore.instance.collection('tbl_artists');

  /// Fetch all artists
  Future<List<Artist>> getAllArtists() async {
    try {
      QuerySnapshot snapshot = await _artistsCollection.get();
      return snapshot.docs
          .map((doc) => Artist.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching artists: $e');
      rethrow;
    }
  }

  /// Fetch a specific artist by ID
  Future<Artist?> getArtistById(String userId) async {
    try {
      DocumentSnapshot doc = await _artistsCollection.doc(userId).get();
      if (doc.exists) {
        return Artist.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching artist by ID: $e');
      rethrow;
    }
  }

  /// Add a new artist
  Future<void> addArtist(Artist artist) async {
    try {
      await _artistsCollection.doc(artist.userId).set(artist.toJson());
    } catch (e) {
      print('Error adding artist: $e');
      rethrow;
    }
  }

  /// Update an existing artist
  Future<void> updateArtist(Artist artist) async {
    try {
      await _artistsCollection.doc(artist.userId).update(artist.toJson());
    } catch (e) {
      print('Error updating artist: $e');
      rethrow;
    }
  }

  /// Delete an artist
  Future<void> deleteArtist(String userId) async {
    try {
      await _artistsCollection.doc(userId).delete();
    } catch (e) {
      print('Error deleting artist: $e');
      rethrow;
    }
  }
}
