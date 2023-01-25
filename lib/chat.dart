import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _Chat();
}

class _Chat extends State<Chat> {
  Future<HttpClientResponse> sendRequest(String prompt) async {
    final hclint = HttpClient();
    final hreq = await hclint
        .postUrl(Uri.parse('https://api.openai.com/v1/completions'));
    hreq.headers.set('Content-Type', 'application/json');
    hreq.headers.set('Authorization', 'Bearer $ApiKey');
    hreq.add(utf8.encode(json.encode({
      'model': 'text-davinci-003',
      'prompt': prompt,
      'max_tokens': 2000,
      'stop': '',
      'temperature': 0.7,
    })));
    final res = await hreq.close();
    return res;
  }

  static const ApiKey = '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';

  void send(String Text) {
    print(Text + "Controller");

    Message message = Message(
      text: Text,
      recive: 'You',
    );
  }

  final TextEditingController _cont = TextEditingController();
  final List<Message> _message = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bot"),
          leading: Image.asset("lib/image/ChatGPT_Icon.png"),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (_, index) {
                  return _message[index];
                },
                itemCount: _message.length,
              ),
            ),
            const Divider(height: 1.0, color: Colors.blue, thickness: 3),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  recive,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Center(
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
