import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chats_class_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var chat = Provider.of<AllChats>(context);
    return SizedBox(
      height: screenSize.height * 0.85,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: chat.chats.length,
                itemBuilder: (context, index) {
                  if (chat.chats[index].type == "user") {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: screenSize.width * 0.7,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(66, 189, 143, 143),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            chat.chats[index].msg,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: screenSize.width * 0.7,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(66, 201, 160, 160),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            chat.chats[index].msg,
                            style: const TextStyle(fontSize: 30),
                            softWrap: true,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(66, 189, 143, 143),
            child: TextField(
              onSubmitted: (value) {
                context.read<AllChats>().addChat(
                    Chat(msg: value, type: "no", userName: "Joyhn Doe"));
              },
              decoration: const InputDecoration(
                  hintText: "Type message",
                  suffixIcon: Icon(Icons.send),
                  label: Text("Type message"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
        ],
      ),
    );
  }
}
//  ListView.builder(
//               itemCount: 2,
//               itemBuilder: (context, index) {
//                 return Container();
//               },
//             ),
