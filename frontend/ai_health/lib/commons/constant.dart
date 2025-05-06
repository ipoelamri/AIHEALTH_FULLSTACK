import 'package:flutter/material.dart ';

class AppColors {
  static const Color BgLogo = Color(0xFF00477b); // Deep Blue
  static const Color secondary = Color(0xFF03DAC6); // Teal
  static const Color WhiteLogo = Color(0xFFF5F5F5); // Off White
  static const Color textPrimary = Color(
    0xFF000000,
  ); // Black  // Suggested palette based on BgLogo and WhiteLogo
  static const Color lightBlue = Color(0xFF5A9BD4); // Lighter shade of BgLogo
  static const Color darkBlue = Color(0xFF002F5A); // Darker shade of BgLogo
  static const Color lightGrey = Color(
    0xFFE0E0E0,
  ); // Complementary to WhiteLogo
  static const Color darkGrey = Color(
    0xFFBDBDBD,
  ); // Slightly darker than lightGrey
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
