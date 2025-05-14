import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mentalhealthservice {
  final String baseurl = dotenv.env['API_EMULATOR']!;

  Future<Map<String, dynamic>> getAnswer(List<String> answers) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(
      'token',
    ); // Ambil token dari SharedPreferences

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login ulang.',
      };
    }

    final url = Uri.parse('$baseurl/mental-health');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
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

  Future<Map<String, dynamic>> saveMentalHealthResult(
    Map<String, dynamic> data,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(
      'token',
    ); // Ambil token dari SharedPreferences

    if (token == null) {
      return {
        'success': false,
        'message': 'Token tidak ditemukan. Silakan login ulang.',
      };
    }

    final url = Uri.parse('$baseurl/update-mental-health');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Response body: $responseBody');
        return responseBody;
      } else {
        print('Response error: ${response.statusCode}');
        print('Response body: ${response.body}');
        return {'success': false, 'message': 'Gagal menyimpan data'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan koneksi'};
    }
  }
}
