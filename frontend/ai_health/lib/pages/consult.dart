import 'package:ai_health/commons/constant.dart';
import 'package:ai_health/services/GPTservice.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    final String userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "content": userMessage});
      _messageController.clear();
      _isLoading = true;
    });

    try {
      final String aiResponse = await GPTService.getResponse(userMessage);
      setState(() {
        _messages.add({"role": "ai", "content": aiResponse});
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "ai",
          "content": "Error: Unable to fetch response.",
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Consult")),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.BgLogo,
          image: DecorationImage(
            image: AssetImage('lib/assets/images/logo.png'),
            fit: BoxFit.contain,
            opacity: 0.1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUser = message["role"] == "user";
                  return Container(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child:
                        isUser
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      message["content"]!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'lib/assets/images/logo.png',
                                  ), // Ganti dengan path gambar pengguna Anda
                                  radius: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white, // Outline white
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'lib/assets/images/Doctor.jpg',
                                  ), // Ganti dengan path gambar AI Anda
                                  radius: 20,
                                ),
                                SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      message["content"]!,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  );
                },
              ),
            ),
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: AppColors.WhiteLogo),
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        hintStyle: TextStyle(color: AppColors.WhiteLogo),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.WhiteLogo),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: AppColors.WhiteLogo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: AppColors.WhiteLogo,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _sendMessage,
                    child: Text("Send"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
