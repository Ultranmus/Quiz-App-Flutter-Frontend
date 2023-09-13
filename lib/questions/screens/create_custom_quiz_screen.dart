import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/questions/widgets/custom_button.dart';
import '../apis/all_spring_boot_apis.dart';

class CreateCustomQuizScreen extends ConsumerStatefulWidget {
  final Map<int, String> map;
  const CreateCustomQuizScreen({required this.map, Key? key}) : super(key: key);

  @override
  ConsumerState<CreateCustomQuizScreen> createState() =>
      _CreateCustomQuizScreenState();
}

class _CreateCustomQuizScreenState
    extends ConsumerState<CreateCustomQuizScreen> {
  TextEditingController titleController = TextEditingController();
  String id = '';

  onClickCreateQuiz() async {
    String title = titleController.text.trim();
    if (title.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Enter Quiz title', gravity: ToastGravity.SNACKBAR);
    } else {
      String res =
          await ref.read(apisProvider).createCustomQuiz(title, widget.map);
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
          id = res;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Quiz'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            id != ''
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: appBar,
                    ),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: Text(
                      id,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  )
                : const SizedBox(),
            id == ''
                ? SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Title for Quiz',
                      ),
                    ),
                  )
                : const SizedBox(),
            id == ''
                ? CustomButton(text: 'Create Quiz', function: onClickCreateQuiz)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
