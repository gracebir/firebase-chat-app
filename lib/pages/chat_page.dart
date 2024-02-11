import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/components/chat_bubble.dart';
import 'package:firebase_chat_app/components/my_textfield.dart';
import 'package:firebase_chat_app/services/auth/auth_service.dart';
import 'package:firebase_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiveEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiveEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageTextController = TextEditingController();

  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();

  void sendMessage() async {
    if (messageTextController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, messageTextController.text);
      messageTextController.clear();
    }
    scrollDown();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(microseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(microseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageTextController.dispose();
    super.dispose();
  }

  final ScrollController scrollController = ScrollController();

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiveEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUse()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map<Widget>((doc) => _builderMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _builderMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUse()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
            alignment: alignment,
            child: ChatBubble(
                message: data["message"], isCurrentUser: isCurrentUser)),
      ],
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  focusNode: myFocusNode,
                  hintText: "tap a message...",
                  obscureText: false,
                  controller: messageTextController)),
          Container(
              decoration: const BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
