import 'package:http/http.dart' as http;
import 'dart:convert';

class VirtualTherapistService {
  Future<Map<String, dynamic>> getSuggestion(String condition) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://10.0.2.2:8000/api/therapist',
        ), // Ganti dengan URL API kamu
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'pertanyaan': condition}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Response error: ${response.statusCode}');
        print('Jawaban yang dikirim: $condition');
        print('Response body: ${response.body}');
        return {'message': 'Gagal mendapatkan saran, coba lagi.'};
      }
    } catch (e) {
      return {'message': 'Terjadi kesalahan koneksi.'};
    }
  }
}
