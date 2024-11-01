import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://localhost:5000';
  Future<String> detectAnomalies(String passwordData) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/ia'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'password': passwordData}),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result['result'] ?? 'Erro na resposta';
      } else {
        return 'Erro: ${response.statusCode}';
      }
    } catch (e) {
      return 'Erro na comunicação com o backend: $e';
    }
  }
}
