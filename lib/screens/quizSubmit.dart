import 'package:flutter/material.dart';
import 'package:quizzotic_frontend/models/question.dart';
import 'package:quizzotic_frontend/models/quiz.dart';

class QuizSubmit extends StatefulWidget {
  final Quiz quiz;
  const QuizSubmit({super.key, required this.quiz});

  @override
  State<QuizSubmit> createState() => _QuizSubmitState();
}

class _QuizSubmitState extends State<QuizSubmit> {

  var score = 0;

  getScore() {
    for (var question in widget.quiz.questions) {
      if (question.isCorrect()) {
        score++;
      }
    }
  }

  getAnswer(question) {
    var answer = '';
    for (var choice in question.choices) {
      if (choice.id == question.answerId) {
        answer = choice.text;
      }
    }

    return answer;
  }

  getSelectedAnswer(Question value) {
    var selectedAnswer = '';
    for (var choice in value.choices) {
      if (choice.id == value.selectedAnswerId) {
        selectedAnswer = choice.text;
      }
    }

    return selectedAnswer;
  }


  @override
  void initState() {
    getScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          //   Display the result of the quiz

            Card(
              child: Column(
                children: [
                  Text('Total Questions: ${widget.quiz.totalQuestions}'),
                  Text('Max Time: ${widget.quiz.maxTime}'),
                  Text('Score: $score'),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}