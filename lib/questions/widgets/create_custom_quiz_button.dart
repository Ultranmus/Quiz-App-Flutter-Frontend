import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/questions/widgets/custom_button.dart';

import '../../provider/custom_quiz_size_provider.dart';

class CreateCustomQuizButton extends ConsumerWidget {
  final Function function;
  const CreateCustomQuizButton({Key? key, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
        text: 'Create a Quiz ${ref.watch(customQuizSizeProvider)}',
        function: function);
  }
}
