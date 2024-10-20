import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:5000";

  Future<String?> sendDataToIa(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/ia"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print('Resposta da API: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['result'];
      } else {
        return "Erro: ${response.statusCode}";
      }
    } catch (e) {
      return null;
    }
  }
}
