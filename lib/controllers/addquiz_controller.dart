import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuestionController extends GetxController {
  late final TextEditingController questionController;
  late final List<TextEditingController> choiceControllers;
  RxInt selectedAnswerIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    questionController = TextEditingController();
    choiceControllers = List.generate(4, (_) => TextEditingController());
  }

  @override
  void onClose() {
    questionController.dispose();
    for (var controller in choiceControllers) {
      controller.dispose();
    }
    super.onClose();
  }

  void selectAnswer(int index) {
    selectedAnswerIndex.value = index;
  }

  void clearFields() {
    questionController.clear();
    for (var controller in choiceControllers) {
      controller.clear();
    }
    selectedAnswerIndex.value = -1;
  }
}
