import 'package:flutter/material.dart';
import 'package:flutter_reference/constants/constants.dart';
import 'package:flutter_reference/data/questions.dart';
import 'package:flutter_reference/widgets/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
  });

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        //because we set the first answer answers[0] to be the correct one
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  int countCorrectAnswers() {
    int numCorrectQst = 0;

    for (int i = 0; i < questions.length; i++) {
      if (chosenAnswers[i] == questions[i].answers[0]) {
        numCorrectQst++;
      }
    }

    return numCorrectQst;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQst = questions.length;
    int numCorrectQst = countCorrectAnswers();
    // final numCorrectQst = summaryData.where((data) {
    //   return data['user_answer'] == data['correct_answer'];
    // }).length;

    // for (int i = 0; i < numTotalQst; i++) {
    //   if (chosenAnswers[i] == questions[i].answers[0]) {
    //     numCorrectQst++;
    //   }
    // }
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: myGradientBoxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                'You answered $numCorrectQst out of $numTotalQst questions correctly!'),
            const SizedBox(height: 20),
            QuestionsSummary(summaryData: summaryData),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(elevation: 8),
              onPressed: () {},
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
