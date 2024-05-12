import 'package:quizzotic_frontend/models/question.dart';

class Quiz {
  int id;
  String name;
  List<Question> questions;
  int totalQuestions;
  int maxTime;

  Quiz({required this.id,required this.name, required this.questions, required this.totalQuestions, required this.maxTime});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    List<Question> questions = [];
    for (var question in json['questions']) {
      questions.add(Question.fromJson(question));
    }
    return Quiz(
      id: json['id'],
      name: json['name'],
      questions: questions,
      totalQuestions: json['totalQuestions'],
      maxTime: json['maxTime'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> questions = [];
    for (var question in this.questions) {
      questions.add(question.toJson());
    }
    return {
      'id': id,
      'name': name,
      'questions': questions,
      'totalQuestions': totalQuestions,
      'maxTime': maxTime,
    };
  }

  int getScore() {
    int score = 0;
    for (var question in questions) {
      if (question.isCorrect()) {
        score++;
      }
    }
    return score;
  }

  int getAnsweredQuestions() {
    int answeredQuestions = 0;
    for (var question in questions) {
      if (question.isAnswered()) {
        answeredQuestions++;
      }
    }
    return answeredQuestions;
  }

  bool isCompleted() {
    return getAnsweredQuestions() == totalQuestions;
  }

}

