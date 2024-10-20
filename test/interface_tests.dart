import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_senha/main.dart';
import 'package:gerenciador_senha/services/storage_service.dart';

void main() {
  final storageService = StorageService();

  testWidgets('Interface test for visibility toggle',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(storageService: storageService));

    // Save a password
    await tester.enterText(find.byType(TextField), 'minhaSenhaSegura');
    await tester.tap(find.text('Salvar Senha'));
    await tester.pump();

    // Tap the visibility button
    await tester.tap(find.byIcon(Icons.visibility));
    await tester.pump();

    // Check if the snackbar shows the correct message
    expect(find.text('Senha: minhaSenhaSegura'), findsOneWidget);
  });

  testWidgets('Interface test for delete button', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(storageService: storageService));

    // Save a password
    await tester.enterText(find.byType(TextField), 'senhaParaRemover');
    await tester.tap(find.text('Salvar Senha'));
    await tester.pump();

    // Delete the saved password
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Check if the password is no longer displayed
    expect(find.text('senhaParaRemover'), findsNothing);
  });
}
