import 'package:chat_app_v3/screen/call_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController callIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video call'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: callIdController,
                decoration: const InputDecoration(
                  hintText: "Nhập ID cuộc gọi",
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(
                  hintText: "Nhập ID người dùng",
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                controller: userNameController,
                decoration: const InputDecoration(
                  hintText: "Tên hiển thị",
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CallPage(
                                callID: callIdController.text,
                                userID: userIdController.text,
                                username: userNameController.text,
                              )));
                },
                child: const Text("Tham gia cuộc gọi"))
          ],
        ),
      ),
    );
  }
}
