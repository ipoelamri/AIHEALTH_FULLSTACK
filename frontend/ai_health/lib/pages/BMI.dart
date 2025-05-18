import 'package:ai_health/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:ai_health/services/BMIService.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final BMIService _bmiService = BMIService();

  double? _bmi;
  String _resultMessage = "";
  double? _height;
  double? _weight;

  void _calculateBMI() async {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      setState(() {
        _height = height;
        _weight = weight;
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
      await _saveToDatabase(_resultMessage);
    } else {
      setState(() {
        _resultMessage = "Please enter valid values!";
      });
    }
  }

  Future<void> _saveToDatabase(String resultMessage) async {
    if (_height != null && _weight != null && _bmi != null) {
      await _bmiService.saveBMI(
        height: _height!,
        weight: _weight!,
        totalBMI: _bmi!,
        resultMessage: resultMessage,
      );
    } else {
      print("Data tidak valid");
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
            SizedBox(height: 30),
            Center(
              child: Image.asset(
                'lib/assets/images/logo.png',
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Masukkan Data Anda",
                    style: TextStyle(
                      color: AppColors.WhiteLogo,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.WhiteLogo),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      labelText: "Tinggi Badan (cm)",
                      labelStyle: TextStyle(color: AppColors.WhiteLogo),
                      prefixIcon: Icon(
                        Icons.height,
                        color: AppColors.WhiteLogo,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.WhiteLogo,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.WhiteLogo),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      labelText: "Berat Badan (kg)",
                      labelStyle: TextStyle(color: AppColors.WhiteLogo),
                      prefixIcon: Icon(
                        Icons.monitor_weight,
                        color: AppColors.WhiteLogo,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.WhiteLogo),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.WhiteLogo,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _calculateBMI,
                      icon: Icon(Icons.calculate),
                      label: Text("Hitung BMI"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.BgLogo,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hasil BMI',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.BgLogo,
                      ),
                    ),
                    SizedBox(height: 5),
                    if (_bmi != null)
                      Column(
                        children: [
                          Text(
                            "${_bmi!.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BgLogo,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _resultMessage,
                            style: TextStyle(
                              fontSize: 20,
                              color:
                                  _bmi! < 18.5
                                      ? Colors.orange
                                      : _bmi! < 24.9
                                      ? Colors.green
                                      : _bmi! < 29.9
                                      ? Colors.amber
                                      : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "Masukkan data untuk menghitung BMI Anda.",
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
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
