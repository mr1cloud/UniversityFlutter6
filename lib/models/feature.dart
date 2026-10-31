import 'package:flutter/material.dart';

class Feature {
  const Feature({
    required this.title,
    required this.icon,
    required this.image,
    required this.description,
  });

  final String title;
  final IconData icon;
  final String image;
  final String description;
}