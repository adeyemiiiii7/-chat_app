import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.only(
      left:15, right: 2, bottom:13,
    ),
    child: Row(
      children: [
      const Expanded(
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          autocorrect: true,
          enableSuggestions: true,
          decoration: InputDecoration(labelText: "Send A Message...."),
        ),
        ),
        IconButton( color: Theme.of(context).colorScheme.primary,
          // ignore: prefer_const_constructors
          onPressed: () {}, icon: Icon(Icons.send_outlined),)
        ],),);
  }
}