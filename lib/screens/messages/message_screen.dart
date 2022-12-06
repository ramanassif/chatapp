import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp/models/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController controller = TextEditingController();
  List<Message> messages = [];
  ScrollController scrollController = ScrollController();

  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _channel.stream.listen((event) {
        _receiveMessage(event);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Chat indexChat = chatsData[widget.index];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          indexChat.name,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: messages[index].isReceived
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              BubbleSpecialThree(
                                text: messages[index].message,
                                color: Colors.teal,
                                tail: true,
                                isSender: messages[index].isReceived,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      )),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade300,
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Send a message...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (controller.text.isNotEmpty) {
      _channel.sink.add(controller.text);
    }
    messages
        .add(Message(message: controller.text.toString(), isReceived: false));
    controller.clear();
    scrollController.animateTo(
        scrollController.position.maxScrollExtent + kToolbarHeight,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
    setState(() {});
  }

  void _receiveMessage(String message) {
    messages.add(Message(message: message.toString(), isReceived: true));
    scrollController.animateTo(
        scrollController.position.maxScrollExtent + kToolbarHeight,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
    setState(() {});
  }
}

class Message {
  final String message;
  final bool isReceived;

  Message({required this.message, required this.isReceived});
}
