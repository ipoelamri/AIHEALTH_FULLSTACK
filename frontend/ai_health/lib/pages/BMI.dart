import 'package:ai_health/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmi;
  String _resultMessage = "";

  final String baseUrl = 'http://10.0.2.2:8000/api';

  void _calculateBMI() async {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
        if (_bmi! < 18.5) {
          _resultMessage = "Berat badan kurang";
        } else if (_bmi! < 24.9) {
          _resultMessage = "Berat badan normal";
        } else if (_bmi! < 29.9) {
          _resultMessage = "Berat badan berlebih";
        } else {
          _resultMessage = "Obesitas";
        }
      });

      // Setelah perhitungan selesai, simpan ke database
      await _saveToDatabase(_bmi!);
    } else {
      setState(() {
        _resultMessage = "Please enter valid values!";
      });
    }
  }

  Future<void> _saveToDatabase(double bmi) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      print("Token tidak ditemukan");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update-bmi'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'bmi': bmi.toStringAsFixed(2)}),
      );

      if (response.statusCode == 200) {
        print("BMI berhasil diupdate di database");
      } else {
        print("Gagal mengupdate BMI: ${response.body}");
      }
    } catch (e) {
      print("Terjadi kesalahan koneksi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(color: AppColors.BgLogo),
        ),
        iconTheme: IconThemeData(color: AppColors.BgLogo),
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.BgLogo),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('lib/assets/images/logo.png', width: 200, height: 200),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.WhiteLogo),
                    decoration: InputDecoration(
                      labelText: "Height (cm)",
                      labelStyle: TextStyle(color: AppColors.WhiteLogo),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.WhiteLogo,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.WhiteLogo),
                    decoration: InputDecoration(
                      labelText: "Weight (kg)",
                      labelStyle: TextStyle(color: AppColors.WhiteLogo),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.WhiteLogo,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calculateBMI,
                    child: Text("Calculate BMI"),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _bmi != null
                          ? "Your BMI: ${_bmi!.toStringAsFixed(2)}"
                          : "",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _resultMessage,
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
