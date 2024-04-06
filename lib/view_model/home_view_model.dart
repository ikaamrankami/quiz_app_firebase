// view_models/home_view_model.dart
import 'package:get/get.dart';

import '../model/quiz_model_home.dart';

class HomeViewModel extends GetxController {
  final List<QuizModel> completedQuizzes = <QuizModel>[].obs;

  void addCompletedQuiz(String title, int score) {
    completedQuizzes.add(QuizModel(title, score));
    update();
  }

  void clearQuizzes() {
    completedQuizzes.clear();
    update();
  }
}
