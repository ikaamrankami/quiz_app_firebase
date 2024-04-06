import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizController extends GetxController {
  final currentQuestionIndex = 0.obs;
  final questions = <Map<String, dynamic>>[].obs;
  final score = 0.obs;
  final selectedAnswerIndex = (-1).obs;
  final answered = false.obs;

  Rx<Map<String, dynamic>> currentQuestion = Rx<Map<String, dynamic>>({});

  @override
  void onInit() {
    fetchQuestions();
    super.onInit();
  }

  void fetchQuestions() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('quiz').get();

    questions.assignAll(querySnapshot.docs.map((doc) => doc.data()).toList());

    updateCurrentQuestion();
  }

  void updateCurrentQuestion() {
    if (questions.isNotEmpty && currentQuestionIndex.value < questions.length) {
      currentQuestion.value = questions[currentQuestionIndex.value];
    } else {
      currentQuestion.value = {};
    }
  }

  void answerQuestion(int selectedIndex) {
    if (!answered.value) {
      selectedAnswerIndex.value = selectedIndex;
      answered.value = true;
      if (isCorrectAnswer(selectedIndex)) {
        score.value += 10;
      }
    }
  }

  bool isCorrectAnswer(int selectedIndex) {
    return selectedIndex == currentQuestion.value['correctAnswerIndex'];
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      updateCurrentQuestion();
      answered.value = false;
      selectedAnswerIndex.value = -1;
    } else {
      finishQuiz();
    }
  }

  bool get isLastQuestion => currentQuestionIndex.value == questions.length - 1;

  void finishQuiz() {
    // Reset values for a new quiz or any other logic
    currentQuestionIndex.value = 0;
    updateCurrentQuestion();
    selectedAnswerIndex.value = -1;
    answered.value = false;
  }

  void startQuiz() {
    // Start the quiz by showing the first question
    currentQuestionIndex.value = 0;
    updateCurrentQuestion();
    score.value = 0;
    answered.value = false;
  }
}
