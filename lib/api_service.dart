import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:5000';

  Future<String?> sendDataToIa(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/ia'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Resposta da API: $responseData');
        return responseData['result'];
      } else {
        print('Erro na resposta da API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao enviar dados para a API: $e');
      return null;
    }
  }
}
