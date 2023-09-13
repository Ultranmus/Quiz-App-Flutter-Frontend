import 'package:flutter/material.dart';
import 'package:quiz_app/colors.dart';

class ScoreScreen extends StatelessWidget {
  final int quizId;
  final String quizTitle;
  final int score;
  const ScoreScreen(
      {Key? key,
      required this.quizId,
      required this.quizTitle,
      required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            quizTitle,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Quiz Id - ${quizId.toString()}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: Card(
            color: appBar,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: MediaQuery.sizeOf(context).width * 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You scored:',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    score.toString(),
                    style: const TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: nyanza),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
