import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_senha/main.dart';
import 'package:gerenciador_senha/services/storage_service.dart';

void main() {
  final storageService = StorageService();
  
  testWidgets('Full integration test for saving and retrieving a password',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(storageService: storageService));

    // Check if the initial screen is displayed
    expect(find.text('Gerenciador de senha'), findsOneWidget);

    // Enter a password and save
    await tester.enterText(find.byType(TextField), 'minhaSenhaSegura');
    await tester.tap(find.text('Salvar Senha'));
    await tester.pump();

    // Verify that the password is saved and displayed
    expect(find.text('minhaSenhaSegura'), findsOneWidget);
  });

  testWidgets('Integration test for detecting threats',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(storageService: storageService));

    // Simulate threat detection
    await tester.tap(find.text('Detectar Ameaça'));
    await tester.pump();

    // Check if a message is shown
    expect(find.text('Ameaça detectada!'), findsOneWidget);
  });
}
