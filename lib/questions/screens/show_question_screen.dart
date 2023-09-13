import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/provider/category_provider.dart';
import 'package:quiz_app/provider/custom_quiz_size_provider.dart';
import 'package:quiz_app/questions/apis/all_spring_boot_apis.dart';
import 'package:quiz_app/questions/screens/create_custom_quiz_screen.dart';
import 'package:quiz_app/questions/widgets/create_custom_quiz_button.dart';
import 'package:quiz_app/questions/widgets/custom_button.dart';
import 'package:quiz_app/questions/widgets/question_card.dart';
import '../../enum.dart';

class ShowQuestionScreen extends ConsumerWidget {
  final Map<int, String> map;
  const ShowQuestionScreen({required this.map, super.key});

  void handleRadioSelected(String selectedOption, int id, WidgetRef ref) {
    if (selectedOption == 'clear value -1') {
      if (map.containsKey(id)) {
        map.remove(id);
        ref.read(customQuizSizeProvider.notifier).update((state) {
          if (state > 0) {
            return --state;
          } else {
            return state;
          }
        });
      }
    } else {
      if (!map.containsKey(id)) {
        ref.read(customQuizSizeProvider.notifier).update((state) => ++state);
      }
      map[id] = selectedOption;
    }
  }

  onClickCreateQuiz(BuildContext context) {
    if (map.length >= 5) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreateCustomQuizScreen(map: map)));
    } else {
      Fluttertoast.showToast(msg: 'At least select five questions for quiz');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Category? selectedVal = Category.All;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        actions: [
          Container(
              constraints: const BoxConstraints(maxWidth: 300),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              width: MediaQuery.sizeOf(context).width * 0.4,
              child: DropdownButtonFormField(
                iconEnabledColor: Colors.white60,
                elevation: 20,
                isDense: true,
                dropdownColor: teal,
                style: const TextStyle(color: Colors.white),
                value: selectedVal,
                items: Category.values
                    .map((val) => DropdownMenuItem(
                          value: val,
                          child: Text(
                            val.name,
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  ref.read(categoryProvider.notifier).update((state) => val!);
                  selectedVal = val;
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60)),
                ),
              )),
        ],
      ),
      body: FutureBuilder(
          future: ref.watch(apisProvider).getQuestionsApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: appBar,
                ),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text(
                  'Failed to get Questions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25, color: appBar),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No questions exist',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: appBar),
                  ),
                );
              }

              return PageView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: QuestionCard(
                            index: index,
                            snapshot: snapshot.data![index],
                            onRadioSelected: handleRadioSelected,
                            map: map));
                  });
            } else if (snapshot.hasError) {
              return SnackBar(
                content: Text('${snapshot.error}'),
              );
            }

            return const Center(
              child: Text(
                'Some Error Occurred',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: appBar),
              ),
            );
          }),
      floatingActionButton: CreateCustomQuizButton(
        function: () => onClickCreateQuiz(context),
      ),
    );
  }
}
