import 'package:ai_health/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:ai_health/services/virtualTherapistService.dart';

class VirtualTherapistPage extends StatefulWidget {
  @override
  _VirtualTherapistPageState createState() => _VirtualTherapistPageState();
}

class _VirtualTherapistPageState extends State<VirtualTherapistPage> {
  final VirtualTherapistService _service = VirtualTherapistService();
  final List<String> _conditions = ['Baik', 'Cemas Ringan', 'Stres', 'Depresi'];

  String? _selectedCondition;
  String _response = '';
  bool _isLoading = false;

  void _getSuggestion() async {
    if (_selectedCondition == null) return;

    setState(() {
      _isLoading = true;
      _response = '';
    });

    final result = await _service.getSuggestion(_selectedCondition!);

    setState(() {
      _isLoading = false;
      _response = result['jawaban'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Virtual Therapist',
          style: TextStyle(color: AppColors.BgLogo),
        ),
        iconTheme: IconThemeData(color: AppColors.BgLogo),
      ),
      body: Container(
        color: Color(0xFF00477b), // Warna solid tanpa gradasi
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Pilih Kondisi Mental Anda:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: _selectedCondition,
                items:
                    _conditions.map((String condition) {
                      return DropdownMenuItem<String>(
                        value: condition,
                        child: Text(condition),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCondition = value;
                  });
                },
              ),
              SizedBox(height: 25),
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF00477b),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _getSuggestion,
                    child: Center(
                      child: Text(
                        'Dapatkan Saran',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
              SizedBox(height: 25),
              if (_response.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      color: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _response,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF00477b),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
