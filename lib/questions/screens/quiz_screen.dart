import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/questions/screens/score_screen.dart';
import 'package:quiz_app/questions/widgets/custom_button.dart';
import '../apis/all_spring_boot_apis.dart';
import '../widgets/question_card.dart';

class QuizScreen extends ConsumerWidget {
  final int quizId;
  final Map<int, String> map;
  const QuizScreen({required this.quizId, required this.map, Key? key})
      : super(key: key);

  void handleRadioSelected(String selectedOption, int id, WidgetRef ref) {
    if (selectedOption == 'clear value -1') {
      map.remove(id);
    } else {
      map[id] = selectedOption;
    }
  }

  onClickSubmit(WidgetRef ref, BuildContext context) async {
    var res = await ref.read(apisProvider).getQuizResult(quizId, map);
    final quizTitle = await ref.read(apisProvider).getQuizTitle(quizId);
    if (quizTitle != 'Failed to get title' && res != 'Failed to get score') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ScoreScreen(
                  quizId: quizId, quizTitle: quizTitle, score: res)));
    } else {
      Fluttertoast.showToast(
          msg: 'Some Error Occurs!', gravity: ToastGravity.SNACKBAR);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<dynamic>(
          future: ref.read(apisProvider).getQuizTitle(quizId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError ||
                snapshot.data == 'Failed to get title') {
              return const Text('Quiz');
            }
            return Text(snapshot.data);
          },
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: ref.watch(apisProvider).getQuiz(quizId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: appBar,
              ),
            );
          } else if (snapshot.hasError) {
            // Display an error message in an AlertDialog
            return const Center(
              child: Text(
                'Error fetching quiz',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: appBar),
              ),
            );
          } else if (!snapshot.hasData ||
              snapshot.data!.isEmpty ||
              snapshot.data == 'Failed to get quiz') {
            return const Center(
              child: Text(
                'No such quiz exist',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: appBar),
              ),
            );
          } else if (snapshot.data == 'Resource Not Found') {
            return const Center(
              child: Text(
                'Failed to get Quiz',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: appBar),
              ),
            );
          }

          // If data is available, show the PageView
          return Stack(
            children: [
              PageView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: QuestionCard(
                      map: map,
                      index: index,
                      snapshot: snapshot.data![index],
                      onRadioSelected: handleRadioSelected,
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    text: 'submit',
                    function: () => onClickSubmit(ref, context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
