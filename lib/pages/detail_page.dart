import 'package:flutter/material.dart';

import '../models/feature.dart';
import '../widgets/app_nav_bar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final feature = ModalRoute.of(context)!.settings.arguments as Feature;

    return Scaffold(
      appBar: AppBar(
        title: Text(feature.title),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    feature.image,
                    width: 240,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 240,
                      height: 160,
                      color: Colors.grey.shade300,
                      child: Icon(feature.icon, size: 64, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(feature.description, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppNavBar(selectedIndex: 0),
    );
  }
}
