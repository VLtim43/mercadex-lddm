import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/constants/app_constants.dart';
import 'package:mercadex/core/theme/app_colors.dart';
import 'package:mercadex/core/widgets/mercadex_search_bar.dart';
import 'package:mercadex/core/widgets/primary_button.dart';
import 'package:mercadex/core/widgets/product_card.dart';
import 'package:mercadex/core/widgets/section_header.dart';
import 'package:mercadex/features/prices/data/mock_prices.dart';
import 'package:mercadex/features/products/data/mock_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final offers = MockPrices.nearbyOffers();
    final recent = MockPrices.recentlySearched();

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
              AppConstants.appName,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.deepGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Olá!',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Encontre o melhor preço perto de você.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            MercadexSearchBar(
              readOnly: true,
              onTap: () => context.push('/search'),
            ),
            const SizedBox(height: 14),
            PrimaryButton(
              key: const Key('scan-barcode'),
              label: 'Escanear código de barras',
              icon: Icons.qr_code_scanner,
              onPressed: () => context.push('/scanner'),
            ),
            const SizedBox(height: 28),
            const SectionHeader(title: 'Ofertas próximas'),
            const SizedBox(height: 12),
            ...offers.map(
              (offer) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ProductCard(
                  product: offer.product,
                  price: offer.price,
                  subtitle:
                      '${offer.branch.name} · ${AppFormatters.distance(offer.branch.distanceKm)}',
                  onTap: () => context.push('/product/${offer.product.id}'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const SectionHeader(title: 'Pesquisados recentemente'),
            const SizedBox(height: 12),
            ...recent.map(
              (product) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ProductCard(
                  product: product,
                  price: MockPrices.lowestFor(product.id)?.price,
                  onTap: () => context.push('/product/${product.id}'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Mais ${MockProducts.all.length} produtos no catálogo mockado.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
