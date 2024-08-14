import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<List<dynamic>> fetchContacts() async {
    final response = await http.get(Uri.parse('$baseUrl/contacts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  static Future<void> createPost(Map<String, dynamic> post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create post');
    }
  }

  static Future<void> createContact(Map<String, dynamic> contact) async {
    final response = await http.post(
      Uri.parse('$baseUrl/contacts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(contact),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create contact');
    }
  }

  static Future<void> sendMessage(Map<String, dynamic> message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(message),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  static Future<List<dynamic>> fetchMessages(String from, String to) async {
    final response = await http.get(Uri.parse('$baseUrl/messages/$from/$to'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
