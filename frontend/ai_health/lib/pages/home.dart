import 'package:ai_health/commons/constant.dart';
import 'package:ai_health/services/authservices.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI HEALTH',
          style: TextStyle(
            color: AppColors.WhiteLogo,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFF9F7E4)),
        backgroundColor: AppColors.BgLogo,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),

        child: Column(
          children: [
            Container(
              height: 250,
              margin: EdgeInsets.all(16),
              child: StatefulBuilder(
                builder: (context, setState) {
                  PageController _pageController = PageController();
                  int _currentPage = 0;

                  void _autoSlide() {
                    Future.delayed(Duration(seconds: 3), () {
                      if (_pageController.hasClients) {
                        _currentPage = (_currentPage + 1) % 3;
                        _pageController.animateToPage(
                          _currentPage,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInToLinear,
                        );
                        _autoSlide();
                      }
                    });
                  }

                  _autoSlide();

                  return PageView(
                    controller: _pageController,
                    children: [
                      Image.asset(
                        'lib/assets/images/png1.png',
                        fit: BoxFit.fitHeight,
                      ),
                      Image.asset(
                        'lib/assets/images/png2.png',
                        fit: BoxFit.fitHeight,
                      ),
                      Image.asset(
                        'lib/assets/images/png3.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  );
                },
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: AppColors.BgLogo,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildCardWithIcon('Consult', Icons.add_moderator, () {
                          context.push('/Consult');
                        }),
                        buildCardWithIcon('BMI', Icons.balance, () {
                          context.push('/BMI');
                        }),
                        buildCardWithIcon('Card 6', Icons.settings, () {
                          print('Card 6 clicked');
                        }),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildCardWithIcon('Card 4', Icons.favorite, () {
                          print('Card 4 clicked');
                        }),
                        buildCardWithIcon('Card 5', Icons.star, () {
                          print('Card 5 clicked');
                        }),
                        buildCardWithIcon('Card 6', Icons.settings, () {
                          print('Card 6 clicked');
                        }),
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
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   'AI Health',
                  //   style: TextStyle(
                  //     color: AppColors.WhiteLogo,
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
            DrawerItem(
              title: 'Profile',
              icon: Icons.people,
              onTap: () {
                print('Profile clicked');
              },
            ),
            DrawerItem(
              title: 'Contact',
              icon: Icons.settings,
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
