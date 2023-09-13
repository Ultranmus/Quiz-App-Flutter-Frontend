import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/questions/apis/all_spring_boot_apis.dart';
import 'package:quiz_app/questions/widgets/custom_button.dart';
import '../../colors.dart';

class CreateRandomQuizScreen extends ConsumerStatefulWidget {
  const CreateRandomQuizScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateRandomQuizScreen> createState() =>
      _CreateRandomQuizScreen();
}

class _CreateRandomQuizScreen extends ConsumerState<CreateRandomQuizScreen> {
  TextEditingController numController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final categoryList = ["Java", "Python", "DotNet", "Javascript", "test"];
  String? selectedVal = "Java";
  String id = '';

  onClickCreateQuiz() async {
    int? numQ = int.tryParse(numController.text.trim());

    String title = titleController.text.trim();
    if (numQ == null || numQ > 10 || numQ < 1) {
      numController.clear();
      Fluttertoast.showToast(
          msg: 'Enter correct integer value from 1-10!',
          gravity: ToastGravity.SNACKBAR);
    } else if (title.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Enter Quiz title', gravity: ToastGravity.SNACKBAR);
    } else {
      String res = await ref
          .read(apisProvider)
          .createRandomQuiz(selectedVal!, numQ, title);
      Fluttertoast.showToast(
          msg: res,
          gravity: ToastGravity.SNACKBAR,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5);
      if (res == 'Failed to create quiz') {
        if (id != '') {
          setState(() {
            id = '';
          });
        }
      } else {
        setState(() {
          titleController.clear();
          numController.clear();
          id = res;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    numController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Random Quiz'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 600),
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              id != ''
                  ? Container(
                decoration: BoxDecoration(
                  color: teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                      padding: const EdgeInsets.all(10),

                width: MediaQuery.sizeOf(context).width * 0.7,
                      child: Text(
                        id,
                        style: const TextStyle(
                            color: back,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  : const SizedBox(),
              DropdownButtonFormField(
                iconEnabledColor: appBar,
                isDense: true,
                value: selectedVal,
                items: categoryList
                    .map((val) => DropdownMenuItem(
                          value: val,
                          child: Text(
                            val,
                            style: const TextStyle(color: appBar),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedVal = val;
                },
              ),
              TextField(
                controller: numController,
                decoration: InputDecoration(
                    hintText: 'Enter No. of Question not more then 10',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        gapPadding: 0,
                        borderSide: const BorderSide(color: Colors.black87))),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: 'Enter Title for Quiz',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        gapPadding: 0,
                        borderSide: const BorderSide(color: Colors.black87))),
              ),
              CustomButton(text: 'Create Quiz', function: onClickCreateQuiz),
            ],
          ),
        ),
      ),
    );
  }
}
