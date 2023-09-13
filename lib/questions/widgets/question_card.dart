import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/colors.dart';
import 'package:quiz_app/questions/models/Question.dart';

class QuestionCard extends ConsumerStatefulWidget {
  final Map<int, String> map;
  final int index;
  final Question snapshot;
  final Function onRadioSelected;
  const QuestionCard(
      {super.key,
      required this.index,
      required this.snapshot,
      required this.onRadioSelected,
      required this.map});

  @override
  ConsumerState<QuestionCard> createState() => _QuestionCard();
}

class _QuestionCard extends ConsumerState<QuestionCard> {
  int currentOption = -1;

  @override
  Widget build(BuildContext context) {
    if (!widget.map.containsKey(widget.snapshot.id)) {
      currentOption = -1;
    } else {
      int id = widget.snapshot.id!;
      if (widget.snapshot.option1 == widget.map[id]) {
        currentOption = 1;
      } else if (widget.snapshot.option2 == widget.map[id]) {
        currentOption = 2;
      } else if (widget.snapshot.option3 == widget.map[id]) {
        currentOption = 3;
      } else if (widget.snapshot.option4 == widget.map[id]) {
        currentOption = 4;
      } else {
        currentOption = -1;
      }
    }
    final difficulty = widget.snapshot.difficultyLevel!.toLowerCase();
    return SingleChildScrollView(
      child: Card(
        color: back,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: difficulty == 'easy'
                        ? jade
                        : difficulty == 'medium'
                            ? Colors.grey
                            : Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        difficulty,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Card(
                    color: text,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        widget.snapshot.category!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.index + 1}. ${widget.snapshot.questionTitle}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        RadioListTile(
                            value: 1,
                            title: Text(widget.snapshot.option1),
                            groupValue: currentOption,
                            onChanged: (val) {
                              setState(() {
                                currentOption = 1;
                                widget.onRadioSelected(widget.snapshot.option1,
                                    widget.snapshot.id!, ref);
                              });
                            }),
                        RadioListTile(
                            value: 2,
                            title: Text(widget.snapshot.option2),
                            groupValue: currentOption,
                            onChanged: (val) {
                              setState(() {
                                currentOption = 2;
                                widget.onRadioSelected(widget.snapshot.option2,
                                    widget.snapshot.id!, ref);
                              });
                            }),
                        RadioListTile(
                            value: 3,
                            title: Text(widget.snapshot.option3),
                            groupValue: currentOption,
                            onChanged: (value) {
                              setState(() {
                                widget.onRadioSelected(widget.snapshot.option3,
                                    widget.snapshot.id!, ref);
                                currentOption = 3;
                              });
                            }),
                        RadioListTile(
                            value: 4,
                            title: Text(widget.snapshot.option4),
                            groupValue: currentOption,
                            onChanged: (val) {
                              setState(() {
                                widget.onRadioSelected(widget.snapshot.option4,
                                    widget.snapshot.id!, ref);
                                currentOption = 4;
                              });
                            }),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: teal,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.onRadioSelected(
                                'clear value -1', widget.snapshot.id!, ref);
                            currentOption = -1;
                          });
                        },
                        icon: const Icon(
                          CupertinoIcons.trash,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
              Card(
                color: Colors.black38,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Answer',
                        style: TextStyle(fontSize: 17, color: Colors.white70),
                      ),
                      Text(
                        '=> ${widget.snapshot.rightAnswer!}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
