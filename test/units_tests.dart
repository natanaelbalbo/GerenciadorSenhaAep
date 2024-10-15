import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_senha/services/encryption_service.dart';
import 'package:gerenciador_senha/services/storage_service.dart';

void main() {
  group('EncryptionService Tests', () {
    test('Encrypts and Decrypts a password correctly', () {
      final encryptionService = EncryptionService();
      final originalPassword = 'minhaSenhaSegura';
      final encryptedPassword =
          encryptionService.encryptPassword(originalPassword);
      final decryptedPassword =
          encryptionService.decryptPassword(encryptedPassword);

      expect(decryptedPassword, originalPassword);
    });
  });

  group('StorageService Tests', () {
    test('Saves and retrieves a password correctly', () async {
      final storageService = StorageService();
      final key = 'senhaTeste';
      final password = 'minhaSenhaSegura';

      await storageService.savePassword(key, password);
      final retrievedPassword = await storageService.getPassword(key);

      expect(retrievedPassword, password);
    });

    test('Deletes a password correctly', () async {
      final storageService = StorageService();
      final key = 'senhaParaRemover';
      final password = 'minhaSenhaSegura';

      await storageService.savePassword(key, password);
      await storageService.deletePassword(key);
      final retrievedPassword = await storageService.getPassword(key);

      expect(retrievedPassword, null);
    });
  });
}
