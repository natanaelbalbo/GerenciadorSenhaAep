import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_senha/services/encryption_service.dart';

void main() {
  final encryptionService = EncryptionService();

  test('A senha é criptografada e descriptografada corretamente', () {
    final senhaOriginal = 'minhaSenhaSegura123';
    
    // Criptografar a senha
    final senhaCriptografada = encryptionService.encryptPassword(senhaOriginal);
    
    // Descriptografar a senha
    final senhaDescriptografada = encryptionService.decryptPassword(senhaCriptografada);
    
    // Verificar se a senha original é igual à senha descriptografada
    expect(senhaDescriptografada, senhaOriginal);
  });
}
