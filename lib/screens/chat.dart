import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DevsChat',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Logout'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Column(children: [
        Expanded(child: 
        ChatMessages(),
        ),
        NewMessage()
      ]),
    );
  }
}
