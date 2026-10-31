import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

import '../models/feature.dart';
import '../routes.dart';
import '../widgets/app_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const images = [
    'assets/images/cloud-storage.png',
    'assets/images/amazon-cloud.png',
    'assets/images/azure-cloud.png',
    'assets/images/cloudflare-cloud.png',
    'assets/images/google-cloud.png',
  ];

  static const features = [
    Feature(
      title: 'Удобный интерфейс',
      icon: Icons.touch_app,
      image: 'assets/images/cloud-storage.png',
      description:
          'Простой и понятный интерфейс: загружайте, скачивайте и '
          'упорядочивайте файлы в несколько касаний.',
    ),
    Feature(
      title: 'Контроль доступа',
      icon: Icons.lock,
      image: 'assets/images/amazon-cloud.png',
      description:
          'Настраивайте, кто может просматривать и редактировать ваши файлы. '
          'Делитесь ссылками с друзьями и коллегами.',
    ),
    Feature(
      title: 'Бесплатно до 1ТБ',
      icon: Icons.sd_storage,
      image: 'assets/images/azure-cloud.png',
      description:
          'Бесплатный тариф включает до 1 ТБ места для долгосрочного '
          'хранения любых типов файлов.',
    ),
    Feature(
      title: 'Синхронизация',
      icon: Icons.sync,
      image: 'assets/images/google-cloud.png',
      description:
          'Информация синхронизируется между всеми вашими устройствами '
          'в реальном времени.',
    ),
  ];

  bool get _isDesktopOrWeb =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  void _openDetail(BuildContext context, Feature feature) {
    Navigator.pushNamed(context, Routes.detail, arguments: feature);
  }

  Widget _featureCard(BuildContext context, Feature feature) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(feature.icon, color: Colors.blue),
        title: Text(feature.title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openDetail(context, feature),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool wide = width > 600;
    // Дополнительные вертикальные отступы для десктопа и веб
    final double gap = _isDesktopOrWeb ? 32 : 12;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cloud Storage',
          style: TextStyle(fontFamily: 'PressStart2P', color: Colors.purple),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Облачные хранилища',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: gap),
                const Text(
                  'Современный сервис для загрузки, скачивания и долгосрочного '
                  'хранения любых типов файлов. Защитите свои данные от утери, '
                  'делитесь ссылками с друзьями и коллегами и синхронизируйте '
                  'информацию между всеми своими устройствами в реальном времени.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      images[index],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.cloud, color: Colors.blue),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: gap),
          Expanded(
            child: wide
                // Ширина > 600: карточки в 2 столбца
                ? GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: features.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: gap,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 72,
                    ),
                    itemBuilder: (context, index) =>
                        _featureCard(context, features[index]),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: features.length,
                    separatorBuilder: (_, _) => SizedBox(height: gap),
                    itemBuilder: (context, index) =>
                        _featureCard(context, features[index]),
                  ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: gap, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person, color: Colors.blue, size: 50),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Плотников Максим Павлович',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('ИКБО-60-23', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppNavBar(selectedIndex: 0),
    );
  }
}
