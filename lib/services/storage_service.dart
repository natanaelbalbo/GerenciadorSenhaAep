import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:html' as html;
import 'dart:io';

class StorageService {
  Future<void> init() async {
    if (!kIsWeb) {
      final directory = await getApplicationDocumentsDirectory();
      print('Diretório do aplicativo: ${directory.path}');
    } else {
      print('Aplicação rodando na Web, localStorage será usado.');
    }
  }

  Future<void> savePassword(String key, String encryptedPassword) async {
    if (kIsWeb) {
      html.window.localStorage[key] = encryptedPassword;
      print('Senha salva na Web');
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$key.txt');
      await file.writeAsString(encryptedPassword);
      print('Senha salva no arquivo local');
    }
  }

  Future<String?> getPassword(String key) async {
    if (kIsWeb) {
      return html.window.localStorage[key];
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$key.txt');
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        return null;
      }
    }
  }

  Future<void> deletePassword(String key) async {
    if (kIsWeb) {
      html.window.localStorage.remove(key);
      print('Senha removida na Web');
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$key.txt');
      if (await file.exists()) {
        await file.delete();
        print('Senha removida do arquivo local');
      }
    }
  }

  List<String> getKeys() {
    if (kIsWeb) {
      return html.window.localStorage.keys
          .map((key) => key.toString())
          .toList();
    } else {
      return [];
    }
  }
}
