import 'package:flutter/material.dart';

/// Model class representing an onboarding page item
class HomeItem {
  final String image;
  final String title;
  final String description;
  final Color color;
  final Color dotsColor;
  final Color backgroundColor;
  final IconData icon;

  const HomeItem({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.dotsColor,
    required this.backgroundColor,
    required this.icon,
  });
}
