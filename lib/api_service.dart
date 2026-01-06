import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://YOUR_MOCKAPI_ID.mockapi.io/api/v1";

  // GET
  static Future<List<dynamic>> getData(String endpoint) async {
    final response = await http.get(Uri.parse("$baseUrl/$endpoint"));
    return jsonDecode(response.body);
  }

  // POST
  static Future<void> postData(String endpoint, Map data) async {
    await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // PUT
  static Future<void> putData(String endpoint, String id, Map data) async {
    await http.put(
      Uri.parse("$baseUrl/$endpoint/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }
}
