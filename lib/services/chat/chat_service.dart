import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/message.dart';

class ChatService extends ChangeNotifier {
//   get instance of the auth and the firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   SEND MESSAGE

  Future<void> sendMessage(String receiverId, String message) async {
  //   get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!.toString();
    final Timestamp timestamp = Timestamp.now();

  //   createa a new message

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

  //   construct chat room if from current user id and reciever id (sorted to ensure uniqueness)

    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort this so as to ensure that [john, mary] and [mary, john] are the same chat room
    String chatRoomId = ids.join('_');

  //   add new message to the database

      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
  }

// GET MESSAGE

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort(); // sort this so as to ensure that [john, mary] and [mary, john] are the same chat room
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}