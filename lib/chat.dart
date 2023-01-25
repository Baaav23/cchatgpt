import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String text;
  final String recive;

  const Message({super.key, required this.text, required this.recive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  child: Text(recive[0]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
