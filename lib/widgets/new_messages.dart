import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _messageController = TextEditingController(); 

  //add a dispose function when dealing with controllers
 @override
  void dispose(){
    _messageController.dispose();
    super.dispose();
  

 } 
 
  void _submitChat() async {
  // Get the text entered in the message input field
  final enteredMessage = _messageController.text;

  // If the entered message is empty or only contains spaces, do nothing
  if (enteredMessage.trim().isEmpty) {
    return;
  }

  // Hide the keyboard and clear the message input field
  FocusScope.of(context).unfocus();
  _messageController.clear();

  // Get the current authenticated user
  final user = FirebaseAuth.instance.currentUser!;

  // Retrieve user data from Firestore using the user's UID
  final userData = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get();

  // Add a new document to the 'chat' collection in Firestore
  FirebaseFirestore.instance.collection('chat').add({
    // Store the entered message text
    'text': enteredMessage,
    // Store the timestamp when the message was submitted
    'createdAt': Timestamp.now(),
    // Store the user's UID
    'userId': user.uid,
    // Retrieve the username from the user data
    'username': userData.data()?['username'],
    // Retrieve the user's profile image URL from the user data
    'userImage': userData.data()?['image_url'],
  });
}


  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.only(
      left:15, right: 2, bottom:13,
    ),
    child: Row(
      children: [
       Expanded(
        child: TextField(
          controller: _messageController,
          textCapitalization: TextCapitalization.sentences,
          autocorrect: true,
          enableSuggestions: true,
          decoration: const InputDecoration(labelText: "Send A Message...."),
        ),
        ),
        IconButton( color: Theme.of(context).colorScheme.primary,
          // ignore: prefer_const_constructors
          onPressed: _submitChat, icon: Icon(Icons.send_outlined),)
        ],),);
  }
}