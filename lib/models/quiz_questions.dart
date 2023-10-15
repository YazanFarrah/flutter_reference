class QuizQuestion {
  final List<String> answers;
  final String text;

  const QuizQuestion({
    required this.text,
    required this.answers,
  });

  List<String> get shuffledAnswers {
    //we copied the list and shuffled it instead of shuffling the original list
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
