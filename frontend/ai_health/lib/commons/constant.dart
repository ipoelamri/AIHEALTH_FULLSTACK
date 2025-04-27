import 'package:flutter/material.dart ';

class AppColors {
  static const Color BgLogo = Color(0xFF00477b);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color WhiteLogo = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF757575);
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
}

Widget buildCardWithIcon(String title, IconData icon, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 100,
        height: 80,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget DrawerItem({
  required String title,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.textPrimary),
    title: Text(title, style: TextStyle(color: AppColors.textPrimary)),
    onTap: onTap,
  );
}
