import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import '../models/lesson.dart';
import '../services/auth_service.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final Color accentColor;
  const LessonScreen({super.key, required this.lesson, required this.accentColor});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool showCode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        backgroundColor: widget.accentColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu_book, color: widget.accentColor),
                        const SizedBox(width: 8),
                        Text('Lesson Content', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 24),
                    Text(widget.lesson.content, style: const TextStyle(fontSize: 15, height: 1.6)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.lesson.codeExample.isNotEmpty)
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.code, color: widget.accentColor),
                              const SizedBox(width: 8),
                              Text('Code Example', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          IconButton(
                            icon: Icon(showCode ? Icons.visibility_off : Icons.visibility, size: 20),
                            onPressed: () => setState(() => showCode = !showCode),
                          ),
                        ],
                      ),
                    ),
                    if (showCode)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: const Color(0xFF282C34), borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.all(16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: HighlightView(
                            widget.lesson.codeExample,
                            language: widget.lesson.language == 'php' ? 'php' : widget.lesson.language == 'html' ? 'xml' : 'javascript',
                            theme: atomOneDarkTheme,
                            padding: const EdgeInsets.all(16),
                            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(quizzes: widget.lesson.quizzes, accentColor: widget.accentColor),
                    ),
                  );
                  if (result == true) {
                    await AuthService().updateLessonProgress(widget.lesson.languageId, widget.lesson.order);
                  }
                },
                icon: const Icon(Icons.quiz),
                label: const Text('Take Quiz', style: TextStyle(fontSize: 16)),
                style: FilledButton.styleFrom(backgroundColor: widget.accentColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
