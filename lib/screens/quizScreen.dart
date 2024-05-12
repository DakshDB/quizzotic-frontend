import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzotic_frontend/controllers/quiz.dart';
import 'package:quizzotic_frontend/models/question.dart';
import 'package:quizzotic_frontend/screens/quizSubmit.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final int id;
  const QuizScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {


  @override
  void initState() {
    ref.read(quizProvider.notifier).getQuiz(widget.id);
    super.initState();
  }

  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider);

    getGroupValue(Question question) {
      return question.choices.indexWhere((element) => element.id == question.selectedAnswerId);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(quiz.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Total Questions: ${quiz.totalQuestions}'),
                Text('Max Time: ${quiz.maxTime}'),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  // Question number
                  Text('Question ${currentQuestionIndex + 1} of ${quiz.totalQuestions}'),
                  // Display the question
                  Text(quiz.questions[currentQuestionIndex].question),
                  ...quiz.questions[currentQuestionIndex].choices.asMap().entries.map((entry) {
                    return RadioListTile<int>(
                      title: Text(entry.value.text),
                      value: entry.key,
                      groupValue: getGroupValue(quiz.questions[currentQuestionIndex]),
                      onChanged: (value) {
                        setState(() {
                          var choice = quiz.questions[currentQuestionIndex].choices[value!];
                          quiz.questions[currentQuestionIndex].selectedAnswerId = choice.id;
                        });
                      },
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Always show the back button, but disable it for the first question
                      Visibility(
                        visible: (currentQuestionIndex > 0),
                        child: ElevatedButton(
                          onPressed: currentQuestionIndex > 0
                              ? () {
                            setState(() {
                              currentQuestionIndex--;
                            });
                          }
                              : null,
                          child: const Text('Back'),
                        ),
                      ),
                      // Always show the submit button, but only enable it for the last question
                      Visibility(
                        visible: (currentQuestionIndex == quiz.totalQuestions - 1),
                        child: ElevatedButton(
                          onPressed: currentQuestionIndex == quiz.totalQuestions - 1
                              ? () {
                            // Navigate to the result screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QuizSubmit(quiz: quiz)),
                            );
                          }
                              : null,
                          child: const Text('Submit'),
                        ),
                      ),
                      // Always show the next button, but disable it for the last question
                      Visibility(
                        visible: (currentQuestionIndex < quiz.totalQuestions - 1),
                        child: ElevatedButton(
                          onPressed: currentQuestionIndex < quiz.totalQuestions - 1
                              ? () {
                            setState(() {
                              currentQuestionIndex++;
                            });
                          }
                              : null,
                          child: const Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
