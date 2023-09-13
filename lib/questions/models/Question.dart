class Question {

  final String questionTitle;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String? rightAnswer;
  final String? difficultyLevel;
  final String? category;
  final int? id;

   Question( {this.id,required this.questionTitle,required this.option1,required this.option2,required this.option3,required this.option4,required this.rightAnswer,required this.difficultyLevel,required this.category});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionTitle: json['questionTitle'],
      option1: json['option1'],
      option2: json['option2'],
      option3: json['option3'],
      option4: json['option4'],
      rightAnswer: json['rightAnswer'] ?? 'Answer is Secret',
      difficultyLevel: json['difficultyLevel'] ?? 'Test',
      category: json['category'] ?? 'Take quiz calmly',
      id: json['id'],
    );
  }
}