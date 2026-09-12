import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercadex/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MercadexApp()));
    await tester.pumpAndSettle();
  }

  testWidgets('Home exibe Mercadex', (tester) async {
    await pumpApp(tester);
    expect(find.text('Mercadex'), findsWidgets);
  });

  testWidgets('Home possui ação de scanner', (tester) async {
    await pumpApp(tester);
    expect(find.text('Escanear código de barras'), findsOneWidget);
    expect(find.byKey(const Key('scan-barcode')), findsOneWidget);
  });

  testWidgets('Busca apresenta produtos', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();
    expect(find.text('Coca-Cola Original 2L'), findsOneWidget);
    expect(find.text('Arroz Tipo 1 5kg'), findsWidgets);
  });

  testWidgets('Produto apresenta preço', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Coca-Cola Original 2L'));
    await tester.pumpAndSettle();
    expect(find.text('R\$ 8,99'), findsWidgets);
    expect(find.textContaining('EAN: 7894900011517'), findsOneWidget);
  });

  testWidgets('Lista de compras apresenta botão de comparação', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Lista'));
    await tester.pumpAndSettle();
    expect(find.text('Comparar supermercados'), findsOneWidget);
  });
}
