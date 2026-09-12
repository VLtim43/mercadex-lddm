import 'package:flutter/material.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.person_outline, 'Minha conta'),
      (Icons.volunteer_activism_outlined, 'Minhas contribuições'),
      (Icons.tune_outlined, 'Preferências'),
      (Icons.info_outline, 'Sobre o Mercadex'),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            AppConstants.tabContentBottomPadding,
          ),
          children: [
            Text(
              'Perfil',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.deepGreen,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.seed,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Usuário Mercadex',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Colaborador da comunidade',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...items.map(
              (item) => Card(
                child: ListTile(
                  leading: Icon(item.$1, color: AppColors.seed),
                  title: Text(item.$2),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.$2} estará disponível em breve.'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
