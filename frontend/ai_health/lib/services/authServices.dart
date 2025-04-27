import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Accept': 'application/json', // ⬅ WAJIB untuk respons JSON
        },
        body: {'name': username, 'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        print('Register successful with status code: ${response.statusCode}');
        return jsonDecode(response.body);
      } else {
        print('Register error: ${response.statusCode}');
        print('Response body: ${response.body}');
        return {
          'success': false,
          'message': 'Gagal register. Cek kembali data dan koneksi.',
        };
      }
    } catch (e) {
      print('Exception during register: $e');
      return {'success': false, 'message': 'Terjadi kesalahan sistem'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json', // ⬅ WAJIB untuk respons JSON
        },
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        print('Login successful with status code: ${response.statusCode}');
        return jsonDecode(response.body);
      } else {
        print('Login error: ${response.statusCode}');
        print('Response body: ${response.body}');
        return {
          'success': false,
          'message': 'Login gagal. Cek kembali email dan password.',
        };
      }
    } catch (e) {
      print('Exception during login: $e');
      return {'success': false, 'message': 'Terjadi kesalahan sistem'};
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      print('No token found. User is already logged out.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer $token', // ⬅ Include token for authentication
        },
      );

      if (response.statusCode == 200) {
        await prefs.remove('token');
        print('Logout successful with status code: ${response.statusCode}');
      } else {
        print('Logout failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Logout failed.');
      }
    } catch (e) {
      print('Exception during logout: $e');
      throw Exception('Terjadi kesalahan saat logout.');
    }
  }
}
