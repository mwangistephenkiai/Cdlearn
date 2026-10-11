import 'package:flutter/material.dart';
import '../models/lesson.dart';

class QuizScreen extends StatefulWidget {
  final List<Quiz> quizzes;
  final Color accentColor;
  const QuizScreen({super.key, required this.quizzes, required this.accentColor});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int? selectedOption;
  bool answered = false;
  int correctAnswers = 0;

  Quiz get currentQuiz => widget.quizzes[currentIndex];

  void selectOption(int index) {
    if (answered) return;
    setState(() {
      selectedOption = index;
      answered = true;
      if (index == currentQuiz.correctIndex) correctAnswers++;
    });
  }

  void nextQuestion() {
    if (currentIndex < widget.quizzes.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
        answered = false;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    final percentage = (correctAnswers / widget.quizzes.length) * 100;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(percentage >= 70 ? Icons.emoji_events : Icons.school, size: 64, color: widget.accentColor),
            const SizedBox(height: 16),
            Text(percentage >= 70 ? 'Great Job!' : 'Keep Learning!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('You got $correctAnswers out of ${widget.quizzes.length} correct', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('${percentage.toStringAsFixed(0)}%', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: widget.accentColor)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz ${currentIndex + 1}/${widget.quizzes.length}'),
        backgroundColor: widget.accentColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (currentIndex + 1) / widget.quizzes.length,
                minHeight: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(widget.accentColor),
              ),
            ),
            const SizedBox(height: 32),
            Text(currentQuiz.question, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuiz.options.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedOption == index;
                  final isCorrect = index == currentQuiz.correctIndex;
                  Color? bgColor;
                  Color? borderColor;
                  IconData? icon;
                  if (answered) {
                    if (isCorrect) {
                      bgColor = Colors.green.withOpacity(0.1);
                      borderColor = Colors.green;
                      icon = Icons.check_circle;
                    } else if (isSelected) {
                      bgColor = Colors.red.withOpacity(0.1);
                      borderColor = Colors.red;
                      icon = Icons.cancel;
                    }
                  } else if (isSelected) {
                    bgColor = widget.accentColor.withOpacity(0.1);
                    borderColor = widget.accentColor;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: bgColor ?? Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => selectOption(index),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor ?? Colors.grey[300]!, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(currentQuiz.options[index], style: const TextStyle(fontSize: 16))),
                              if (icon != null) Icon(icon, color: borderColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (answered && currentQuiz.explanation != null)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.withOpacity(0.3))),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(child: Text(currentQuiz.explanation!, style: const TextStyle(color: Colors.blue))),
                  ],
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: answered ? nextQuestion : null,
                style: FilledButton.styleFrom(backgroundColor: widget.accentColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text(currentIndex < widget.quizzes.length - 1 ? 'Next Question' : 'See Results', style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
