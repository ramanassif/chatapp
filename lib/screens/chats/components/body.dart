import 'package:chatapp/models/chats.dart';
import 'package:chatapp/screens/chats/components/chat_card.dart';
import 'package:chatapp/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesScreen(index: index),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
