import 'package:flutter/material.dart';

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
              const SizedBox(
                width: 350,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Enter the topic of your video",
                    // centered
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Generate"),
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
}
