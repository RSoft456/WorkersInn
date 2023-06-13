import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/variables.dart';

import 'chats_class_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.docId});
  final String docId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController mesage = TextEditingController();
    Size screenSize = MediaQuery.of(context).size;
    var chat = Provider.of<AllChats>(context);
    return Expanded(
      child: SizedBox(
        height: screenSize.height * 0.8,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("orders")
                        .doc(widget.docId)
                        .collection("chat")
                        .orderBy("TimeStamp")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: orange,
                          ),
                        );
                      }
                      //context.read<AllChats>().chats.clear();
                      var data = snapshot.data?.docs;
                      if (data!.isEmpty) {
                        return Container();
                      }
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var doc = data[index].data();
                          if (doc['type'] == "user") {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSize.width * 0.02),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: screenSize.width * 0.02,
                                        bottom: screenSize.width * 0.02,
                                        left: screenSize.width * 0.04,
                                        right: screenSize.width * 0.02),
                                    width: screenSize.width * 0.7,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(119, 252, 239, 165),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      doc['msg'],
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
                                  padding: EdgeInsets.only(
                                      top: screenSize.width * 0.02),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: screenSize.width * 0.02,
                                        bottom: screenSize.width * 0.02,
                                        left: screenSize.width * 0.04,
                                        right: screenSize.width * 0.02),
                                    width: screenSize.width * 0.7,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(119, 248, 239, 190),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    child: Text(
                                      doc['msg'],
                                      style: const TextStyle(fontSize: 20),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }),
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
                          FirebaseFirestore.instance
                              .collection("orders")
                              .doc(widget.docId)
                              .collection("chat")
                              .add({
                            'msg': mesage.text,
                            'type': context.read<AppMap>().isWorker
                                ? "worker"
                                : "user",
                            'userName': "Joyhn Doe",
                            'TimeStamp': DateTime.now(),
                          });
                          if (mesage.text != "") {
                            context.read<AllChats>().addChat(
                                  Chat(
                                      msg: mesage.text,
                                      type: context.read<AppMap>().isWorker
                                          ? "worker"
                                          : "user",
                                      userName: "Joyhn Doe"),
                                );
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
