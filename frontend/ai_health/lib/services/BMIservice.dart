import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BMIService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<void> saveBMI({
    required double height,
    required double weight,
    required double totalBMI,
    required String resultMessage,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("Token tidak ditemukan");
      return;
    }

    try {
      // Bulatkan nilai height dan weight
      final int roundedHeight = height.toInt();
      final int roundedWeight = weight.toInt();

      // Format total_bmi menjadi 2 angka di belakang koma
      final String formattedBMI = totalBMI.toStringAsFixed(2);

      print('URL: $baseUrl/update-bmi');
      print('Token: $token');
      print(
        'Data yang dikirim: ${jsonEncode({'bmi': resultMessage, 'height': roundedHeight, 'weight': roundedWeight, 'total_bmi': formattedBMI})}',
      );

      final response = await http.post(
        Uri.parse('$baseUrl/update-bmi'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'bmi': resultMessage,
          'height': roundedHeight,
          'weight': roundedWeight,
          'total_bmi': formattedBMI,
        }),
      );

      if (response.statusCode == 200) {
        print("BMI berhasil diupdate di database");
      } else {
        print('Response error: ${response.statusCode}');
        print("Gagal mengupdate BMI: ${response.body}");
      }
    } catch (e) {
      print("Terjadi kesalahan koneksi: $e");
    }
  }
}
