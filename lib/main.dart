import 'package:flashcard_quiz_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/addquiz_controller.dart';
import 'core/app_services/firestore_s_addQuiz.dart';
import 'view/add_quiz_screen/add_quiz_screen.dart';
import 'view/home_screen/home_screen.dart';
import 'view/quiz_screen.dart/quiz_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: const Key('flashcard_quiz_app'),
      debugShowCheckedModeBanner: false,
      title: 'FlashCard Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen(key: GlobalKey())),
        GetPage(name: '/addQuiz', page: () => AddQuestionScreen()),
        GetPage(name: '/startQuiz', page: () => StartQuizScreen()),
      ],
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => AddQuestionController());
        Get.lazyPut(() => FirestoreService());
      }),
    );
  }
}
