import 'choice.dart';

class Question {
  String question;
  List<Choice> choices;
  int answerId;
  int selectedAnswerId = -1;

  Question({required this.question, required this.choices, required this.answerId});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      choices: json['choices'].map<Choice>((choice) => Choice.fromJson(choice)).toList(),
      answerId: json['answerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': choices.map((choice) => choice.toJson()).toList(),
      'answer': answerId,
    };
  }

  void selectAnswer(int index) {
    selectedAnswerId = index;
  }

  bool isCorrect() {
    return selectedAnswerId == answerId;
  }

  bool isAnswered() {
    return selectedAnswerId != -1;
  }

}
