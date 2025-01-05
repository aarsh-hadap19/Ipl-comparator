import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<Map<String, dynamic>> fetchPlayerStats(String playerName) async {
  try {
    final String serverUrl = Platform.isAndroid
        ? 'http://10.0.2.2:5000/stats'
        : 'http://localhost:5000/stats';

    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': playerName}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': 'Player not found or an error occurred'};
    }
  } catch (e) {
    return {'error': 'Failed to connect to server'};
  }
}
