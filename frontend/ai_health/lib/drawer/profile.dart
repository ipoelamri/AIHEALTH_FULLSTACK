import 'package:flutter/material.dart';
import 'package:ai_health/services/ProfileService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _profileService = ProfileService();
  String _bmi = 'Memuat...';
  String _mentalHealth = 'Memuat...';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      setState(() {
        _bmi = 'Token tidak ditemukan';
        _mentalHealth = 'Token tidak ditemukan';
      });
      return;
    }

    try {
      final result = await _profileService.fetchUserProfile(token);

      if (result.containsKey('error') && result['error'] == true) {
        setState(() {
          _bmi = 'Data tidak ditemukan';
          _mentalHealth = 'Data tidak ditemukan';
        });
      } else {
        // Validasi apakah hasil null atau tidak
        final bmiValue = result['bmi']?.toString() ?? 'Belum ada data';
        final mentalHealthValue = result['mental_health'] ?? 'Belum ada data';

        setState(() {
          _bmi = bmiValue == 'null' ? 'Belum ada data' : bmiValue;
          _mentalHealth =
              mentalHealthValue == 'null'
                  ? 'Belum ada data'
                  : mentalHealthValue;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _bmi = 'Gagal memuat data';
        _mentalHealth = 'Gagal memuat data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Anda'),
        backgroundColor: Color(0xFF00477b),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Kesehatan Anda',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BMI:', style: TextStyle(fontSize: 16)),
                        Text(
                          _bmi,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kondisi Mental:', style: TextStyle(fontSize: 16)),
                        Text(
                          _mentalHealth,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00477b),
              ),
              onPressed: fetchData,
              child: Text('Refresh Data'),
            ),
          ],
        ),
      ),
    );
  }
}
