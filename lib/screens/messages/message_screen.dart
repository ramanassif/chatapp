import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chatapp/models/chats.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController controller = TextEditingController();
  List<String> messages = [];
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

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
            child: StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) => ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BubbleSpecialThree(
                                text: messages[index],
                                color: Colors.teal,
                                tail: true,
                                isSender: false,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BubbleSpecialThree(
                                text: snapshot.hasData
                                    ? '${snapshot.data.toString().contains("echo.") ? "" : snapshot.data}'
                                    : '',
                                color: Colors.teal,
                                tail: true,
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
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'Send a message...'),
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
    messages.add(controller.text.toString());
    controller.clear();
  }
}
