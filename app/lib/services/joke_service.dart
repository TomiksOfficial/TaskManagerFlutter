import 'dart:convert';
import 'package:http/http.dart' as http;

class JokeService {
  static const String _baseUrl = 'https://icanhazdadjoke.com/';
  
  Future<String?> fetchJoke() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Accept': 'application/json'},
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['joke'];
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
}
