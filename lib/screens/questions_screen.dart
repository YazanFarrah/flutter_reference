import 'package:flutter/material.dart';
import 'package:flutter_reference/constants/constants.dart';
import 'package:flutter_reference/screens/results_screen.dart';
import 'package:flutter_reference/widgets/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  List<String> selectedAnswers = [];
  void chooseAnswer({required String answer}) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        currentQuestionIndex = 0;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            chosenAnswers: selectedAnswers,
          ),
        ),
      );
    }
  }

  void answerQuestion({required String selectedAnswer}) {
    setState(() {
      currentQuestionIndex++;
    });
    chooseAnswer(answer: selectedAnswer);
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: myGradientBoxDecoration,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 200, 193, 248),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ...currentQuestion.shuffledAnswers.map((answer) {
              return AnswerButton(
                  text: answer,
                  onTap: () {
                    answerQuestion(selectedAnswer: '');
                  });
            }),
          ],
        ),
      ),
    );
  }
}
