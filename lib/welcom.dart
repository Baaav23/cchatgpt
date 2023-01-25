import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " Welcome !",
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("lib/image/imgBot.jpg"),
            ),
          ),
          Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              const Text("Can I Help You ?"),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Hello !"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
