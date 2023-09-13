import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:quiz_app/provider/category_provider.dart';
import 'package:quiz_app/questions/models/Question.dart';
import '../../enum.dart';

final apisProvider = Provider((ref) {
  const url = 'http://localhost:5000';
  Category category = ref.watch(categoryProvider);
  return Apis(category: category, url: url,apiKey: '6a93cf040ce0dbf9d91e197171c4bbf0');
});

class Apis {
  final String url;
  final Category category;
  final String apiKey;

  Apis( {required this.apiKey,required this.category, required this.url});

  //Question related Apis

  Future<String> addQuestionApi(Question question) async {
    try {
      final response = await post(
        Uri.parse('$url/questions/add'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "X-API-KEY": apiKey
        },
        body: jsonEncode(<String, String>{
          'questionTitle': question.questionTitle,
          'option1': question.option1,
          'option2': question.option2,
          'option3': question.option3,
          'option4': question.option4,
          'rightAnswer': question.rightAnswer!,
          'difficultyLevel': question.difficultyLevel!,
          'category': question.category!,
        }),
      );

      if (response.statusCode == 201) {
        return response.body.toString();
      } else {
        return 'Failed to add Question';
      }
    } catch (e) {
      return 'Failed to add Question';
    }
  }

  Future<List<Question>> getQuestionsApi() async {
    try {
      late String apiUrl;
      if (category == Category.All) {
        apiUrl = '$url/questions/allQuestions';
      } else if (category == Category.common) {
        apiUrl = '$url/questions/category/common sense';
      } else {
        apiUrl = '$url/questions/category/${category.name}';
      }
      final response = await get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-KEY': apiKey,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        List<Question> questionsList =
            list.map((e) => Question.fromJson(e)).toList();
        return questionsList;
      } else {
        throw Exception('Failed to get Questions');
      }
    } catch (e) {
      throw Exception('Failed to get Questions');
    }
  }

  //Quiz related Apis

  Future<dynamic> getQuiz(int quizId) async {
    String apiUrl = '$url/quiz/get/$quizId';

    try {
      final response = await get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-KEY': apiKey,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body);
        List<Question> questionsList =
            list.map((e) => Question.fromJson(e)).toList();
        return questionsList;
      } else {
        return 'Failed to get quiz';
      }
    } catch (e) {
      return 'Resource Not Found';
    }
  }

  Future<String> createRandomQuiz(
      String category, int numQ, String title) async {
    final apiUrl =
        '$url/quiz/create?category=$category&numQ=$numQ&title=$title';

    try {
      final response = await post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-KEY': apiKey,
        },
      );

      if (response.statusCode == 201) {
        return 'Created Quiz Id :${response.body.toString()}';
      } else {
        return 'Failed to create quiz';
      }
    } catch (e) {
      return 'Failed to create quiz';
    }
  }

  Future<String> createCustomQuiz(
      String title, Map<int, String> questionIds) async {
    try {
      final apiUrl = '$url/quiz/createCustom/$title';

      String jsonBody = jsonEncode(questionIds.keys.toList());
      final response = await post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-API-KEY': apiKey,
          },
          body: jsonBody);
      if (response.statusCode == 201) {
        return 'Created Quiz Id :${response.body.toString()}';
      } else {
        return 'Failed to create quiz';
      }
    } catch (e) {
      return 'Failed to create quiz';
    }
  }

  Future<dynamic> getQuizResult(int quizId, Map<int, String> map) async {
    String apiUrl = '$url/quiz/submit/$quizId';

    String jsonBody = jsonEncode(map.entries.map((entry) {
      return {
        'id': entry.key,
        'reponse': entry.value,
      };
    }).toList());

    try {
      final response = await post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-KEY': apiKey,
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        int score = jsonDecode(response.body);

        return score;
      } else {
        return 'Failed to get score';
      }
    } catch (e) {
      return 'Failed to get score';
    }
  }

  Future<dynamic> getQuizTitle(int quizId) async {
    String apiUrl = '$url/quiz/get/title/$quizId';

    try {
      final response = await get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-KEY': apiKey,
        },
      );

      if (response.statusCode == 200) {
        String title = response.body.toString();

        return title;
      } else {
        return 'Failed to get title';
      }
    } catch (e) {
      return 'Failed to get title';
    }
  }

  Future<dynamic> getQuizIdByTitle(String quizTitle) async {
    String apiUrl = '$url/quiz/get/id/$quizTitle';

    try {
      final response = await get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-API-KEY': apiKey,
        },
      );

      if (response.statusCode == 200) {
        int? title = int.tryParse(response.body);

        return title ?? -1;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }
}
