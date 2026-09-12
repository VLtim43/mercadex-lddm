import 'package:flutter/material.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/features/markets/data/mock_markets.dart';

class ComparisonPage extends StatelessWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final comparisons = MockMarkets.listComparison;

    return Scaffold(
      appBar: AppBar(title: const Text('Comparar supermercados')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              'Melhor opção para sua lista',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.deepGreen,
              ),
            ),
            const SizedBox(height: 16),
            ...comparisons.asMap().entries.map((entry) {
              final index = entry.key;
              final comparison = entry.value;
              final market = MockMarkets.byId(comparison.marketId);
              final isWinner = index == 0;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isWinner ? AppColors.seed : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isWinner ? AppColors.seed : AppColors.cardBorder,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${index + 1}º ${market.name}',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: isWinner
                                        ? Colors.white
                                        : AppColors.deepGreen,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                          if (isWinner)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Recomendado',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppFormatters.brl(comparison.total),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: isWinner ? Colors.white : AppColors.seed,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppFormatters.distance(comparison.distanceKm),
                        style: TextStyle(
                          color: isWinner ? Colors.white70 : null,
                        ),
                      ),
                      if (comparison.savings != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Economia estimada: ${AppFormatters.brl(comparison.savings!)}',
                          style: TextStyle(
                            color: isWinner ? Colors.white : AppColors.accent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
