import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/questions/apis/all_spring_boot_apis.dart';
import 'package:quiz_app/questions/screens/add_question_screen.dart';
import 'package:quiz_app/questions/screens/create_random_quiz_screen.dart';
import 'package:quiz_app/questions/screens/quiz_screen.dart';
import 'package:quiz_app/questions/screens/show_question_screen.dart';
import '../../provider/custom_quiz_size_provider.dart';
import '../widgets/custom_button.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends ConsumerState<MainScreen> {
  bool isExpanded = false;
  bool isExpandedId = false;
  bool isExpandedTitle = false;
  TextEditingController quizIdController = TextEditingController();
  TextEditingController quizTitleController = TextEditingController();

  onClickCreateRandomQuiz() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CreateRandomQuizScreen()));
  }

  onClickShowQuestion() {
    Map<int, String> map = {};
    ref.read(customQuizSizeProvider.notifier).update((state) => 0);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShowQuestionScreen(
                  map: map,
                )));
  }

  onClickAddQuestion() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddQuestionScreen()));
  }

  onClickTakeQuizById() {
    int? quizId = int.tryParse(quizIdController.text.trim());

    if (quizId == null) {
      quizIdController.clear();
      Fluttertoast.showToast(
          msg: 'Enter correct Integer quiz id', gravity: ToastGravity.SNACKBAR);
    } else {
      Map<int, String> map = {};
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizScreen(
                    quizId: quizId,
                    map: map,
                  )));
    }
  }

  onClickTakeQuizByTitle() async {
    String quizTitle = quizTitleController.text.trim();
    if (quizTitle.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Enter Quiz Title', gravity: ToastGravity.SNACKBAR);
    } else {
      int quizId = await ref.read(apisProvider).getQuizIdByTitle(quizTitle);

      Map<int, String> map = {};
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizScreen(
                    quizId: quizId,
                    map: map,
                  )));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quizTitleController.dispose();
    quizIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: AssetImage('lib/assets/quiz_logo.jpg'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Welcome to Quiz App',
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            back,
            nyanza,
            jade,
            appBar,
          ],
        )),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                  curve: Curves.easeInOutExpo,
                  constraints: const BoxConstraints(maxWidth: 300),
                  width:
                      isExpanded ? 0 : MediaQuery.sizeOf(context).width * 0.4,
                  duration: const Duration(milliseconds: 700),
                  child: Image.asset(
                    'lib/assets/brain_img.png',
                    fit: BoxFit.cover,
                  )),
              isExpanded
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        jade,
                        nyanza,
                        back,
                      ],
                    )),
                constraints: const BoxConstraints(maxWidth: 600),
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: ExpansionTile(
                  collapsedTextColor: Colors.white,
                  textColor: back,
                  collapsedIconColor: Colors.white,
                  iconColor: back,
                  collapsedShape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  collapsedBackgroundColor: Colors.teal,
                  backgroundColor: Colors.transparent,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                  title: Text(
                    'Start With the Quiz App',
                    style: TextStyle(fontSize: isExpanded ? 20 : 15),
                  ),
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpanded = value;
                    });
                  },
                  children: <Widget>[
                    if (isExpanded)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          CustomButton(
                              text: 'Add Question',
                              function: onClickAddQuestion),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomButton(
                              text: 'Show All Questions / Create Custom Quiz',
                              function: onClickShowQuestion,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            constraints: const BoxConstraints(
                              maxWidth: 550,
                            ),
                            child: Card(
                              elevation: 10,
                              child: ExpansionTile(
                                collapsedShape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                collapsedTextColor: text,
                                textColor: text,
                                collapsedIconColor: text,
                                iconColor: text,
                                collapsedBackgroundColor: back,
                                backgroundColor: back,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                title: const Text(
                                    'Take Quiz by Searching Quiz Id'),
                                onExpansionChanged: (value) {
                                  setState(() {
                                    isExpandedId = value;
                                  });
                                },
                                children: <Widget>[
                                  if (isExpandedId)
                                    Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.7,
                                          constraints: const BoxConstraints(
                                            maxWidth: 500,
                                          ),
                                          child: TextField(
                                            controller: quizIdController,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter Quiz Id',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomButton(
                                            text: 'Take a quiz',
                                            function: onClickTakeQuizById),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                              text: 'Create Random Quiz',
                              function: onClickCreateRandomQuiz),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            constraints: const BoxConstraints(
                              maxWidth: 550,
                            ),
                            child: Card(
                              elevation: 10,
                              child: ExpansionTile(
                                collapsedBackgroundColor: nyanza,
                                backgroundColor: nyanza,
                                textColor: text,
                                collapsedTextColor: text,
                                collapsedIconColor: text,
                                iconColor: text,
                                title: const Text(
                                    'Take Quiz by Searching Quiz Title'),
                                collapsedShape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent)),
                                onExpansionChanged: (value) {
                                  setState(() {
                                    isExpandedTitle = value;
                                  });
                                },
                                children: <Widget>[
                                  if (isExpandedTitle)
                                    Column(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.7,
                                          constraints: const BoxConstraints(
                                            maxWidth: 500,
                                          ),
                                          child: TextField(
                                            controller: quizTitleController,
                                            decoration: const InputDecoration(
                                              hintText: 'Enter Quiz Title',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomButton(
                                            text: 'Take a quiz',
                                            function: onClickTakeQuizByTitle),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
