// ignore_for_file: unused_field, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/const/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required Key key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> completedQuizzes = [];

  double? _score;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          foregroundColor: Colors.white,
          title: Text(
            'FlashCard Quiz',
            style: GoogleFonts.acme(fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.all(10),
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.appBarColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'History Of Your Quiz',
                      style:
                          GoogleFonts.acme(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: completedQuizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = completedQuizzes[index];
                          final bool passed = quiz['score'] >= 50;

                          return Card(
                            elevation: 1,
                            color: Colors.amber.shade500,
                            child: ListTile(
                              iconColor: Colors.white,
                              textColor: Colors.white,
                              leading: Text(
                                '${index + 1}',
                                style: GoogleFonts.abel(fontSize: 20),
                              ),
                              title: Text(
                                passed ? 'Quiz Passed' : 'Quiz Failed',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: passed ? Colors.green : Colors.red,
                                ),
                              ),
                              subtitle: Text(
                                'Score: ${quiz['score']}%',
                                style: GoogleFonts.abel(fontSize: 14),
                              ),
                              trailing: passed
                                  ? const Icon(
                                      Icons.check,
                                      size: 25,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (int index) {
            switch (index) {
              case 0:
                // Navigate to HomeScreen
                break;
              case 1:
                Get.toNamed('/addQuiz');
                break;
              case 2:
                Get.toNamed('/startQuiz')!.then((value) {
                  if (value != null) {
                    setState(() {
                      completedQuizzes.add({
                        'title': 'Quiz ${completedQuizzes.length + 1}',
                        'score': value,
                      });
                      _score = value.toDouble();
                      print('Completed Quizzes: $completedQuizzes');
                    });
                  }
                });
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: 'Start Quiz',
            ),
          ],
          backgroundColor: AppColors.appBarColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white60,
        ),
      ),
    );
  }
}
