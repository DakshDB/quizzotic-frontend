import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzotic_frontend/configs/quizzotic.dart';
import 'package:quizzotic_frontend/models/quiz.dart';
import 'package:http/http.dart' as http;

final quizListProvider = StateNotifierProvider<QuizListController, List<Quiz>>((ref) {
  return QuizListController([]);
});

class QuizListController extends StateNotifier<List<Quiz>> {
  QuizListController(List<Quiz> state) : super(state);

  Future<void> getQuizzes() async {
    var url = Uri.parse('$host/quiz');

    var request = http.get(url);

    await request.then((response) {
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      var data = (jsonRes as List).cast<Map<String, dynamic>>();
      List<Quiz> quizzes = data.map((e) => Quiz.fromJson(e)).toList();
      state = quizzes;
    } else {
      //   Handle error
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }
    });
  }
}



