import 'package:chatapp/components/chat_bubble.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserEmail;
  final String recieverUserUid;
  const ChatPage({
    super.key,
    required this.recieverUserEmail,
    required this.recieverUserUid
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final _firebaseAuth = FirebaseAuth.instance;

  ScrollController listScrollController = ScrollController();

  void scrollIntoView() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;
      listScrollController.jumpTo(position);
    }
  }

  void sendMessage() async {
    // only send a message if there is something to send
    if(_messageController.text.isNotEmpty){
        await _chatService.sendMessage(
          widget.recieverUserUid,
          _messageController.text
        );
      _messageController.clear();
    }
    scrollIntoView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          _buildMessageInput(),

          SizedBox(height: 10,),
        ],
      )
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          // textfield
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),

          // send button
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessages(widget.recieverUserUid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {



        if(snapshot.hasError){
          return Text("Error ${snapshot.error}");
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }

        return ListView(
          // scrollDirection: Axis.vertical,
          controller: listScrollController,
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // align the message to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
                data['senderEmail'],
                style: const TextStyle(
                  fontSize: 10,
                  // fontWeight: FontWeight.w500,
                ),
            ),
            const SizedBox(height: 5,),
            ChatBubble(message: data['message']),
          ],
        ),
      )
    );
  }

}
