import 'dart:convert';
import 'package:http/http.dart' as http;

class GPTService {
  static final String apiUrl =
      'http://10.0.2.2:8000/api/tanya'; // ganti jika dihosting

  static Future<String> getResponse(String pertanyaan) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pertanyaan': pertanyaan}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['jawaban'];
    } else {
      throw Exception('Gagal mendapatkan jawaban');
    }
  }
}
