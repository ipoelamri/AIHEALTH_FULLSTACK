// filepath: c:\laragon\www\AIHEALTH FULLSTACK\frontend\ai_health\lib\pages\ActivityTracker.dart
import 'package:flutter/material.dart';
import 'package:ai_health/commons/constant.dart';
import 'dart:convert'; // Untuk encode/decode JSON
import 'package:shared_preferences/shared_preferences.dart';

class ActivityTrackerPage extends StatefulWidget {
  @override
  _ActivityTrackerPageState createState() => _ActivityTrackerPageState();
}

class _ActivityTrackerPageState extends State<ActivityTrackerPage> {
  final List<Map<String, dynamic>> _activities = [];

  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadActivitiesFromStorage();
  }

  void _addActivity() {
    final String activity = _activityController.text;
    final String duration = _durationController.text;

    if (activity.isNotEmpty && duration.isNotEmpty) {
      setState(() {
        _activities.add({
          'activity': activity,
          'duration': int.tryParse(duration) ?? 0,
          'date': DateTime.now().toString(),
        });
      });

      _activityController.clear();
      _durationController.clear();

      // Simpan data ke local storage
      _saveActivitiesToStorage();
    }
  }

  void _deleteActivity(int index) {
    setState(() {
      _activities.removeAt(index);
    });

    // Simpan perubahan ke local storage
    _saveActivitiesToStorage();
  }

  // Fungsi untuk menyimpan data aktivitas ke SharedPreferences
  Future<void> _saveActivitiesToStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_activities);
    await prefs.setString('activities', encodedData);
  }

  // Fungsi untuk memuat data aktivitas dari SharedPreferences
  Future<void> _loadActivitiesFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('activities');

    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      setState(() {
        _activities.clear();
        _activities.addAll(
          decodedData.map((item) => Map<String, dynamic>.from(item)),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activity Tracker',
          style: TextStyle(color: AppColors.WhiteLogo),
        ),
        backgroundColor: AppColors.BgLogo,
        iconTheme: IconThemeData(color: AppColors.WhiteLogo),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah Aktivitas',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.BgLogo,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _activityController,
                decoration: InputDecoration(
                  labelText: 'Jenis Aktivitas',
                  labelStyle: TextStyle(color: AppColors.darkGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.BgLogo),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.BgLogo),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Durasi (menit)',
                  labelStyle: TextStyle(color: AppColors.darkGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.BgLogo),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.BgLogo),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _addActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.BgLogo,
                    foregroundColor: AppColors.WhiteLogo,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(Icons.add),
                  label: Text(
                    'Tambah Aktivitas',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'Riwayat Aktivitas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BgLogo,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _activities.isEmpty
                  ? Center(
                    child: Text(
                      'Belum ada aktivitas yang dicatat.',
                      style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
                    ),
                  )
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _activities.length,
                    itemBuilder: (context, index) {
                      final activity = _activities[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        color: AppColors.darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.BgLogo,
                            child: Icon(
                              Icons.ads_click,
                              color: AppColors.WhiteLogo,
                            ),
                          ),
                          title: Text(
                            activity['activity'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.WhiteLogo,
                            ),
                          ),
                          subtitle: Text(
                            'Durasi: ${activity['duration']} menit\nTanggal: ${activity['date'].toString().split(' ')[0]}',
                            style: TextStyle(color: AppColors.lightGrey),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteActivity(index),
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
