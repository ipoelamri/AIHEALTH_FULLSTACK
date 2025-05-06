import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Color whatsappColor = Color(0xff122d4f);
  Color instagramColor = Color(0xff122d4f);
  Color gmailColor = Color(0xff122d4f);
  Color githubColor = Color(0xff122d4f);

  Future<void> LauncherURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka URL: ${uri.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Media Social',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff122D4F),
          ),
        ),
        backgroundColor: const Color(0xFFF9F7E4),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: IconThemeData(color: Color(0xff122D4F)),
      ),
      body: Container(
        color: Color(0xff122D4F),
        padding: EdgeInsets.fromLTRB(0, screenHeight * 0.04, 0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'SOSIAL MEDIA DAN CONTACT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    color: Color(0xFFF9F7E4),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05,
                    screenHeight * 0.06,
                    screenWidth * 0.05,
                    screenHeight * 0.05,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9F7E4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Hubungi Saya',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                          color: Color(0xff122d4f),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            whatsappColor = Color(
                              0xff0f1c2b,
                            ); // Warna saat ditekan
                          });
                          LauncherURL(
                            Uri.parse(
                              'https://api.whatsapp.com/send/?phone=6288224664299&text&type=phone_number&app_absent=0',
                            ),
                          );
                          Future.delayed(Duration(milliseconds: 200), () {
                            setState(() {
                              whatsappColor = Color(0xff122d4f); // Warna normal
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: whatsappColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/logo.png',
                                width: screenWidth * 0.08,
                                height: screenHeight * 0.08,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'WHATSAPP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03,
                                  color: Color(0xffF9F7E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            instagramColor = Color(
                              0xff0f1c2b,
                            ); // Warna saat ditekan
                          });
                          LauncherURL(
                            Uri.parse('https://instagram.com/ipoel_amri12'),
                          );
                          Future.delayed(Duration(milliseconds: 200), () {
                            setState(() {
                              instagramColor = Color(
                                0xff122d4f,
                              ); // Warna normal
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: instagramColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/logo.png',
                                width: screenWidth * 0.08,
                                height: screenHeight * 0.08,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'INSTAGRAM',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03,
                                  color: Color(0xffF9F7E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            gmailColor = Color(
                              0xff0f1c2b,
                            ); // Warna saat ditekan
                          });
                          LauncherURL(
                            Uri.parse('mailto:ipeolamri94@gmail.com'),
                          );
                          Future.delayed(Duration(milliseconds: 200), () {
                            setState(() {
                              gmailColor = Color(0xff122d4f); // Warna normal
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: gmailColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/logo.png',
                                width: screenWidth * 0.08,
                                height: screenHeight * 0.08,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'GMAIL',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03,
                                  color: Color(0xffF9F7E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            githubColor = Color(
                              0xff0f1c2b,
                            ); // Warna saat ditekan
                          });
                          LauncherURL(
                            Uri.parse('https://github.com/ipoelamri'),
                          );
                          Future.delayed(Duration(milliseconds: 200), () {
                            setState(() {
                              githubColor = Color(0xff122d4f); // Warna normal
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.01,
                            horizontal: screenWidth * 0.05,
                          ),
                          decoration: BoxDecoration(
                            color: githubColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'lib/assets/images/logo.png',
                                width: screenWidth * 0.08,
                                height: screenHeight * 0.08,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                'GITHUB',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.03,
                                  color: Color(0xffF9F7E4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
