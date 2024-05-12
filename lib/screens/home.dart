import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzotic_frontend/controllers/quiz_list.dart';
import 'package:quizzotic_frontend/models/quiz.dart';
import 'package:quizzotic_frontend/screens/quizHome.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  // Get quizzes from provider
  List<Quiz> quizzes = [];

  @override
  void initState() {
    ref.read(quizListProvider.notifier).getQuizzes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get quizzes from the provider
    quizzes = ref.watch(quizListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .secondary,
        title: const Text('Quizzotic'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          //   Card list of the quizzes
            Expanded(
              child: ListView.builder(
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(quizzes[index].name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizHome(id: quizzes[index].id),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
