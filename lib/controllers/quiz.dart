import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzotic_frontend/configs/quizzotic.dart';
import 'package:quizzotic_frontend/models/quiz.dart';
import 'package:http/http.dart' as http;

final quizProvider = StateNotifierProvider<QuizController, Quiz>((ref) {
  return QuizController(Quiz(id: 0, name: '', questions: [], totalQuestions: 0, maxTime: 0));
});

class QuizController extends StateNotifier<Quiz> {
  QuizController(Quiz state) : super(state);

  Future<void> getQuiz(int id) async {
    var url = Uri.parse('$host/quiz/$id');

    var request = http.get(url);

    await request.then((response) {
      if (response.statusCode == 200) {
        var jsonRes = jsonDecode(response.body);
        state = Quiz.fromJson(jsonRes);
      } else {
        //   Handle error
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    });
  }
}