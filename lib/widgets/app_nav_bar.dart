import 'package:flutter/material.dart';

import '../routes.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  static const _targets = [Routes.home, Routes.profile];

  void _onSelected(BuildContext context, int index) {
    final target = _targets[index];
    // Уже находимся на нужном экране
    if (ModalRoute.of(context)?.settings.name == target) return;
    // Очищаем стек, чтобы переключение вкладок не копило экраны
    Navigator.of(context).pushNamedAndRemoveUntil(target, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.lightBlue.shade50,
      indicatorColor: Colors.lightBlueAccent.shade100,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) => _onSelected(context, i),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Главная',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}
