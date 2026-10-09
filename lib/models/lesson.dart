class Lesson {
  final String id;
  final String languageId;
  final String title;
  final String content;
  final String codeExample;
  final String language;
  final List<Quiz> quizzes;
  final int order;

  Lesson({
    required this.id,
    required this.languageId,
    required this.title,
    required this.content,
    required this.codeExample,
    required this.language,
    required this.quizzes,
    required this.order,
  });
}

class Quiz {
  final String question;
  final List<String> options;
  final int correctIndex;
  String? explanation;

  Quiz({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });
}
