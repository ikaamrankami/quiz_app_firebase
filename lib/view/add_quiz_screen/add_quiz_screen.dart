// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/addquiz_controller.dart';
import '../../core/app_services/firestore_s_addQuiz.dart';
import '../../core/const/app_colors.dart';

class AddQuestionScreen extends StatelessWidget {
  final AddQuestionController _controller = Get.put(AddQuestionController());
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  AddQuestionScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          foregroundColor: Colors.white,
          title: Text(
            'Add New Question',
            style: GoogleFonts.acme(fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller.questionController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    labelStyle: GoogleFonts.acme(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Choices:',
                  style: GoogleFonts.acme(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildChoiceFields(),
                const SizedBox(height: 20),
                Text(
                  'Select Correct Answer:',
                  style: GoogleFonts.acme(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildAnswerButtons(),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appBarColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _addQuestionToFirestore,
                  child: Text(
                    'Add Question',
                    style: GoogleFonts.acme(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceFields() {
    return Column(
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _controller.choiceControllers[index],
            decoration: InputDecoration(
              labelText: 'Choice ${index + 1}',
              labelStyle: GoogleFonts.acme(),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAnswerButtons() {
    return Row(
      children: List.generate(4, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            onPressed: () => _controller.selectAnswer(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: _controller.selectedAnswerIndex.value == index
                  ? Colors.blue
                  : AppColors.appBarColor,
            ),
            child: Text(
              (index + 1).toString(),
              style: GoogleFonts.acme(color: Colors.white, fontSize: 17),
            ),
          ),
        );
      }),
    );
  }

  void _addQuestionToFirestore() {
    String question = _controller.questionController.text.trim();
    List<String> choices = _controller.choiceControllers
        .map((controller) => controller.text.trim())
        .toList();
    int correctAnswerIndex = _controller.selectedAnswerIndex.value;

    if (question.isEmpty || choices.contains('')) {
      Get.snackbar(
          backgroundColor: Colors.blueGrey,
          duration: const Duration(seconds: 2),
          colorText: Colors.white,
          'Error',
          'Please fill all fields');
      return;
    }

    if (correctAnswerIndex == -1) {
      Get.snackbar(
          backgroundColor: Colors.blueGrey,
          duration: const Duration(seconds: 2),
          colorText: Colors.white,
          'Error',
          'Please select a correct answer');
      return;
    }

    _firestoreService.addQuestion(question, choices, correctAnswerIndex);
    _controller.clearFields();
    Get.snackbar(
        backgroundColor: Colors.blueGrey,
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
        'Success',
        'Question added successfully');
  }
}
