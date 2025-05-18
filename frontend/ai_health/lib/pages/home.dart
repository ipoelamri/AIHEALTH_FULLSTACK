import 'package:ai_health/commons/constant.dart';
import 'package:ai_health/services/authservices.dart';
import 'package:ai_health/services/profileservice.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String? _username;

  final List<String> _sliderImages = [
    'lib/assets/images/png1.png',
    'lib/assets/images/png2.png',
    'lib/assets/images/png3.png',
  ];

  @override
  void initState() {
    super.initState();
    _autoSlide();
    _initializeUsername();
  }

  void _initializeUsername() async {
    _username = await _getUsername();
    setState(() {}); // Perbarui UI setelah data diambil
  }

  void _autoSlide() {
    Future.delayed(Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % _sliderImages.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        _autoSlide();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  // Fungsi untuk mengambil nama user dari API
  Future<String> _getUsername() async {
    if (_username != null) {
      return _username!;
    }

    final profileService = ProfileService();
    final token = await _getToken();
    if (token.isEmpty) return 'User';

    final response = await profileService.fetchUserProfile(token);
    if (response.containsKey('error') && response['error']) {
      return 'User';
    }

    _username = response['name'] ?? 'User'; // Simpan hasil ke variabel lokal
    return _username!;
  }

  // Widget card dengan ikon
  Widget buildCardWithIcon(
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 110,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.WhiteLogo,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.18),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 44, color: AppColors.BgLogo),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.BgLogo,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Column(
      children: [
        Container(
          height: 220,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: PageView.builder(
              controller: _pageController,
              itemCount: _sliderImages.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder:
                  (context, i) =>
                      Image.asset(_sliderImages[i], fit: BoxFit.fill),
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _sliderImages.length,
            (i) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == i ? 22 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == i ? AppColors.BgLogo : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'AI HEALTH',
          style: TextStyle(
            color: AppColors.WhiteLogo,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF9F7E4)),
        backgroundColor: AppColors.BgLogo.withOpacity(0.95),
        centerTitle: true,
        elevation: 6,
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.WhiteLogo),
        child: Column(
          children: [
            SizedBox(height: 80),
            _buildSlider(),
            Padding(
              padding: const EdgeInsets.only(left: 22.0, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FutureBuilder<String>(
                  future: Future.value(
                    _username ?? _getUsername(),
                  ), // Gunakan data lokal jika ada
                  builder: (context, snapshot) {
                    String greeting = 'Halo, ${_username ?? 'User'}';
                    // if (snapshot.connectionState == ConnectionState.done &&
                    //     snapshot.hasData) {
                    //   greeting = 'Halo, ${_username ?? 'User'}';
                    // }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedOpacity(
                          opacity: 1.0,
                          duration: Duration(milliseconds: 500),
                          child: Text(
                            greeting,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BgLogo,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Selamat datang di aplikasi kesehatan Anda!',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: AppColors.BgLogo,
                ),
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildCardWithIcon('Consult', Icons.add_moderator, () {
                          context.push('/Consult');
                        }, color: Colors.orange[50]),
                        buildCardWithIcon('BMI', Icons.balance, () {
                          context.push('/BMI');
                        }, color: Colors.green[50]),
                        buildCardWithIcon(
                          'Mental Health',
                          Icons.add_reaction,
                          () {
                            context.push('/Mental-Health');
                          },
                          color: Colors.purple[50],
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildCardWithIcon(
                          'Virtual Therapist',
                          Icons.psychology_alt,
                          () {
                            context.push('/Virtual-Therapist');
                          },
                          color: Colors.blue[50],
                        ),
                        buildCardWithIcon('Profile', Icons.account_circle, () {
                          context.push('/Profile');
                        }, color: Colors.teal[50]),
                        buildCardWithIcon('Settings', Icons.settings, () {
                          print('Settings clicked');
                        }, color: Colors.red[50]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.BgLogo),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/logo.png',
                    width: 100,
                    height: 95,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Halo, ${_username ?? 'User'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            DrawerItem(
              title: 'Profile',
              icon: Icons.people,
              onTap: () {
                context.push('/Profile');
              },
            ),
            DrawerItem(
              title: 'Contact',
              icon: Icons.contact_mail,
              onTap: () {
                context.push('/Contact');
              },
            ),
            DrawerItem(
              title: 'About',
              icon: Icons.info,
              onTap: () {
                context.pushNamed('About');
              },
            ),
            DrawerItem(
              title: 'Logout',
              icon: Icons.logout,
              onTap: () async {
                final authService = AuthService();
                try {
                  await authService.logout();
                  context.go('/Login');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout gagal: ${e.toString()}')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// DrawerItem widget tetap seperti sebelumnya
class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.BgLogo),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      onTap: onTap,
    );
  }
}
