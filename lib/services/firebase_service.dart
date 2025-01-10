// firebase_service.dart with caching
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, Map<String, dynamic>> _cache = {};

  Future<Map<String, dynamic>> getPlayerData(String playerName) async {
    // Check cache first
    if (_cache.containsKey(playerName)) {
      return _cache[playerName]!;
    }

    try {
      DocumentSnapshot doc = await _firestore
          .collection('batsman')
          .doc(playerName)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        // Store in cache
        _cache[playerName] = data;
        return data;
      }
      return {};
    } catch (e) {
      print('Error fetching player data: $e');
      return {};
    }
  }

  void clearCache() {
    _cache.clear();
  }
}