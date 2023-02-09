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
    TextEditingController mesage = TextEditingController();
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: screenSize.width * 0.7,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(119, 252, 239, 165),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)),
                            ),
                            child: Text(
                              chat.chats[index].msg,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: screenSize.width * 0.7,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(119, 252, 239, 165),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: Text(
                              chat.chats[index].msg,
                              style: const TextStyle(fontSize: 20),
                              softWrap: true,
                            ),
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
            // color: const Color.fromARGB(66, 189, 143, 143),
            child: TextField(
              controller: mesage,
              decoration: InputDecoration(
                  hintText: "Type message",
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (mesage.text != "") {
                          context.read<AllChats>().addChat(Chat(
                              msg: mesage.text,
                              type: "user",
                              userName: "Joyhn Doe"));
                        }
                      },
                      icon: const Icon(Icons.send)),
                  label: const Text("Type message"),
                  border: const OutlineInputBorder(
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
