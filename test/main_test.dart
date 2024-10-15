import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_senha/main.dart';
import 'package:gerenciador_senha/services/storage_service.dart';

void main() {
  testWidgets('Testa se a senha forte é gerada e exibida na interface',
      (WidgetTester tester) async {
    // Inicializar o StorageService falso ou mock
    final storageService = StorageService();

    // Inicializar o app
    await tester.pumpWidget(MyApp(storageService: storageService));

    // Verificar se o botão de gerar senha forte está presente
    expect(find.text('Gerar Senha Forte'), findsOneWidget);

    // Tocar no botão de gerar senha forte
    await tester.tap(find.text('Gerar Senha Forte'));
    await tester.pump();

    // Verificar se a senha foi gerada e exibida no campo de texto
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Testa se a senha é salva e aparece na lista',
      (WidgetTester tester) async {
    final storageService = StorageService();

    await tester.pumpWidget(MyApp(storageService: storageService));

    // Inserir uma senha manualmente
    await tester.enterText(find.byType(TextField), 'senhaTeste');
    await tester.tap(find.text('Salvar Senha'));
    await tester.pump();

    // Verificar se a senha aparece na lista de senhas
    expect(find.text('senhaTeste'), findsOneWidget);
  });
}
