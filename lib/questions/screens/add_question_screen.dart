import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/questions/apis/all_spring_boot_apis.dart';
import 'package:quiz_app/questions/widgets/custom_button.dart';
import '../models/Question.dart';

class AddQuestionScreen extends ConsumerStatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  ConsumerState<AddQuestionScreen> createState() => _CreateState();
}

class _CreateState extends ConsumerState<AddQuestionScreen> {
  _CreateState() {
    _selectedVal = _categoryList[0];
    _selectedDifficulty = _difficultyList[0];
  }
  final _categoryList = ["Java", "Python", "DotNet", "Javascript", "test"];
  String? _selectedVal = "";
  final _difficultyList = ["Easy", "Medium", "Hard"];
  String? _selectedDifficulty = "";
  TextEditingController questionTitleController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController rightAnswerController = TextEditingController();

  addQuestion(BuildContext context) async {
    var questionTitle = questionTitleController.text.trim();
    var option1 = option1Controller.text.trim();
    var option2 = option2Controller.text.trim();
    var option3 = option3Controller.text.trim();
    var option4 = option4Controller.text.trim();
    var rightAnswer = rightAnswerController.text.trim();
    if (questionTitle.isEmpty ||
        option1.isEmpty ||
        option2.isEmpty ||
        option3.isEmpty ||
        option4.isEmpty ||
        rightAnswer.isEmpty ||
        _selectedVal!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error! Please fill all the details."),
        duration: Duration(seconds: 3),
      ));
    } else {
      final question = Question(
          questionTitle: questionTitle,
          option1: option1,
          option2: option2,
          option3: option3,
          option4: option4,
          rightAnswer: rightAnswer,
          difficultyLevel: _selectedDifficulty!,
          category: _selectedVal!);
      String res = await ref.read(apisProvider).addQuestionApi(question);
      Fluttertoast.showToast(msg: res, gravity: ToastGravity.SNACKBAR);
      if (res != 'Failed to add Question') {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    questionTitleController.dispose();
    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    option4Controller.dispose();
    rightAnswerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("QuizApp"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            width: size.width * 0.8,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: questionTitleController,
                    decoration: const InputDecoration(
                      labelText: "Question Title",
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: option1Controller,
                    decoration: const InputDecoration(
                      labelText: "Option 1",
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: option2Controller,
                    decoration: const InputDecoration(
                      labelText: "Option 2",
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: option3Controller,
                    decoration: const InputDecoration(
                      labelText: "Option 3",
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: option4Controller,
                    decoration: const InputDecoration(
                      labelText: "Option 4",
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: rightAnswerController,
                    decoration: const InputDecoration(
                      labelText: "Right Answer",
                    )),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  iconEnabledColor: appBar,
                  value: _selectedVal,
                  items: _categoryList
                      .map((val) => DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: const TextStyle(color: appBar),
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    _selectedVal = val;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  iconEnabledColor: appBar,
                  value: _selectedDifficulty,
                  items: _difficultyList
                      .map((val) => DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                              style: const TextStyle(color: appBar),
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    _selectedDifficulty = val;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Add Question", function: () => addQuestion(context)),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
