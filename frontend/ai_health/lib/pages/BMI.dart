import 'package:ai_health/commons/constant.dart';
import 'package:flutter/material.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmi;
  String _resultMessage = "";

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height != null && weight != null && height > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
        if (_bmi! < 18.5) {
          _resultMessage = "Underweight";
        } else if (_bmi! < 24.9) {
          _resultMessage = "Normal weight";
        } else if (_bmi! < 29.9) {
          _resultMessage = "Overweight";
        } else {
          _resultMessage = "Obesity";
        }
      });
    } else {
      setState(() {
        _resultMessage = "Please enter valid values!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator")),
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
