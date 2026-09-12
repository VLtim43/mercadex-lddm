import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mercadex/core/widgets/primary_button.dart';
import 'package:mercadex/core/widgets/product_card.dart';
import 'package:mercadex/features/markets/data/mock_markets.dart';
import 'package:mercadex/features/products/data/mock_products.dart';

class AddPricePage extends StatefulWidget {
  const AddPricePage({super.key, required this.productId});

  final String productId;

  @override
  State<AddPricePage> createState() => _AddPricePageState();
}

class _AddPricePageState extends State<AddPricePage> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  String? _marketId;
  String? _branchId;
  late final String _todayLabel;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _todayLabel =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preço registrado com sucesso!')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final product = MockProducts.byId(widget.productId);

    return Scaffold(
      appBar: AppBar(title: const Text('Informar preço')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              ProductCard(product: product),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _marketId,
                decoration: const InputDecoration(labelText: 'Supermercado'),
                items: [
                  for (final market in MockMarkets.all)
                    DropdownMenuItem(
                      value: market.id,
                      child: Text(market.name),
                    ),
                ],
                onChanged: (value) => setState(() {
                  _marketId = value;
                  _branchId = null;
                }),
                validator: (value) => value == null || value.isEmpty
                    ? 'Selecione o supermercado'
                    : null,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                key: ValueKey(_marketId),
                initialValue: _branchId,
                decoration: const InputDecoration(
                  labelText: 'Unidade',
                  hintText: 'Loja física do supermercado',
                ),
                items: [
                  for (final branch in MockMarkets.branchesForMarket(
                    _marketId ?? '',
                  ))
                    DropdownMenuItem(
                      value: branch.id,
                      child: Text(branch.unitLabel),
                    ),
                ],
                onChanged: (value) => setState(() => _branchId = value),
                validator: (value) => value == null || value.isEmpty
                    ? 'Selecione a unidade'
                    : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Preço',
                  prefixText: 'R\$ ',
                ),
                validator: (value) {
                  final parsed = double.tryParse(
                    (value ?? '').replaceAll(',', '.'),
                  );
                  if (parsed == null || parsed <= 0) {
                    return 'Informe um preço maior que zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Data'),
                child: Text(_todayLabel),
              ),
              const SizedBox(height: 24),
              PrimaryButton(label: 'Salvar preço', onPressed: _submit),
            ],
          ),
        ),
      ),
    );
  }
}
