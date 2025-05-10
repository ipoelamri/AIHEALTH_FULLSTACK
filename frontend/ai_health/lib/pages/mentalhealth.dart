import 'package:flutter/material.dart';
import 'package:ai_health/services/mentalHealthService.dart';

class MentalHealthCheckPage extends StatefulWidget {
  @override
  _MentalHealthCheckPageState createState() => _MentalHealthCheckPageState();
}

class _MentalHealthCheckPageState extends State<MentalHealthCheckPage> {
  final Mentalhealthservice _service = Mentalhealthservice();
  final List<String> _questions = [
    "Apakah Anda merasa sulit tidur akhir-akhir ini?",
    "Apakah Anda sering merasa lelah tanpa sebab yang jelas?",
    "Apakah Anda merasa cemas atau gelisah secara berlebihan?",
    "Apakah Anda kehilangan minat dalam aktivitas yang biasa Anda nikmati?",
    "Apakah Anda merasa kesulitan untuk berkonsentrasi?",
  ];

  List<String> _answers = List.filled(5, "tidak");
  String _mood = "";
  String _message = "";
  bool _isLoading = false;

  void _checkMentalHealth() async {
    setState(() {
      _isLoading = true;
    });

    final result = await _service.getAnswer(_answers);

    setState(() {
      _isLoading = false;
      if (result['success']) {
        _mood = result['mood'];
        _message = result['message'];
      } else {
        _mood = "Error";
        _message = result['message'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Health Check"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _questions[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  title: Text("Iya"),
                                  value: "iya",
                                  groupValue: _answers[index],
                                  onChanged: (value) {
                                    setState(() {
                                      _answers[index] = value!;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  title: Text("Tidak"),
                                  value: "tidak",
                                  groupValue: _answers[index],
                                  onChanged: (value) {
                                    setState(() {
                                      _answers[index] = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: _checkMentalHealth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    child: Text("Check Mental Health"),
                  ),
                ),
            SizedBox(height: 16),
            if (_mood.isNotEmpty)
              Card(
                color:
                    _mood == "Baik"
                        ? Colors.green[100]
                        : _mood == "Cemas Ringan"
                        ? Colors.yellow[100]
                        : Colors.red[100],
                elevation: 2,
                margin: EdgeInsets.only(top: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Mood: $_mood",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _message,
                        style: TextStyle(fontSize: 16),
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
