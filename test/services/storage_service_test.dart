import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_senha/services/storage_service.dart';

void main() {
  final storageService = StorageService();

  test('A senha é salva corretamente e pode ser recuperada', () async {
    const key = 'testPasswordKey';
    const senhaCriptografada = 'senhaCriptografadaExemplo';

    // Salvar a senha no armazenamento
    await storageService.savePassword(key, senhaCriptografada);

    // Recuperar a senha do armazenamento
    final senhaRecuperada = await storageService.getPassword(key);

    // Verificar se a senha recuperada é igual à que foi salva
    expect(senhaRecuperada, senhaCriptografada);
  });

  test('A senha é removida corretamente do armazenamento', () async {
    const key = 'testPasswordKeyToDelete';
    const senhaCriptografada = 'senhaParaExcluir';

    // Salvar uma senha para depois removê-la
    await storageService.savePassword(key, senhaCriptografada);

    // Remover a senha
    await storageService.deletePassword(key);

    // Verificar se a senha foi removida
    final senhaRemovida = await storageService.getPassword(key);
    expect(senhaRemovida, isNull);
  });
}
