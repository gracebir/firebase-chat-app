import 'package:firebase_chat_app/components/user_tile.dart';
import 'package:firebase_chat_app/pages/chat_page.dart';
import 'package:firebase_chat_app/services/auth/auth_service.dart';
import 'package:firebase_chat_app/components/my_drawer.dart';
import 'package:firebase_chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ChatService _chatService = ChatService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("home"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
      ),
      drawer: const MyDrawer(),
      body: _buidUserList(),
    );
  }

  Widget _buidUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }
}

Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  final AuthService authService = AuthService();
  if (userData["email"] != authService.getCurrentUse()!.email) {
    return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiveEmail: userData['email'],
                        receiverID: userData['uid'],
                      )));
        });
  } else {
    return Container();
  }
}
