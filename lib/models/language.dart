import 'package:flutter/material.dart';

class ProgrammingLanguage {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final Color color;
  final List<String> topics;
  final int totalLessons;
  int completedLessons;

  ProgrammingLanguage({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.color,
    required this.topics,
    required this.totalLessons,
    this.completedLessons = 0,
  });

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0;
}
