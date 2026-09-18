import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String title;
  final String tag;
  final String emoji;
  final int postCount;
  final Color accentColor;
  final Color bgColor;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.emoji,
    required this.postCount,
    required this.accentColor,
    required this.bgColor,
  });

  static const List<CategoryItem> defaultCategories = [
    CategoryItem(
      id: 'c1',
      title: 'Tech & Code',
      tag: '#Tech',
      emoji: '💻',
      postCount: 124,
      accentColor: Color(0xFF3525CD),
      bgColor: Color(0xFFF0F3FF),
    ),
    CategoryItem(
      id: 'c2',
      title: 'Study Sprint',
      tag: '#StudySprint',
      emoji: '📚',
      postCount: 89,
      accentColor: Color(0xFF7E22CE),
      bgColor: Color(0xFFFAF5FF),
    ),
    CategoryItem(
      id: 'c3',
      title: 'Campus Life',
      tag: '#CampusLife',
      emoji: '🎓',
      postCount: 210,
      accentColor: Color(0xFF0284C7),
      bgColor: Color(0xFFF0F9FF),
    ),
    CategoryItem(
      id: 'c4',
      title: 'Design & UI',
      tag: '#Design',
      emoji: '🎨',
      postCount: 45,
      accentColor: Color(0xFFDB2777),
      bgColor: Color(0xFFFDF2F8),
    ),
    CategoryItem(
      id: 'c5',
      title: 'Coffee & Chill',
      tag: '#Chill',
      emoji: '☕',
      postCount: 76,
      accentColor: Color(0xFFD97706),
      bgColor: Color(0xFFFFFBEB),
    ),
    CategoryItem(
      id: 'c6',
      title: 'Campus Events',
      tag: '#Events',
      emoji: '📅',
      postCount: 32,
      accentColor: Color(0xFF059669),
      bgColor: Color(0xFFECFDF5),
    ),
  ];
}
