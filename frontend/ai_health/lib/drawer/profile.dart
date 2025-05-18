import 'package:ai_health/commons/constant.dart';
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
  String _name = 'Memuat...';
  String _height = 'Memuat...';
  String _weight = 'Memuat...';
  String _totalbmi = 'Memuat...';

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
        _name = 'Token tidak ditemukan';
      });
      return;
    }

    try {
      final result = await _profileService.fetchUserProfile(token);

      if (result.containsKey('error') && result['error'] == true) {
        setState(() {
          _name = 'Data tidak ditemukan';
          _height = 'Data tidak ditemukan';
          _weight = 'Data tidak ditemukan';
          _totalbmi = 'Data tidak ditemukan';
          _bmi = 'Data tidak ditemukan';
          _mentalHealth = 'Data tidak ditemukan';
        });
      } else {
        final bmiValue = result['bmi']?.toString() ?? 'Belum ada data';
        final mentalHealthValue = result['mental_health'] ?? 'Belum ada data';
        final nameValue = result['name'] ?? 'Belum ada data';

        // Modifikasi pengecekan
        final heightValue =
            result['height'] != null
                ? (double.tryParse(
                      result['height'].toString(),
                    )?.round().toString() ??
                    'Belum ada data')
                : 'Belum ada data';

        final weightValue =
            result['weight'] != null
                ? (double.tryParse(
                      result['weight'].toString(),
                    )?.round().toString() ??
                    'Belum ada data')
                : 'Belum ada data';

        final totalbmiValue =
            result['total_bmi'] != null
                ? (double.tryParse(
                      result['total_bmi'].toString(),
                    )?.toStringAsFixed(2) ??
                    'Belum ada data')
                : 'Belum ada data';

        setState(() {
          _name = nameValue == 'null' ? 'Belum ada data' : nameValue;
          _bmi = bmiValue == 'null' ? 'Belum ada data' : bmiValue;
          _mentalHealth =
              mentalHealthValue == 'null'
                  ? 'Belum ada data'
                  : mentalHealthValue;
          _height = heightValue == 'null' ? 'Belum ada data' : heightValue;
          _weight = weightValue == 'null' ? 'Belum ada data' : weightValue;
          _totalbmi =
              totalbmiValue == 'null' ? 'Belum ada data' : totalbmiValue;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _bmi = 'Gagal memuat data';
        _mentalHealth = 'Gagal memuat data';
        _name = 'Gagal memuat data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F8FB),
      appBar: AppBar(
        title: Text('Profil Anda', style: TextStyle(color: AppColors.BgLogo)),
        backgroundColor: AppColors.WhiteLogo,
        iconTheme: IconThemeData(color: AppColors.BgLogo),
        elevation: 0,
      ),
      body: Container(
        color: AppColors.BgLogo,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.WhiteLogo,
                  child: Icon(Icons.person, color: AppColors.BgLogo, size: 60),
                ),
                SizedBox(height: 16),
                Text(
                  'Selamat datang, $_name ! ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.WhiteLogo,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Silahkan cek data kesehatan Anda',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lightGrey,
                  ),
                ),
                SizedBox(height: 10),
                // Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 6,
                  shadowColor: Color(0x2200477b),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Color(0xFF00477b),
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00477b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 32, thickness: 1.2),
                        Row(
                          children: [
                            Icon(
                              Icons.height,
                              color: Color(0xFF00477b),
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tinggi Badan (cm)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _height,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00477b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 32, thickness: 1.2),
                        Row(
                          children: [
                            Icon(
                              Icons.monitor_weight,
                              color: Color(0xFF00477b),
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Berat Badan (kg)',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _weight,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00477b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 32, thickness: 1.2),
                        Row(
                          children: [
                            Icon(
                              Icons.calculate,
                              color: Color(0xFF00477b),
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total BMI',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _totalbmi,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00477b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 32, thickness: 1.2),
                        Row(
                          children: [
                            Icon(
                              Icons.monitor_weight,
                              color: Color(0xFF00477b),
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BMI',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _bmi,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00477b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 32, thickness: 1.2),
                        Row(
                          children: [
                            Icon(
                              Icons.psychology,
                              color: Color(0xFF00477b),
                              size: 32,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kondisi Mental',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _mentalHealth,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00477b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xFF00477b),
                //     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     elevation: 2,
                //   ),
                //   onPressed: fetchData,
                //   icon: Icon(Icons.refresh, color: AppColors.WhiteLogo),
                //   label: Text(
                //     'Refresh Data',
                //     style: TextStyle(color: AppColors.WhiteLogo, fontSize: 16),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
