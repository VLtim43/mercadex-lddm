import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/core/widgets/primary_button.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear produto')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 140,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.accent, width: 3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Positioned(
                        bottom: 32,
                        left: 24,
                        right: 24,
                        child: Text(
                          'Aponte a câmera para o código de barras do produto',
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Simular leitura',
                icon: Icons.document_scanner,
                onPressed: () =>
                    context.push('/product/${AppConstants.cokeProductId}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
