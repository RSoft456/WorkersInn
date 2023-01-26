import 'package:flutter/cupertino.dart';

class Chat {
  String userName;
  String type;
  String msg;
  Chat({required this.msg, required this.type, required this.userName});
}

class AllChats with ChangeNotifier {
  List<Chat> chats = [];
  addChat(Chat chat) {
    chats.add(chat);
    notifyListeners();
  }
}
