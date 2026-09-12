import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercadex/main.dart';

void main() {
  testWidgets('exibe Mercadex na tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MercadexApp()),
    );

    expect(find.text('Mercadex'), findsOneWidget);
  });
}
