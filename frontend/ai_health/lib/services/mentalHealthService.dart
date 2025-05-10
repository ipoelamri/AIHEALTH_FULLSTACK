import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Mentalhealthservice {
  final String baseurl = dotenv.env['API_EMULATOR']!;

  Future<Map<String, dynamic>> getAnswer(List<String> answers) async {
    final url = Uri.parse('$baseurl/mental-health');

    try {
      final response = await http.post(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode({'answer': answers}),
      );

      if (response.statusCode == 200) {
        print('Response successful with status code: ${response.statusCode}');
        return jsonDecode(response.body);
      } else {
        print('Response error: ${response.statusCode}');
        print('Jawaban yang dikirim: $answers');
        print('Response body: ${response.body}');
        return {
          'success': false,
          'message': 'Gagal mendapatkan jawaban. Cek kembali data dan koneksi.',
        };
      }
    } catch (e) {
      print('Exception during response: $e');

      return {'success': false, 'message': 'Terjadi kesalahan sistem'};
    }
  }
}
