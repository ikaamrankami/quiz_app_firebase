// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addQuestion(
      String question, List<String> choices, int correctAnswerIndex) async {
    try {
      await _firestore.collection('quiz').add({
        'question': question,
        'choices': choices,
        'correctAnswerIndex': correctAnswerIndex,
      });
    } catch (e) {
      print('Error adding question: $e');
    }
  }
}
