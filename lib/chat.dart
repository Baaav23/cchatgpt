// ignore_for_file: avoid_print, duplicate_ignore

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

  // ignore: constant_identifier_names
  static const ApiKey = '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';

  void sendMessage(message) async {
    final res = await sendRequest(message);
    if (res.statusCode == 200) {
      final doin =
          json.decode(await res.transform(utf8.decoder).join())['choices'];
      for (var cor in doin) {
        print(cor['text']);
        _message.insert(0, Message(text: cor['text'], recive: "OpenAI"));
      }
      setState(() {});
    } else {
      print("Error!!!!!!!!!!");
    }
  }

  // ignore: non_constant_identifier_names, duplicate_ignore
  void send(String Text) {
    // ignore: prefer_interpolation_to_compose_strings, avoid_print
    print(Text + "Controller");

    Message message = Message(
      text: Text,
      recive: 'You',
    );

    setState(() {
      _message.insert(0, message);
    });
    _cont.clear();
    sendMessage(Text);
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
              child: _buildTextComposer(
                textController: _cont,
                isComposing: true,
                handleSubmitted: (x) {
                  setState(() {
                    send(x!);
                  });
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer({
    required TextEditingController textController,
    required bool isComposing,
    required Function? Function(String? x) handleSubmitted,
  }) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onChanged: (text) {
                  setState(() {
                    isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Ask me!'),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.blue,
              ),
              onPressed: isComposing
                  ? () => handleSubmitted(textController.text)
                  : null,
            ),
          ],
        ));
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
