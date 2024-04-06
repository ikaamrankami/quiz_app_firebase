import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/start_quiz_controller.dart';
import '../../core/const/app_colors.dart';

class StartQuizScreen extends StatelessWidget {
  StartQuizScreen({
    super.key,
  });

  final QuizController _quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          foregroundColor: Colors.white,
          title: Text(
            'Start Quiz',
            style: GoogleFonts.acme(fontSize: 25),
          ),
          actions: [
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Score: ${_quizController.score.value}',
                    style: GoogleFonts.acme(fontSize: 20),
                  ),
                )),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return _quizController.currentQuestion.value.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.appBarColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  _quizController
                                          .currentQuestion.value['question'] ??
                                      '',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              children: List.generate(
                                (_quizController.currentQuestion
                                        .value['choices'] as List<dynamic>)
                                    .length,
                                (index) {
                                  final choice = (_quizController
                                              .currentQuestion.value['choices']
                                          as List<dynamic>)[index] ??
                                      '';
                                  return ElevatedButton(
                                    onPressed: () =>
                                        _quizController.answerQuestion(index),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          _quizController.answered.value &&
                                                  _quizController
                                                          .selectedAnswerIndex
                                                          .value ==
                                                      index
                                              ? _quizController
                                                      .isCorrectAnswer(index)
                                                  ? Colors.green
                                                  : Colors.red
                                              : AppColors.appBarColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      choice,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _quizController.isLastQuestion
                                  ? () {
                                      _quizController.finishQuiz();
                                      Get.back(
                                          result: _quizController.score.value);
                                    }
                                  : _quizController.nextQuestion,
                              child: Text(
                                _quizController.isLastQuestion
                                    ? 'Finish Quiz'
                                    : 'Next Question',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        )
                      : Text('Welcome To The Quiz Attepmt',
                          style: GoogleFonts.acme());
                  //  ElevatedButton(
                  //     onPressed: _quizController.startQuiz,
                  //     child: const Text('Start Quiz'),
                  //   );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
