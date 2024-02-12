import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_photex/components/build_markdown.dart';
import 'package:gemini_photex/components/chat_input_box.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  final List<Content> chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Gemini"),
        ),
        body: Column(
          children: [
            Expanded(
              child: chats.isNotEmpty
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: ListView.builder(
                          itemBuilder: chatItem,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: chats.length,
                          reverse: false,
                        ),
                      ),
                    )
                  : const Center(child: Text('Search something!')),
            ),
            if (loading) const CircularProgressIndicator(),
            ChatInputBox(
              controller: controller,
              onSend: () {
                if (controller.text.isNotEmpty) {
                  final searchedText = controller.text;
                  chats.add(Content(
                      role: 'user', parts: [Parts(text: searchedText)]));
                  controller.clear();
                  loading = true;

                  gemini.streamChat(chats).listen((value) {
                    loading = false;
                    setState(() {
                      if (chats.isNotEmpty &&
                          chats.last.role == value.content?.role) {
                        chats.last.parts!.last.text =
                            '${chats.last.parts!.last.text}${value.output}';
                      } else {
                        chats.add(Content(
                            role: 'model', parts: [Parts(text: value.output)]));
                      }
                    });
                  });
                }
              },
            )
          ],
        ));
  }

  Widget chatItem(BuildContext context, int index) {
    final Content content = chats[index];
    return Card(
      elevation: 0,
      color: content.role == 'model' ? Colors.grey.shade800 : Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(content.role ?? 'role'),
          BuildMarkdown(data: content.parts?.lastOrNull?.text),
        ]),
      ),
    );
  }
}


