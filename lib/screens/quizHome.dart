import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzotic_frontend/controllers/quiz.dart';
import 'package:quizzotic_frontend/screens/quizScreen.dart';

class QuizHome extends ConsumerStatefulWidget {
  final int id;
  const QuizHome({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends ConsumerState<QuizHome> {

  @override
  void initState() {
    ref.read(quizProvider.notifier).getQuiz(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(quiz.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              quiz.name,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen(id: quiz.id)),
                  );
                },
                child: const Text('Start Quiz')
            ),
          ],
        ),
      ),
    );
  }
}
