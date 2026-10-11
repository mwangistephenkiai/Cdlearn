import 'package:flutter/material.dart';
import '../data/course_data.dart';
import '../models/language.dart';
import '../models/lesson.dart';
import 'lesson_screen.dart';

class LanguageDetailScreen extends StatelessWidget {
  final ProgrammingLanguage language;
  const LanguageDetailScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final lessons = CourseData.getLessons(language.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [language.color, language.color.withOpacity(0.7)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(language.name, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(language.description, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: language.topics.map((topic) {
                            return Chip(
                              label: Text(topic, style: const TextStyle(color: Colors.white, fontSize: 12)),
                              backgroundColor: Colors.white.withOpacity(0.2),
                              side: BorderSide.none,
                              padding: EdgeInsets.zero,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Text('Lessons', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LessonTile(lesson: lessons[index], color: language.color, index: index + 1),
                childCount: lessons.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final Color color;
  final int index;
  const LessonTile({super.key, required this.lesson, required this.color, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(lesson: lesson, accentColor: color))),
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.15), child: Text('$index', style: TextStyle(color: color, fontWeight: FontWeight.bold))),
        title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${lesson.quizzes.length} quizzes', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        trailing: const Icon(Icons.play_circle_outline),
      ),
    );
  }
}
