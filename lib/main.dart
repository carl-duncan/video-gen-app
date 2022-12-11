import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_gen/success_page.dart';

import 'app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'video-gen',
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: AppThemes.darkTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Dio dio = Dio();
  String url = "https://video-gen-dev-cdsoftwaresja.vercel.app/";
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fontSize = 40.0;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 100),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Generate a ",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Theme.of(context).textTheme.headline6!.color,
                      ),
                  children: [
                    TextSpan(
                      text: "video ",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF5271ff),
                            height: 1,
                          ),
                    ),
                    TextSpan(
                      text: "about",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6!.color,
                            height: 1,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Enter the topic of your video",
                    // centered
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        _isLoading = true;
                      });
                      generateVideo(
                        _controller.text,
                      );
                    }
                  },
                  child: _isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        )
                      : const Text("Generate"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: const Color(0xFF5271ff),
        child: const Center(
          child: Text(
            'Created by Carl Duncan for the 2022 AssemblyAI Hackathon. ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void generateVideo(String topic) async {
    try {
      print("Generating video...");
      final response = await dio.post(
        '${url}generate-video?query=$topic',
      );
      var statusId = response.data;
      print("Status ID: $statusId");

      while (true) {
        try {
          final statusResponse = await dio.get('${url}status/$statusId');
          if (statusResponse.data['status'] == 'done') {
            if (mounted) {
              Navigator.push<SuccessPage>(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessPage(
                    url: statusResponse.data['url'],
                  ),
                ),
              );
              setState(() {
                _isLoading = true;
              });
            }
            break;
          }
          await Future.delayed(const Duration(seconds: 5));
        } catch (e) {
          print("Error: $e");
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
