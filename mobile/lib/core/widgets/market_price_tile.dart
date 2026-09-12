import 'package:flutter/material.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/features/markets/domain/market_branch.dart';
import 'package:mercadex/features/prices/domain/price_observation.dart';

class MarketPriceTile extends StatelessWidget {
  const MarketPriceTile({
    super.key,
    required this.branch,
    required this.observation,
    this.highlighted = false,
  });

  final MarketBranch branch;
  final PriceObservation observation;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(
              highlighted
                  ? Icons.emoji_events_outlined
                  : Icons.storefront_outlined,
              color: highlighted ? AppColors.warning : AppColors.seed,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${AppFormatters.distance(branch.distanceKm)} · ${observation.updatedLabel}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              AppFormatters.brl(observation.price),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: highlighted ? AppColors.seed : AppColors.deepGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
