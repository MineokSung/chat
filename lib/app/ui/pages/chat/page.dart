import 'package:chat/app/ui/widgets/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatInfo> chatList = [];
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      ChatInfo chatInfo = ChatInfo(name: 'test', chat: '${i}', isMe: i % 2 == 0 ? true : false);
      chatList.add(chatInfo);
    }
    chatList = List.from(chatList.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const Text('chatting'),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: chatList.length,
              reverse: true,
              itemBuilder: (BuildContext context, int index) {
                ChatInfo chatInfo = chatList[index];
                return Profile(
                  name: chatInfo.name,
                  message: chatInfo.chat,
                  isMe: chatInfo.isMe,
                );
              },
            ),
          ),
          Container(
            color: Colors.green,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (value) => addComment(value),
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
                Container(
                  color: Colors.deepPurpleAccent,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    //onTap: () => addComment(textEditingController.text),
                    onTap: () {
                      addComment(textEditingController.text);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('click'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addComment(String value) {
    ChatInfo chatInfo = ChatInfo(
      name: 'test',
      chat: value,
      isMe: true,
    );
    //chatList.add(chatInfo);
    chatList.insert(0, chatInfo);
    textEditingController.clear();

    setState(() {
      scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInToLinear);
    });

  }

  void scrollLast() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInToLinear);
  }
}

class ChatInfo {
  String name;
  String chat;
  bool isMe;

  ChatInfo({required this.name, required this.chat, required this.isMe});
}
