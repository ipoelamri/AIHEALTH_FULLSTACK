import 'package:flutter/material.dart';
import 'package:ai_health/commons/constant.dart';

class FeaturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fitur Aplikasi',
          style: TextStyle(color: AppColors.BgLogo),
        ),
        backgroundColor: AppColors.WhiteLogo,
        iconTheme: IconThemeData(color: AppColors.BgLogo),
      ),
      body: Container(
        color: AppColors.BgLogo,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Fitur Utama',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.WhiteLogo,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildFeatureCard(
                  context,
                  icon: Icons.add_moderator,
                  title: 'Consult AI',
                  description:
                      'Ajukan pertanyaan seputar kesehatan kepada AI HealtMan untuk mendapatkan jawaban yang cepat dan akurat.',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.psychology_alt,
                  title: 'V-Therapist',
                  description:
                      'Ajukan pertanyaan seputar kesehatan Mental kepada AI TheraMan untuk mendapatkan jawaban yang cepat dan akurat.',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.balance,
                  title: 'Kalkulator BMI',
                  description:
                      'Hitung Body Mass Index (BMI) Anda untuk mengetahui status berat badan Anda, seperti kurang, normal, atau obesitas.',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.psychology,
                  title: 'Mental Health Check',
                  description:
                      'Cek kondisi kesehatan mental Anda dengan fitur yang dirancang untuk membantu Anda memahami kesehatan mental Anda.',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.directions_run,
                  title: 'Activity Tracker',
                  description:
                      'Catat aktivitas fisik Anda seperti olahraga, durasi latihan, dan pantau riwayat aktivitas Anda.',
                ),
                _buildFeatureCard(
                  context,
                  icon: Icons.person,
                  title: 'Profil Pengguna',
                  description:
                      'Lihat dan kelola data kesehatan Anda, termasuk tinggi badan, berat badan, dan hasil BMI.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.BgLogo,
              child: Icon(icon, color: AppColors.WhiteLogo),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BgLogo,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: AppColors.darkGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
